---
layout: post
title: Improve performance of your multithreaded server using SO_REUSEPORT
tags: [C++, English]
type: article
description: In this post, I'll show a simple client/server written in C++ to see how SO_REUSEPORT works.
---

In this post, I'll show a simple client/server written in C++ to see how SO_REUSEPORT works.

<!-- more -->

First, refer to [The SO_REUSEPORT socket option [LWN.net]](https://lwn.net/Articles/542629/) on what SO_REUSEPORT is.

## Traditional approaches

> The first of the traditional approaches is to have a single listener thread that accepts all incoming connections and then passes these off to other threads for processing. The problem with this approach is that the listening thread can become a bottleneck in extreme cases.

I guess this means one thread which listens a socket passes the connection on to a thread pool?
If so, it would be obvious that the listener become a bottleneck.

> The second of the traditional approaches used by multithreaded servers operating on a single port is to have all of the threads (or processes) perform an accept() call on a single listening socket in a simple event loop.
>
> The problem with this technique, as Tom pointed out, is that when multiple threads are waiting in the accept() call, wake-ups are not fair, so that, under high load, incoming connections may be distributed across threads in a very unbalanced fashion.

I've implemented this case.

Here's the code for a server named `greeter_server.cpp`.
The server starts `NUM_THREADS` threads and each thread outputs a message to a different log file
so that we can see if there is a load imbalance. Each thread exits when it receives `exit` from a client.

```cpp
#include <arpa/inet.h>
#include <sys/socket.h>
#include <stdlib.h>
#include <unistd.h>

#include <iostream>
#include <fstream>
#include <sstream>
#include <thread>
#include <vector>

constexpr int BACKLOG = 5;
constexpr size_t BUFFER_SIZE = 32;
constexpr size_t NUM_THREADS = 4;

int receive(int socket_fd, std::vector<uint8_t>& data) {
  std::array<char, BUFFER_SIZE> buf;
  ssize_t rsize;
  while (true) {
    rsize = recv(socket_fd, &buf, buf.size(), 0);
    if (rsize == 0) {
      break;
    } else if (rsize == -1) {
      std::cerr << "recv() failed" << std::endl;
      return -1;
    } else {
      size_t original_size = data.size();
      data.reserve(data.size() + rsize);
      data.insert(data.begin() + original_size, buf.begin(), buf.begin() + rsize);
    }
  }
  return 0;
}

void run(int server_socket_fd) {
  std::ostringstream oss;
  oss << "thread_" << std::this_thread::get_id() << ".log";
  std::ofstream ofs(oss.str());

  sockaddr client_addr;
  socklen_t client_addrlen = sizeof(client_addr);
  while (true) {
    int client_socket_fd = accept(server_socket_fd, &client_addr, &client_addrlen);
    if (client_socket_fd < 0) {
      std::cerr << "accept() failed" << std::endl;
      break;
    }
    std::vector<uint8_t> data;
    if (receive(client_socket_fd, data) < 0) {
      close(client_socket_fd);
      continue;
    }
    std::string name(data.begin(), data.end());
    if (name == "exit") {
      break;
    }
    ofs << "Hello, " << name << std::endl;
    close(client_socket_fd);
  }
  ofs.close();
}

int main(int argc, char* argv[]) {
  uint16_t port = 12345;

  sockaddr_in addr;
  addr.sin_family = AF_INET;
  addr.sin_addr.s_addr = htonl(INADDR_ANY);
  addr.sin_port = htons(port);

  int socket_fd = socket(addr.sin_family, SOCK_STREAM, 0);
  if (socket_fd < -1) {
    std::cerr << "socket() failed" << std::endl;
    return EXIT_FAILURE;
  }
  if (bind(socket_fd, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
    std::cerr << "bind() failed" << std::endl;
    close(socket_fd);
    return EXIT_FAILURE;
  }
  if (listen(socket_fd, BACKLOG) < 0) {
    std::cerr << "listen() failed" << std::endl;
    close(socket_fd);
    return EXIT_FAILURE;
  }

  std::vector<std::thread> threads;
  threads.reserve(NUM_THREADS);
  for (size_t i = 0; i < NUM_THREADS; ++i) {
    threads.emplace_back(std::thread(run, socket_fd));
  }
  for (size_t i = 0; i < NUM_THREADS; ++i) {
    threads[i].join();
  }
  close(socket_fd);
  return EXIT_SUCCESS;
}
```

Compile and start the server.

```bash
$ g++ -std=c++11 -pthread -o server greeter_server.cpp && ./server
```

We can see that there is only one thread listening a socket.

```bash
$ lsof -i:12345
COMMAND  PID    USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
server  7728 ysk24ok    3u  IPv4 104288      0t0  TCP *:12345 (LISTEN)
```

Here's the code for a client named `greeter_client.cpp`.

```cpp
#include <arpa/inet.h>
#include <stdlib.h>
#include <unistd.h>

#include <iostream>
#include <vector>
#include <string>

int main(int argc, char* argv[]) {
  if (argc != 2) {
    std::cout << "Usage: ./command name" << std::endl;
  }
  std::string name(argv[1]);

  uint16_t port = 12345;

  sockaddr_in addr;
  addr.sin_family = AF_INET;
  addr.sin_addr.s_addr = htonl(INADDR_ANY);
  addr.sin_port = htons(port);

  int socket_fd = socket(addr.sin_family, SOCK_STREAM, 0);
  if (socket_fd < 0) {
    std::cerr << "socket() failed" << std::endl;
    return EXIT_FAILURE;
  }
  if (connect(socket_fd, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
    std::cerr << "connect() failed" << std::endl;
    return EXIT_FAILURE;
  }

  if (send(socket_fd, name.data(), name.size(), 0) < 0) {
    std::cerr << "connect() failed" << std::endl;
    close(socket_fd);
    return EXIT_FAILURE;
  }
  close(socket_fd);
  return EXIT_SUCCESS;
}
```

Compile the client,

```bash
$ g++ -std=c++11 -o client greeter_client.cpp
```

and run the following script.
This script starts 4 subprocesses and each thread sends 10000 requests.

```bash
#!/bin/bash

function run_client() {
  name=$1
  for i in {1..10000}; do
    ./client $name
  done
}

messages=(Alice Bob Charlie Dave)
pids=()
for message in ${messages[@]}; do
  run_client $message &
  pids+=($!)
done
for pid in ${pids[@]}; do
  wait $pid
  ./client exit
done
```

Here's the result.

```bash
$ time ./run_clients.sh

real    0m43.555s
user    1m17.955s
sys     0m38.667s
```

Here's the line counts for log files.
I don't see any load imbalance between threads,
but I guess things are different when there are more clients and more loads on the server.

```bash
$ wc -l thread_*.log
 10017 thread_139696696981248.log
  9937 thread_139696780531456.log
  9932 thread_139696788924160.log
 10114 thread_139696797316864.log
 40000 total
```

## Using SO_REUSEPORT

Here's the code named `greeter_multithreaded_server.cpp`.
Each thread creates a socket respectively and sets `SO_REUSEPORT` option to the socket.

```cpp
#include <arpa/inet.h>
#include <sys/socket.h>
#include <stdlib.h>
#include <unistd.h>

#include <iostream>
#include <fstream>
#include <sstream>
#include <thread>
#include <vector>

constexpr int BACKLOG = 5;
constexpr size_t BUFFER_SIZE = 32;
constexpr size_t NUM_THREADS = 4;

int receive(int socket_fd, std::vector<uint8_t>& data) {
  std::array<char, BUFFER_SIZE> buf;
  ssize_t rsize;
  while (true) {
    rsize = recv(socket_fd, &buf, buf.size(), 0);
    if (rsize == 0) {
      break;
    } else if (rsize == -1) {
      std::cerr << "recv() failed" << std::endl;
      return -1;
    } else {
      size_t original_size = data.size();
      data.reserve(data.size() + rsize);
      data.insert(data.begin() + original_size, buf.begin(), buf.begin() + rsize);
    }
  }
  return 0;
}

void run(uint16_t port) {
  int server_socket_fd = socket(AF_INET, SOCK_STREAM, 0);
  if (server_socket_fd < -1) {
    std::cerr << "socket() failed" << std::endl;
    return;
  }

  int optval = 1;
  setsockopt(server_socket_fd, SOL_SOCKET, SO_REUSEPORT, &optval, sizeof(optval));

  sockaddr_in addr;
  addr.sin_family = AF_INET;
  addr.sin_addr.s_addr = htonl(INADDR_ANY);
  addr.sin_port = htons(port);

  if (bind(server_socket_fd, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
    std::cerr << "bind() failed" << std::endl;
    return;
  }
  if (listen(server_socket_fd, BACKLOG) < 0) {
    std::cerr << "listen() failed" << std::endl;
    return;
  }

  std::ostringstream oss;
  oss << "thread_" << std::this_thread::get_id() << ".log";
  std::ofstream ofs(oss.str());

  sockaddr client_addr;
  socklen_t client_addrlen = sizeof(client_addr);
  while (true) {
    int client_socket_fd = accept(server_socket_fd, &client_addr, &client_addrlen);
    if (client_socket_fd < 0) {
      std::cerr << "accept() failed" << std::endl;
      return;
    }
    std::vector<uint8_t> data;
    if (receive(client_socket_fd, data) < 0) {
      close(client_socket_fd);
      continue;
    }
    std::string name(data.begin(), data.end());
    if (name == "exit") {
      break;
    }
    ofs << "Hello, " << name << std::endl;
    close(client_socket_fd);
  }
  ofs.close();
  close(server_socket_fd);
}

int main(int argc, char* argv[]) {
  uint16_t port = 12345;

  std::vector<std::thread> threads;
  threads.reserve(NUM_THREADS);
  for (size_t i = 0; i < NUM_THREADS; ++i) {
    threads.emplace_back(std::thread(run, port));
  }
  for (size_t i = 0; i < NUM_THREADS; ++i) {
    threads[i].join();
  }
  return EXIT_SUCCESS;
}
```

Compile and start the server.

```bash
$ g++ -std=c++11 -pthread -o server greeter_multithreaded_server.cpp && ./server
```

This time, we can see that there are 4 threads which are listening to the same port.

```bash
$ lsof -i:12345
COMMAND  PID    USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
server  9309 ysk24ok    3u  IPv4 615151      0t0  TCP *:12345 (LISTEN)
server  9309 ysk24ok    4u  IPv4 615863      0t0  TCP *:12345 (LISTEN)
server  9309 ysk24ok    5u  IPv4 617875      0t0  TCP *:12345 (LISTEN)
server  9309 ysk24ok    9u  IPv4 616757      0t0  TCP *:12345 (LISTEN)
```

Run the client script.
We can see that `sys` time decreased (38.7s -> 20.7s) and performance gets better.
I think this is because the kernel doesn't need to select a thread to accpet a connection.

```bash
$ time ./run_clients.sh

real    0m31.825s
user    1m9.546s
sys     0m20.720s
```

I can't see any load imbalance this time either.

```bash
$ wc -l thread_*.log
 10184 thread_139758137640704.log
  9928 thread_139758146033408.log
  9934 thread_139758154426112.log
  9954 thread_139758162818816.log
 40000 total
```

## References

- [The SO_REUSEPORT socket option [LWN.net]](https://lwn.net/Articles/542629/)
- [linux - How do SO_REUSEADDR and SO_REUSEPORT differ? - Stack Overflow](https://stackoverflow.com/questions/14388706/how-do-so-reuseaddr-and-so-reuseport-differ)
  - The best answer for this question explains pretty well about how SO_REUSEPORT works depending on the OS.
