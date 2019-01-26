clc;
clear all;
close all;
[I,path]=uigetfile('*.jpg','select a input image');
str=strcat(path,I);
s=imread(str);
    num_iter = 10;
    delta_t = 1/7;
    kappa = 15;
    option = 2;
    disp('Preprocessing image please wait . . .');
    ad = anisodiff(s,num_iter,delta_t,kappa,option);
    figure, subplot 221, imshow(s,[]),title('Input image'), subplot 222, imshow(ad,[]),title('Fitered image'),

  
m = zeros(size(ad,1),size(ad,2));          %-- create initial mask 

m(90:100,105:135) = 1;  % main 2


ad = imresize(ad,.5);  %-- make image smaller 
m = imresize(m,.5); %     for fast computation



subplot(2,2,3); title('Segmentation');

seg = svm(ad, m, 50); %-- Run segmentation

subplot(2,2,4); imshow(seg); title('Segmented Tumor');



