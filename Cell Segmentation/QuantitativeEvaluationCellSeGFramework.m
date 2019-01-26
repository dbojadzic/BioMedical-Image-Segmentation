%%%This program is written by Zhenzhou Wang, for more information please
%%%contact: zzwangsia@yahoo.com or wangzhenzhou@sia.cn
%%%This program is free for academic use only.
%%%Please reference and acknowledge the following paper:
%%%%%%[1]Z.Z. Wang, "A semi-automatic method for robust and efficient identification of neighboring muscle cells," Pattern Recognition, Vol. 53, pp.300-312, 2016
%%%%%%[2] Z.Z. Wang, "A new approach for segmentation and quantification of
%%%%%% cells or nanoparticles", IEEE T IND INFORM, 12(3), pp.962-971,2016

%%Please change the name %cho01.png from 1 to 20 to evaluate the
%%quantification accuracy. These cell images are from Broad Bioimage
%%Benchmark Collection at
%%http://data.broadinstitute.org/bbbc/image_sets.html
close all;
clear all;
clc;

path='cho01.png';
A1=im2double(imread(path));
Case=1;
A=A1(:,:,1);
%%%moving average filtering
C=moving_average_filter(A);

T2=zhenzhou_threshold_selection(double(C),11);
bC2=C>T2;


%%%obtain the gradient image
A=gradient_image(C);

T1=zhenzhou_threshold_selection(double(A),11);
bC=A>T1;

bC(1:5,:)=0;
bC(:,1:5)=0;
bC(end-5:end,:)=0;
bC(:,end-5:end)=0;
obC=imfill(bC,'holes');
obC=imerode(obC,strel('disk',3));
bbC=bwareaopen(obC,1200);


%%%%the union method
bbcc=bbC.*bC2;
bbcc1=imfill(bbcc,'holes');
bbcc=bwareaopen(bbcc1,200);


seed=bbcc;
%%%%the proposd noise blob removing filter
se = strel('disk',1);
for i=1:5
    seed=imerode(seed,se);
end;
for i=1:5
    seed=imdilate(seed,se);
end;
isize=size(seed);
S1=isize(1);
S2=isize(2);
%%%%%%%%%%%%%%%%%%%%separate the cells
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mask_f=zeros(S1,S2);
mask_temp= seed;
%%%%%%%%%%%%%%%%%%%separate cells based on size threshold
a_temp=seed;
for i=1:1
    a_temp = imerode(a_temp, se);
    a_temp= bwareaopen(a_temp,2);
end;

s  = regionprops(a_temp, 'Area');
areas = cat(1, s.Area);
T_s=round(mean(areas));
T_s=round(1*T_s);
mask_em = bwareaopen(mask_temp, T_s);
mask_f=mask_temp-mask_em+mask_f;


for i=1:20
    se = strel('disk',1);
    mask_temp = imerode(mask_em, se);
    mask_em = bwareaopen(mask_temp,T_s);
    mask_f=mask_temp-mask_em+mask_f;
end;

mask_f=mask_f+mask_temp;
mask_ff=mask_f>0;

mask_ff=bwareaopen(mask_ff,100);
s  = bwlabel(mask_ff);

ss1=s;
N=max(max(s))

xc=[];yc=[];
 for h=1:N
     X=[];Y=[];
     leng=0;lx=0;ly=0;
     for i=1:S1
         for j=1:S2
              
             if ss1(i,j)<h+1&&ss1(i,j)>h-1
                 X=[X,i];
                 Y=[Y,j];
             end;
             
         end;
     end;     
     xc=[xc,median(X)];
     yc=[yc,median(Y)];
 end;
rxc1=round(xc);
ryc1=round(yc); 


figure,imagesc(A1);colormap gray;
hold on;
plot(double(ryc1),double(rxc1),'go','MarkerSize',6,'LineWidth',2);




