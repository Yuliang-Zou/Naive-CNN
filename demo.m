clear;close all;clc
%% Naive-CNN
% Extract parameters of LeNet from caffe via load_caffemodel.py
% Then reimplement the CNN structure.
% Just for fun!
% Author: Yuliang Zou
% Date: 06/14/2016

%% Load parameters and image
% Please run parse_param.m, if you don't have such .mat file
load('parsed_param.mat');
img = imread('digit.png');
img = img(:,:,1) + img(:,:,2) + img(:,:,3);
img = imresize(img, [28, 28]);
img = double(img) - 128;    % mean subtraction

%% conv1
conv1_output = zeros(24,24,20);
for i = 1:20
    filter = rot90(W1(:,:,i),2);
    conv1_output(:,:,i) = conv2(img,filter,'valid') + b1(i);
end

%% pool1
pool1_output = zeros(12,12,20);
for k = 1:20
    for i = 1:12
        for j = 1:12
            temp = max(conv1_output(2*i-1:2*i,2*j-1:2*j,k));
            pool1_output(i,j,k) = temp(1);
        end
    end
end

%% conv2
conv2_output = zeros(8,8,50);
for i = 1:50
    % a bit more trouble than conv1
end