![Build Status](https://travis-ci.org/vim/vim.svg?branch=master)
# Hierarchical Cellular Automata for Visual Saliency

### Introduction
HCA is a temporally evolving model to intelligently detect salient objects. This package contains the source codes to reproduce the experimental results of HCA reported in our [arXiv paper](https://comming soon). The source code is mainly written in MATLAB.

### License
This code is released under the MIT License (refer to the LICENSE file for details).

### Contents
1. [Requirements: software](#requirements-software)
2. [Requirements: hardware](#requirments-hardware)
3. [Basic installation](#installation-sufficient-for-the-demo)
4. [Demo](#demo)

### Requirements: software
1. Requirements for `MatConvNet` (see: [MatConvNet installation instruction](http://www.vlfeat.org/matconvnet/install/).

2. MATLAB.

3. [optional] CUDA (we use CPU to compute FCN features, if you want to use GPU, please compile `MatConvNet` with CUDA enabled).

4. Supported OS: the source code was tested on 64-bit Windows OS, it used [SLIC](http://ivrlwww.epfl.ch/supplementary_material/RK_SLICSuperpixels/index.html) to pre-process the images into super-pixels. Here we used the mex file in Windows OS, so the HCA code may not worked on Linux OS for now.
### Requirements: hardware
If you compile `MatConvNet` with CUDA supported, a GPU with at least 3G of memory suffices.
### Installation (sufficient for the demo)
1. Clone the HCA repository
```bash
git clone https://github.com/ArcherFMY/HCA_saliency_codes.git
```
2. cd to the root directory of HCA (we will call the directory `HCA_ROOT`), use MATLAB to run `compile_matconvnet.m`.

3. Download the pre-trained FCN-32s models from [here](http://www.vlfeat.org/matconvnet/models/pascal-fcn32s-dag.mat). Then put it under `$HCA_ROOT/matconvnet-1.0-beta19/Data/` folder with name `pascal-fcn32s-dag.mat`.

#### note 
Here we just compiled the `MatConvNet` with CPU. Users could compile with GPU supported yourself.

### Demo
To run the demo, simply run `$HCA_ROOT/runme.m` with MATLAB. Saliency maps will be saved in `$HCA_ROOT/saliencmaps/` folder.