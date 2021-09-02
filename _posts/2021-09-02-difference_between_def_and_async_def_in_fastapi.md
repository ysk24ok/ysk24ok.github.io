---
layout: post
title: The difference between def and async def in FastAPI
tags: [FastAPI]
type: article
description: I got curious about the difference between `def` and `async def` for path operations of FastAPI especially when the task is purely CPU-intensive and checked what's going on behind the scenes.
---

I got curious about the difference between `def` and `async def` for path operations of [FastAPI](https://github.com/tiangolo/fastapi) especially when the task is purely CPU-intensive and checked what's going on behind the scenes.

<!-- more -->

# async vs sync

[This page](https://fastapi.tiangolo.com/async) refers to when we should and should not use `async def`.

It says, if a path operation contains a function call with I/O which can be called with `await`, we should use `async def`, and if a path operation contains an I/O call which cannot be called with `await`, we should use `def` .

But what if a path operation contains only purely CPU-intensive task?
What is the difference between `async def` and `def` in that case?

[Techical Details section of the page](https://fastapi.tiangolo.com/async/#path-operation-functions) says

> When you declare a path operation function with normal `def` instead of `async def`, it is run in an external threadpool that is then awaited, instead of being called directly (as it would block the server).

It can be read that FastAPI can process requests without blocking by leveraging a threadpool when the path operation is declared with `def`.

Let's try it out.

# Experiment

## Environment

My laptop is Thinkpad X1 Carbon Gen5 (old model, by the way) and has 2.50 GHz 2 physical cores and 4 logical cores.

I used Ubuntu 20.04 on WSL2.

```sh
$ cat /etc/debian_version
bullseye/sid
```

Python packages are as follows.

```sh
$ pip freeze
asgiref==3.4.1
click==8.0.1
fastapi==0.68.1
h11==0.12.0
pkg_resources==0.0.0
pydantic==1.8.2
starlette==0.14.2
typing-extensions==3.10.0.2
uvicorn==0.15.0
```

## Code

`main.py` is like this. Here `root()` is purely CPU-intensive task.
The path accepts `client_id` as a path parameter and logs are output at the beginning and end of the function to show when the server starts and ends processing a request.

```python
from fastapi import FastAPI


app = FastAPI()


@app.get('/{client_id}')
async def root(client_id):
    print(f'Start processing a request from client: {client_id}')
    count = 0
    for _ in range(100000000):
        count += 1
    print(f'Start processing a request from client: {client_id}')
    return {}
```

This client shell script sends GET request endlessly.
This is executed in several terminals to check 

```sh
while :
do
curl -X GET 127.0.0.1:8000 -d "{"client"}"
done
```


## Result

### When `async def` is used

Start the uvicorn server. Note that the number of uvicorn workers is one.

```console
$ uvicorn main:app
```

Then, execute the shell script in multiple terminals. I used 4.

The server log will be like this. It shows the server processes requests sequentially.
Since there is no `await` call in this function, the Python runtime doesn't switch coroutines, which leads to sequential processing.

```
Start processing a request from client: 1
End processing a request from client: 1
INFO:     127.0.0.1:35222 - "GET /1 HTTP/1.1" 200 OK
Start processing a request from client: 2
End processing a request from client: 2
INFO:     127.0.0.1:35224 - "GET /2 HTTP/1.1" 200 OK
Start processing a request from client: 3
End processing a request from client: 3
INFO:     127.0.0.1:35226 - "GET /3 HTTP/1.1" 200 OK
Start processing a request from client: 4
End processing a request from client: 4
INFO:     127.0.0.1:35228 - "GET /4 HTTP/1.1" 200 OK
```

Here is the output of `top -H -p [pid]` . `-H` is a option to show indivisual threads.
There is only one thread running because an event loop for asyncronous processing is executed in a single thread.

```
top - 19:16:12 up  4:25,  0 users,  load average: 0.56, 0.45, 0.30
Threads:   1 total,   1 running,   0 sleeping,   0 stopped,   0 zombie
%Cpu(s): 25.0 us,  0.6 sy,  0.0 ni, 73.4 id,  0.0 wa,  0.0 hi,  1.0 si,  0.0 st
MiB Mem :   6232.0 total,   1849.7 free,   1036.4 used,   3345.9 buff/cache
MiB Swap:   2048.0 total,   2048.0 free,      0.0 used.   4569.2 avail Mem

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
 2950 ysk24ok   20   0   40052  30800  13120 R  99.9   0.5   0:12.54 uvicorn
```

### When `def` is used

Update `main.py` to change `async def` to `def` and start the server.

```console
$ uvicorn main:app
```

Then, execute the client shell script in 4 terminals.
Unlink `async def` , the server processes requests concurrently.

```
Start processing a request from client: 1
Start processing a request from client: 2
Start processing a request from client: 3
Start processing a request from client: 4
End processing a request from client: 1
INFO:     127.0.0.1:35238 - "GET /1 HTTP/1.1" 200 OK
Start processing a request from client: 1
End processing a request from client: 2
INFO:     127.0.0.1:35240 - "GET /2 HTTP/1.1" 200 OK
Start processing a request from client: 2
End processing a request from client: 3
INFO:     127.0.0.1:35242 - "GET /3 HTTP/1.1" 200 OK
Start processing a request from client: 3
End processing a request from client: 4
INFO:     127.0.0.1:35244 - "GET /4 HTTP/1.1" 200 OK
```

Here is the output of `top -H` .
There are 5 threads (1 parent thread and 4 child threads).
This is the "threadpool" the document is talking about.
When a new request arrives and existing threads are in execution, a new thread is spawned and begins to process the request.
Thus the server works as if it's asyncrounous.
But all threads utilize only 100% of CPU probably because of Python's GIL (global interpreter lock).

```
top - 19:20:47 up  4:30,  0 users,  load average: 0.18, 0.36, 0.32
Threads:   5 total,   1 running,   4 sleeping,   0 stopped,   0 zombie
%Cpu(s): 25.3 us,  0.9 sy,  0.0 ni, 73.2 id,  0.0 wa,  0.0 hi,  0.7 si,  0.0 st
MiB Mem :   6232.0 total,   1862.2 free,   1023.3 used,   3346.4 buff/cache
MiB Swap:   2048.0 total,   2048.0 free,      0.0 used.   4582.2 avail Mem

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
 4239 ysk24ok   20   0  334980  30884  13100 R  30.6   0.5   0:01.32 uvicorn
 4252 ysk24ok   20   0  334980  30884  13100 S  29.2   0.5   0:00.88 uvicorn
 4232 ysk24ok   20   0  334980  30884  13100 S  27.2   0.5   0:02.09 uvicorn
 4259 ysk24ok   20   0  334980  30884  13100 S  14.0   0.5   0:00.42 uvicorn
 4166 ysk24ok   20   0  334980  30884  13100 S   0.3   0.5   0:00.31 uvicorn
```

Thread switching which happens at the kernel level is more expensive than couroutine switching which happens at the user level.
Processing lots of requests at the same time generates the large number of threads and all of them compete for CPU, which might cause performace degradation.


# Summary

I think we should use `async def` if the path operation is CPU-intensive and the operation has to process lots of requests simultaneously, because using `def` creates lots of threads which can cause CPU contention.
