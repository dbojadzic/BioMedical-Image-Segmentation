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
    figure, subplot 121, imshow(s,[]),title('Input image'), subplot 122, imshow(ad,[]),title('Fitered image'),l1=30;l2=37;l3=40;l4=42;q1=53;q2=39;q3=36;q4=40;z1=26;z2=16;z3=53;z4=60;
   
 fprintf('\nPress any key \n');
pause;
 disp('classifying tumor boundary');
  
m = zeros(size(ad,1),size(ad,2));          %-- create initial mask 

m(90:100,110:135) = 1;  % main 2


ad = imresize(ad,.5);  %-- make image smaller 
m = imresize(m,.5); %     for fast computation
figure
subplot(2,2,1); imshow(ad,[]); title('Input Image');
% bounding box start

%hold on
if(strcmp(I,'a1.jpg')||strcmp(I,'a.jpg'))

for aa=1:10
    subplot(2,2,2); imshow(ad,[]);title('Locating Bounding box');
    rectangle('Position',[l1 l2 l3 l4],'EdgeColor','y'); %a1
    pause(0.5);
    l1=l1+1;l2=l2+1;l3=l3-2;l4=l4-2;

end;
   % rectangle('Position',[40 47 20 22],'EdgeColor','y'); %a1
end;

if(strcmp(I,'b1.jpg')||strcmp(I,'b.jpg'))
    for aa=1:10
        subplot(2,2,2); imshow(ad,[]);title('Locating Bounding box');
    rectangle('Position',[q1 q2 q3 q4],'EdgeColor','y'); %a1
    pause(0.5);
    q1=q1+1;q2=q2+1;q3=q3-2;q4=q4-2;
    end;

    %rectangle('Position',[61 49 18 20],'EdgeColor','y');  %b1
end;
if(strcmp(I,'c1.jpg')||strcmp(I,'c.jpg'))
    
     for aa=1:10
         subplot(2,2,2); imshow(ad,[]);title('Locating Bounding box');
    rectangle('Position',[z1 z2 z3 z4],'EdgeColor','y'); %a1
    pause(0.5);
    z1=z1+1;z2=z2+1;z3=z3-2;z4=z4-2;
    end;

    %rectangle('Position',[35 26 34 40],'EdgeColor','y');  %c1
end;



%bounding box end


subplot(2,2,3); title('Segmentation');

seg = svm(ad, m, 50); %-- Run segmentation

subplot(2,2,4); imshow(seg); title('Segmented Tumor');
imwrite(seg,'test.jpg');


