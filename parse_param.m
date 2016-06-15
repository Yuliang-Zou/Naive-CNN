clear;close all;clc
%% Parse the ConvNet parameters loaded from caffe into better fit version
% Author: Yuliang Zou
% Date: 06/14/2016

%% Load parameters
load('conv1_w.mat');
load('conv1_b.mat');
load('conv2_w.mat');
load('conv2_b.mat');

%% Parse parameters into better fit version
% conv1 has 20 filters with 5 * 5 size 
W1 = zeros(5,5,20);
for i = 1:20
    W1(:,:,i) = conv1_w(i,1,:,:);
end
b1 = double(conv1_b');
% conv2 has 50 filters with 5 * 5 size 
W2 = zeros(5,5,20,50);
for k = 1:20
    for i = 1:50
        W2(:,:,k,i) = conv2_w(i,k,:,:);
    end
end
b2 = double(conv2_b');

save('parsed_param.mat','W1','W2','b1','b2');