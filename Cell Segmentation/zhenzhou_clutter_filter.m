%%%This program is written by Zhenzhou Wang, for more information please
%%%contact: zzwangsia@yahoo.com or wangzhenzhou@sia.cn
function [C] = zhenzhou_clutter_filter(A,N)

for i=1:N
    A=imerode(A,strel('disk',1));
end;
for i=1:N
    A=imdilate(A,strel('disk',1));
end;
C=bwareaopen(A,5);
% figure,imagesc(C);colormap gray;