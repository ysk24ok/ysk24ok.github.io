---
layout: post
title: Passing pywrapfst objects to C++ using Cython
tags: [Cython, Python, C++, OpenFst]
type: article
description:
---

[OpenFst](http://www.openfst.org/twiki/bin/view/FST/WebHome) provides Python binding which can be imported by `import pywrapfst`.
In this article, I'll describe how to pass `pywrapfst` objects (such as `pywrapfst.MutableFst`) to C++ code using Cython.

<!-- more -->

Here's the directory structure. I'll describe each file content later.

```console
$ tree
.
├── Dockerfile
├── fstsample.pyx
├── include
│   └── base
│       └── integral_types.h
├── setup.py
└── src
    ├── fstsample.cpp
    └── fstsample.hpp
```

# Prep

## Build Docker image

I've prepared the Dockerfile to make it easy to try without installing OpenFst to my host machine.
OpenFst 1.8.0 requires gcc >= 7 so `centos:centos8` is used as a base image.

```dockerfile
FROM centos:centos8

RUN dnf update -y \
 && dnf group install -y "Development Tools" \
 && dnf install -y python36-devel \
 && dnf clean all \
 && rm -rf /var/cache/dnf/*
RUN pip3 install -U pip setuptools \
 && pip3 install cython \
 && rm -rf ~/.cache/pip
```

Build a Docker image and start a container.

```console
$ docker build --no-cache -t openfst_builder .
$ docker run --rm -it -v ${PWD}:${PWD} -w ${PWD} openfst_builder /bin/bash
```

Check the versions.

```console
# python3 --version
Python 3.6.8
# pip3 list
Package         Version
--------------- -------
Cython          0.29.21
gpg             1.10.0
pip             20.2.4
python-dateutil 2.6.1
rpm             4.14.2
setuptools      50.3.2
six             1.11.0
```

## Build OpenFst

Fetch `OpenFst-1.8.0.tar.gz`, which is the latest version as of November 2020. OpenFst tarballs can be downloaded [here](http://www.openfst.org/twiki/bin/view/FST/FstDownload).

```console
# curl -LO http://www.openfst.org/twiki/pub/FST/FstDownload/openfst-1.8.0.tar.gz
# tar zxvf openfst-1.8.0.tar.gz
```

Build and install OpenFst. Be sure to run `configure` with `--enable-python` option so that Python binding is also be built.

```console
# pushd openfst-1.8.0
# ./configure --enable-python
# make -j4
# make install
# popd
```

Now binaries, headers and libraries are installed in `/usr/local` . Also, Python binding is installed in `/usr/local/lib/python3.6/site-packages`.

```console
# tree /usr/local/lib/python3.6/
/usr/local/lib/python3.6
└── site-packages
    ├── pywrapfst.la
    └── pywrapfst.so
```

So I can import `pywrapfst` and use its functions.

```console
# python3
>>> import pywrapfst
>>>
```

## Compile an example FST

Follow [the instruction](http://www.openfst.org/twiki/bin/view/FST/FstQuickTour#CreatingFsts).

```console
$ cat >text.fst <<EOF
0 1 a x .5
0 1 b y 1.5
1 2 c z 2.5
2 3.5
EOF
$ cat >isyms.txt <<EOF
<eps> 0
a 1
b 2
c 3
EOF
$ cat >osyms.txt <<EOF
<eps> 0
x 1
y 2
z 3
EOF
$ fstcompile --isymbols=isyms.txt --osymbols=osyms.txt text.fst sample.fst
```

This FST can be read in Python using `pywrapfst` .

```py
# python3
>>> import pywrapfst
>>> fst = pywrapfst.Fst.read('sample.fst')
>>> type(fst)
<class 'pywrapfst.MutableFst'>
>>> print(fst)
0       1       1       1       0.5
0       1       2       2       1.5
1       2       3       3       2.5
2       3.5
```

# Build C++ wrapper

I have following C++ files which provides a feature similar to `fstinfo` command.

src/fstsample.hpp

```cpp
#ifndef FSTSAMPLE_HPP_
#define FSTSAMPLE_HPP_

#include <fst/script/fst-class.h>

#include <memory>

namespace fstsample {

void PrintFstInfo(std::shared_ptr<fst::script::FstClass> fst);

}  // namespace fstsample

#endif  // FSTSAMPLE_HPP_
```

src/fstsample.cpp

```cpp
#include "fstsample.hpp"

#include <fst/script/info.h>

#include <string>

namespace fstsample {

void PrintFstInfo(std::shared_ptr<fst::script::FstClass> fst) {
  bool test_properties = true;
  const std::string arc_filter = "any";
  const std::string info_type = "auto";
  bool verify = true;
  fst::script::Info(*fst, test_properties, arc_filter,
                    info_type, verify);
}

}  // namespace fstsample
```

Of course I can use `PrintFstInfo` function from C++, but how can I use this in Python?
The answer is, to write C++ wrapper in Cython.

fstsample.pyx

```pyx
# distutils: language = c++
# cython: language_level=3

cimport pywrapfst
from libcpp.memory cimport shared_ptr


cdef extern from "src/fstsample.hpp" namespace "fstsample":

    void PrintFstInfo(shared_ptr[pywrapfst.fst.MutableFstClass])


def print_fst_info(pywrapfst.MutableFst fst):
    PrintFstInfo(fst._mfst)
```

What this `.pyx` file does is:

* `# distutils: language = c++` line shows that the `.pyx` file must be compiled as C++.
* `cimport pywrapfst` imports `pywrapfst.pxd`, which is in `src/extensions/python` directory of OpenFst.
* `cdef extern from "src/fstsample.hpp"` exposes functions in `src/fstsample.hpp` to Cython.
  But that's not enough, and I have to declare it by `void PrintFstInfo(shared_ptr[pywrapfst.fst.MutableFstClass])])` so that Cython can use it.
* `print_fst_info` is a function which can be called from Python.
  As you see above, the type of FST is `pywrapfst.MutableFst` so the argument type is also `pywrapfst.MutableFst`.
  `pywrapfst.MutableFst` has `_mfst` member variable whose type is `pywrapfst.fst.MutableFstClass` and it's passed to `PrintFstInfo()`.

setup.py

```py
from distutils.core import Extension, setup
from Cython.Build import cythonize


extensions = [
    Extension(
        "fstsample",
        sources=["fstsample.pyx", "src/fstsample.cpp"],
        include_dirs=[
            # to include 'base/integer_types.h'
            "include",
            # to include fst/extensions headers
            "openfst-1.8.0/src/include",
        ],
        libraries=["fstscript"],
        extra_compile_args=["-std=c++17"]
    )
]

setup(
    name="fstsample",
    ext_modules=cythonize(
        extensions,
        # to include *.pxd
        include_path=["openfst-1.8.0/src/extensions/python"],
    )
)
```

Here are some notes about setup.py:

* `pywrapfst.pxd` depends on `cintegral_type.pxd` which depends on `base/integral_types.h`.
  It seems [or-tools](https://github.com/google/or-tools) include this header so I've manually copy it to `include/base/integral_types.h`
  and added `"include"` to `include_dirs` argument of `Extension`.
* Since headers in `src/include/fst/extensions` are not installed by `make install`, `"openfst-1.8.0/src/include"` is also added to `include_dirs` argument.
* `"openfst-1.8.0/src/extensions/python"` is added to `include_path` argument of `cythonize`
  so that `.pxd` files such as `pywrapfst.pxd` can be included at compile time.

Then, build the wrapper. `--build-lib` option specifies where to output the `.so` file. Without this option, `.so` will be in `build/lib.linux-x86_64-3.6/`.

```console
# python3 setup.py build_ext --build-lib .
# ls *.so
fstsample.cpython-36m-x86_64-linux-gnu.so
```

Finally, `fstsample` module can be imported and `print_fst_info()` function can be called from Python, which internally calls `fstsample::PrintFstInfo` C++ function.

```py
# python3
>>> import pywrapfst
>>> import fstsample
>>> fst = pywrapfst.Fst.read('sample.fst')
>>> fstsample.print_fst_info(fst)
fst type                                          vector
arc type                                          standard
input symbol table                                none
output symbol table                               none
# of states                                       3
# of arcs                                         3
initial state                                     0
# of final states                                 1
# of input/output epsilons                        0
# of input epsilons                               0
# of output epsilons                              0
input label multiplicity                          1
output label multiplicity                         1
# of accessible states                            3
# of coaccessible states                          3
# of connected states                             3
# of connected components                         1
# of strongly conn components                     3
input matcher                                     y
output matcher                                    y
input lookahead                                   n
output lookahead                                  n
expanded                                          y
mutable                                           y
error                                             n
acceptor                                          y
input deterministic                               y
output deterministic                              y
input/output epsilons                             n
input epsilons                                    n
output epsilons                                   n
input label sorted                                y
output label sorted                               y
weighted                                          y
cyclic                                            n
cyclic at initial state                           n
top sorted                                        y
accessible                                        y
coaccessible                                      y
string                                            n
weighted cycles                                   n
```

# references

* [OpenFst](http://www.openfst.org/twiki/bin/view/FST/WebHome)
* [9. API Reference — Python 3.9.0 documentation](https://docs.python.org/3/distutils/apiref.html#distutils.core.Extension)
* [Using C++ in Cython — Cython 3.0a6 documentation](https://cython.readthedocs.io/en/latest/src/userguide/wrapping_CPlusPlus.html)
* [Sharing Declarations Between Cython Modules — Cython 3.0a6 documentation](https://cython.readthedocs.io/en/latest/src/userguide/sharing_declarations.html)
