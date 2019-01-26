clc;
TargetImg=imread('test.jpg');
[L,path1]=uigetfile('*.jpg','select a input image');
str1=strcat(path1,L);
TestImg=imread(str1);


 
 [u v]=size(TargetImg);
 TPrate=zeros(1, u, 2); 
 FPrate=zeros(1, u, 2); 
  
 TargetMask = zeros(size(TargetImg));
 TargetMask = TargetImg >0;
 NotTargetMask = logical(1-TargetMask);
 
 TestMask = zeros(size(TestImg));
 TestMask= TestImg >0;
 
 FPimg = TestMask.*NotTargetMask;
 FP = sum(FPimg(:))
 
 TPimg = TestMask.*TargetMask;
 TP = sum(TPimg(:))
 
 FNimg = TargetMask-TPimg;
 FN = sum(FNimg(:))
 
 TNimg = 1- FPimg;
 TN =sum(TNimg(:))
 
 TPrate(1,:,1)=TP/(TP+FN);
 FPrate(1,:,1)=FP/(FP+TN);
 
 Sensitivity(1)= TP/(TP+FN)*100 
 Specificity(1)= TN/(TN+FP)*100 
 Accuracy(1)=(TP+TN)/(TP+TN+FN+FP)*100 
  TargetImg(TargetImg>0)=200;

%2. set second image non-zero values as 300
TestImg(TestImg>0)=300;

%3. set overlap area 100
OverlapImage = TestImg-TargetImg;

%4. count the overlap100 pixels
[r,c,v] = find(OverlapImage==100);
countOverlap100=size(r);

%5. count the image200 pixels
[r1,c1,v1] = find(TargetImg==100);
TargetImg_200=size(r1);

%6. count the image300 pixels
[r2,c2,v2] = find(TestImg==200);
TestImg_300=size(r2);

%7. calculate Dice Coef
DiceCoef = 2*countOverlap100/(TargetImg_200+TestImg_300)
% %1. set one image non-zero values as 200
% img1(img1>0)=200;
% 
% %2. set second image non-zero values as 300
% img2(img2>0)=300;
% 
% %3. set overlap area 100
% OverlapImage = img2-img1;
% 
% %4. count the overlap100 pixels
% [r,c,v] = find(OverlapImage==100);
% countOverlap100=size(r);
% 
% %5. count the image200 pixels
% [r1,c1,v1] = find(img1==200);
% img1_200=size(r1);
% 
% %6. count the image300 pixels
% [r2,c2,v2] = find(img2==300);
% img2_300=size(r2);
% 
% %7. calculate Dice Coef
% DiceCoef = 2*countOverlap100/(img1_200+img2_300);

%8. visualize the volumes by slicing 
figure(1);image(OverlapImage);colormap(gray);title('Overlapping area used to calculate Dice Coef')

%command
% [a b]=DiceSimilarity2DImage(cropprostmask1,cropprostmask2)dice = 2*nnz(TestImg&TargetImg)/(nnz(TestImg) + nnz(TargetImg))