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
imshow(img);
img = imresize(img, [28, 28]);
% img = double(img) - 128;    % mean subtraction

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
% a bit more trouble than conv1
for l = 1:50
    for i = 1:8
        for j = 1:8
            temp = pool1_output(i:i+4,j:j+4,:) .* W2(:,:,:,l);
            conv2_output(i,j,l) = sum(sum(sum(temp)));
        end
    end
end

%% pool2
pool2_output = zeros(4,4,50);
for k = 1:50
    for i = 1:4
        for j = 1:4
            temp = max(conv2_output(2*i-1:2*i,2*j-1:2*j,k));
            pool2_output(i,j,k) = temp(1);
        end
    end
end

%% ip1
ip1_output = ip1W * pool2_output(:) + ip1b;

%% relu1
relu1_output = ip1_output;
relu1_output(relu1_output < 0) = 0;

%% ip2
ip2_output = ip2W * relu1_output + ip2b;

%% softmax
% temp = exp(ip2_output);
% score = temp / sum(temp);