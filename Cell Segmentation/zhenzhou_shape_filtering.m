%%%This program is written by Zhenzhou Wang, for more information please
%%%contact: zzwangsia@yahoo.com or wangzhenzhou@sia.cn
%%%This program is free for academic use only.
%%%Please reference and acknowledge the following paper:
%%%papers to be published

function [Filtered_Seed] = zhenzhou_shape_filtering(bobC,Case,Band_Width)
%%%T_shape is the threshold to distinguish the noise shape and the cell
%%%shape
%%Band_Width is the band width of the Fourier filter

%%%%%shape filtering by boundary
temp = bwboundaries(bobC);
% xb_ROI = temp{1}(:,2);
% yb_ROI = temp{1}(:,1);
tempCell=[];
% Tbound=[];
figure,imagesc(bobC);colormap gray;
hold on;
for i=1:max(size(temp))
%         Tbound=[Tbound;max(size(temp{i}))];
        plot(temp{i}(:,2),temp{i}(:,1),'b-','Linewidth',2);
end;

% T_bound=round(mean(Tbound));
if Case==4
    T_bound=4;
end;
if Case==3
    T_bound=10;
end;
if Case==2
    T_bound=10;
end;
if Case==1
    T_bound=30;
end;

% keyboard;


for i=1:max(size(temp))
     if max(size(temp{i}))>T_bound
        
        tempCell{i}=temp{i};
        plot(tempCell{i}(:,2),tempCell{i}(:,1),'r-','Linewidth',2);
      end;
end;


NS=size(bobC);
ROI=zeros(NS(1),NS(2));
Filtered_Seed=zeros(NS(1),NS(2));

figure,imagesc(bobC);colormap gray;
hold on;
for i=1:max(size(tempCell))
    if max(size(tempCell{i}))>0
        xb = tempCell{i}(:,2);
        yb = tempCell{i}(:,1);
        
        fhist=fft(xb);
        fhist1=abs(fftshift(fhist));
        fhist(Band_Width:(max(size(fhist1))-Band_Width))=0;
        xb1=ifft(fhist);
        fhist=fft(yb);
        fhist1=abs(fftshift(fhist));
        fhist(Band_Width:(max(size(fhist1))-Band_Width))=0;
        yb1=ifft(fhist);
         plot(xb1,yb1,'g-','LineWidth',3);
        
        ROI = poly2mask(abs(xb1),abs(yb1),size(ROI,1),size(ROI,2));
        Filtered_Seed=Filtered_Seed+ROI;
    end;
end;
% figure,imagesc(Filtered_Seed);colormap gray;



