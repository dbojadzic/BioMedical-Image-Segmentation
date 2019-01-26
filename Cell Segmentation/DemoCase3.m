%%%This program is written by Zhenzhou Wang, for more information please
%%%contact: zzwangsia@yahoo.com or wangzhenzhou@sia.cn
%%%This program is free for academic use only.
%%%Please reference and acknowledge the following papers:
%%%%%%[1]Z.Z. Wang, "A semi-automatic method for robust and efficient identification of neighboring muscle cells," Pattern Recognition, Vol. 53, pp.300-312, 2016
%%%%%%[2] Z.Z. Wang, "A new approach for segmentation and quantification of
%%%%%% cells or nanoparticles", IEEE T IND INFORM, 12(3), pp.962-971,2016
close all;
clear all;
clc;

path='case3.jpg';
D=im2double(imread(path));
Case=3;
A=D(:,:,2);
figure,imagesc(A);colormap gray;



%%%moving average filtering
C=moving_average_filter(A);
%%%%Segment the cell image directly
T1=zhenzhou_threshold_selection(double(C),27);

bC1=C>T1;
bC2=bwareaopen(bC1,100);
figure,imagesc(bC2);colormap gray;


%%%%%Union method   ( CASE 3)
bC2(745:end,654:end)=0; %%%remove the text manually
obC=bC2;
figure,imagesc(obC);colormap gray;


%%%%shape filtering method
[Filtered_Seed] = zhenzhou_shape_filtering(obC,Case,16);

%%%%Quantification method by iterative erosion method
[rxc1, ryc1] = zhenzhou_iterative_erosion(Filtered_Seed,1);

figure,imagesc(D);colormap gray;
hold on;
plot(double(ryc1),double(rxc1),'ro','MarkerSize',10,'LineWidth',2);












