# Hierarchical Cellular Automata for Visual Saliency

## Introduction
HCA is a temporally evolving model to intelligently detect salient objects. This package contains the source codes to reproduce the experimental results of HCA reported in our [arXiv paper](comming soon). The source code is mainly written in MATLAB.

## Usage
- Supported OS: the source code was tested on 64-bit Windows OS, it used [SLIC](http://ivrlwww.epfl.ch/supplementary_material/RK_SLICSuperpixels/index.html) to pre-process the images into super-pixels. Here we used the mex file in Windows OS, so the HCA code may not worked on Linux OS.
- Dependencies:
	- Deep learning framework [MatConvNet](http://www.vlfeat.org/matconvnet/) and all its dependencies.
	- Cuda enabled GPUs
- Installation:
	- Install MatConvNet: Please follow the  [installation instruction of MatConvNet](http://www.vlfeat.org/matconvnet/install/) to compile the MatConvNet on your computer. Or you can just use the provided script [compile_matconvnet.m](https://github.com/ArcherFMY/HCA_saliency_codes/blob/master/compile_matconvnet.m) to do this.
	- Download the FCN-32s network from [here](http://www.vlfeat.org/matconvnet/models/pascal-fcn32s-dag.mat), and put it under the `./matconvnet-1.0-beta19/Data/` directory.
	- Run the demo code `runme.m` to get the results. Saliency maps are putted in `./saliencymaps/` directory. If you choose to use prior maps, please create a new folder named `priors` in the root directory, the names should be the same with the corresponding images.