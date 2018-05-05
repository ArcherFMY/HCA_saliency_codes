[![License](https://img.shields.io/badge/License-MIT%20LICENSE-brightgreen.svg)](LICENSE)
# Hierarchical Cellular Automata for Visual Saliency
![HCA pipline](https://github.com/ArcherFMY/HCA_saliency_codes/blob/master/figures-in-paper/pipeline.png "pipline")

### Introduction
HCA is a temporally evolving model to intelligently detect salient objects. This package contains the source codes to reproduce the experimental results of HCA. The source code is mainly written in MATLAB.

### Publication ![Pub.](https://img.shields.io/badge/Accepted-yes-brightgreen.svg)
Our paper "Hierarchical Cellular Automata for Visual Saliency" has been accepted for publication in _Iternational Journal of Computer Vision (IJCV)_, 2018. [[Online-Version]](http://link.springer.com/article/10.1007/s11263-017-1062-2)

### License
This code is released under the MIT License (refer to the LICENSE file for details).

### Contents
1. [Requirements: software](#requirements-software)
2. [Requirements: hardware](#requirments-hardware)
3. [Basic installation](#installation-sufficient-for-the-demo)
4. [Demo](#demo)
5. [Pre-computed saliency maps](#precomputed-saliency-maps)
6. [Visual comparison with state-of-the-art methods](#Visualization)

### Requirements: software
1. Requirements for `MatConvNet` (see: [MatConvNet installation instruction](http://www.vlfeat.org/matconvnet/install/)).

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

### Precomputed saliency maps
We provided pre-computed saliency maps for convenience. 

Included Datasets: `ECSSD`, `HKU-IS`, `DUT-OMRON`, `PASCAL-S` and `MSRA5000`.

[pre-computed saliency maps](http://pan.baidu.com/s/1bMa706)

### Visualization
![visualization](https://github.com/ArcherFMY/HCA_saliency_codes/blob/master/figures-in-paper/sm-com.png  "sm-com")

### FAQ
__Q__: Error when running `extract_fcn_im_features` at line(23)
__A__: We modified the `matconvnet-1.0-beta19/matlab/+dagnn/@DagNN/eval.m` to allow users to extract features from every layers (conv, pool, relu). So if you are using your own `matconvnet`, please modify the corresponding `.m` file as we did.
