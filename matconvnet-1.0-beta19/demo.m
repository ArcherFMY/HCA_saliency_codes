clc;clear;
run matlab/vl_setupnn;

net = load('Data\pascal-fcn32s-dag.mat');
im = imread('0001.jpg');
im_ = imresize(single(im),net.meta.normalization.imageSize(1:2));
im_ = im_ - repmat(net.meta.normalization.averageImage,[500 500]);

net = vl_simplenn_tidy(net);