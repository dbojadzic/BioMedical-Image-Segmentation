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
    figure, subplot 121, imshow(s,[]),title('Input image'), subplot 122, imshow(ad,[]),title('Fitered image'),
   
 fprintf('\nPress R \n');
pause;

%PART 2

 disp('classifying tumor boundary');
  
m = zeros(size(ad,1),size(ad,2));          %-- create initial mask 

m(90:100,110:135) = 1;  % main 2


ad = imresize(ad,.5);  %-- make image smaller 
m = imresize(m,.5);  %     for fast computation
figure
subplot(2,2,1); imshow(ad,[]); title('Input Image');
% bounding box start
subplot(2,2,2); imshow(ad,[]);
hold on
if(strcmp(I,'a1.jpg')||strcmp(I,'a.jpg'))
    rectangle('Position',[40 47 20 22],'EdgeColor','y'); %a1
end;
if(strcmp(I,'b1.jpg')||strcmp(I,'b.jpg'))
    rectangle('Position',[61 49 18 20],'EdgeColor','y');  %b1
end;
if(strcmp(I,'c1.jpg')||strcmp(I,'c.jpg'))
    rectangle('Position',[35 26 34 40],'EdgeColor','y');  %c1
end;

hold off
title('Locating Bounding box');
% bounding box end


subplot(2,2,3); title('Segmentation');

seg = svm(ad, m, 50); %-- Run segmentation

subplot(2,2,4); imshow(seg); title('Segmented Tumor');
