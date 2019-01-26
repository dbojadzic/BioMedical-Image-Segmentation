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

path='case1.jpg';
D=im2double(imread(path));
Case=1;
A=D(:,:,2);
figure,imagesc(A);colormap gray;


%%%moving average filtering
C=moving_average_filter(A);


%%%%Segment the cell image directly
T1=zhenzhou_threshold_selection(double(C),17);
bC1=C>T1;
bC2=bwareaopen(bC1,100);
figure,imagesc(bC2);colormap gray;
%case 4 : 

%%%obtain the gradient image
A=gradient_image(C);


%%%%obtain the contraint edges
T1=zhenzhou_threshold_selection(double(A),17);
% T1=zhenzhou_threshold_selection_updated(double(A),2,27,1);
%case 5:
bC=A>T1;
bbC=bwareaopen(bC,100);


%%%%%Union method   ( CASE 1 )
obC=~bbC&~bC2;
bobC=bwareaopen(obC,30);
figure,imagesc(bobC);colormap gray;
%case 6 and 7:
%%%%shape filtering method
[Filtered_Seed] = zhenzhou_shape_filtering(bobC,Case,10);

%case 8:
%%%%Quantification method by iterative erosion method
[rxc1, ryc1] = zhenzhou_iterative_erosion(Filtered_Seed,1);

%case 9:
figure,imagesc(D);colormap gray;
hold on;
plot(double(ryc1),double(rxc1),'g.','MarkerSize',30);








