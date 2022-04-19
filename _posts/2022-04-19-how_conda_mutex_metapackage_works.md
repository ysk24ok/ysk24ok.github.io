---
layout: post
title: How Conda's mutex metapackage works to install variants of a package
tags: [Conda, English]
type: article
description: 
    In this post, I'll use PyTorch as an example
    and describe how Conda mutex metapackage works to install variants of a package.
---

In this post, I'll use PyTorch as an example
and describe how Conda's mutex metapackage works to install variants of a package.

<!-- more -->

## PyTorch installation

When you run `conda install -c pytorch pytorch`, you'll get PyTorch with CUDA support.

```
  blas               pkgs/main/linux-64::blas-1.0-mkl
  cudatoolkit        pkgs/main/linux-64::cudatoolkit-11.3.1-h2bc3f7f_2
  intel-openmp       pkgs/main/linux-64::intel-openmp-2022.0.1-h06a4308_3633
  libuv              pkgs/main/linux-64::libuv-1.40.0-h7b6447c_0
  mkl                pkgs/main/linux-64::mkl-2022.0.1-h06a4308_117
  pytorch            pytorch/linux-64::pytorch-1.11.0-py3.9_cuda11.3_cudnn8.2.0_0
  pytorch-mutex      pytorch/noarch::pytorch-mutex-1.0-cuda
  typing_extensions  pkgs/main/noarch::typing_extensions-4.1.1-pyh06a4308_0
```

When you run `conda install -c pytorch pytorch cpuonly` or `conda insall -c pytorch pytorch pytorch-mutex=*=cpu`, you'll get PyTorch without CUDA support.

```
  blas               pkgs/main/linux-64::blas-1.0-mkl
  cpuonly            pytorch/noarch::cpuonly-2.0-0
  intel-openmp       pkgs/main/linux-64::intel-openmp-2022.0.1-h06a4308_3633
  libuv              pkgs/main/linux-64::libuv-1.40.0-h7b6447c_0
  mkl                pkgs/main/linux-64::mkl-2022.0.1-h06a4308_117
  pytorch            pytorch/linux-64::pytorch-1.11.0-py3.9_cpu_0
  pytorch-mutex      pytorch/noarch::pytorch-mutex-1.0-cpu
  typing_extensions  pkgs/main/noarch::typing_extensions-4.1.1-pyh06a4308_0
```

What are  `cpuonly` and `pytorch-mutex`?

## mutex metapackage

They are mutex metapackages which control mutual exclusivity amoung packages.
See [this page](https://docs.conda.io/projects/conda/en/latest/user-guide/concepts/packages.html#mutex-metapackages) for more info on mutex metapackages.

When you try to install `pytorch` with `cpuonly` or `pytorch-mutex=*=cpu`,
you'll get `pytorch-1.11.0-py3.9_cpu_0` which depends on `pytorch-mutex=*=cpu`.
`cpuonly` is just a small metapackage which depends on `pytorch-mutex=*=cpu`.

On the other hand, when you try to install `pytorch` with `pytorch-mutex=*=cuda` or nothing,
you'll get `pytorch-1.11.0-py3.9_cuda11.3_cudnn8.2.0_0` which depends on `pytorch-mutex=*=cuda`.

See links below for the `meta.yml` of the packages.

- [meta.yml of pytorch](https://github.com/pytorch/builder/blob/main/conda/pytorch-nightly/meta.yaml)
- [meta.yml of pytorch-mutex](https://github.com/pytorch/builder/blob/main/conda/pytorch-mutex/meta.yaml)
- [meta.yml of cpuonly](https://github.com/pytorch/builder/blob/main/conda/cpuonly/meta.yaml)


## To install PyTorch with support for an another version of CUDA

`pytorch-mutex` cannot control CUDA version. `pytorch` has some build variations which depend on the specific `cudatoolkit`. 
If you want to install `pytorch` with CUDA 10.2 support, run `conda install -c pytorch pytorch cudatoolkit=10.2` and you'll get the following packages.

```
  blas               pkgs/main/linux-64::blas-1.0-mkl
  cudatoolkit        pkgs/main/linux-64::cudatoolkit-10.2.89-hfd86e86_1
  intel-openmp       pkgs/main/linux-64::intel-openmp-2022.0.1-h06a4308_3633
  libuv              pkgs/main/linux-64::libuv-1.40.0-h7b6447c_0
  mkl                pkgs/main/linux-64::mkl-2022.0.1-h06a4308_117
  pytorch            pytorch/linux-64::pytorch-1.11.0-py3.9_cuda10.2_cudnn7.6.5_0
  pytorch-mutex      pytorch/noarch::pytorch-mutex-1.0-cuda
  typing_extensions  pkgs/main/noarch::typing_extensions-4.1.1-pyh06a4308_0
```