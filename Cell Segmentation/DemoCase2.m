%%%This program is written by Zhenzhou Wang, for more information please
%%%contact: zzwangsia@yahoo.com or wangzhenzhou@sia.cn
%%%This program is free for academic use only.
%%%Please reference and acknowledge the following paper:
%%%%%%[1]Z.Z. Wang, "A semi-automatic method for robust and efficient identification of neighboring muscle cells," Pattern Recognition, Vol. 53, pp.300-312, 2016
%%%%%%[2] Z.Z. Wang, "A new approach for segmentation and quantification of
%%%%%% cells or nanoparticles", IEEE T IND INFORM, 12(3), pp.962-971,2016

close all;
clear all;
clc;

path='case2.tif';
D=im2double(imread(path));
Case=2;

A=D(:,:,1);
figure,imagesc(A);colormap gray;


%%%moving average filtering
C=moving_average_filter(A);
%%%obtain the gradient image
A=gradient_image(C);
%%%%obtain the contraint edges
T1=zhenzhou_threshold_selection(double(A),9);
% T1=zhenzhou_threshold_selection_updated(double(A),2,27,1);


bC=A>T1;
bbC=bwareaopen(bC,100);
figure,imagesc(bbC);colormap gray;


%%%%%Union method   ( CASE 2 )
obC=~bbC;figure,imagesc(obC);

% bobC=bwareaopen(obC,50);
bobC=zhenzhou_clutter_filter(obC,4);
figure,imagesc(bobC);colormap gray;


%%%%shape filtering method
[Filtered_Seed] = zhenzhou_shape_filtering(bobC,Case,15);

%%%%Quantification method by iterative erosion method
[rxc1, ryc1] = zhenzhou_iterative_erosion(Filtered_Seed,1);

figure,imagesc(D);colormap gray;
hold on;
plot(double(ryc1),double(rxc1),'g.','MarkerSize',30);








