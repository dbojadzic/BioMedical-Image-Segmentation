%%%This program is written by Zhenzhou Wang, for more information please
%%%contact: zzwangsia@yahoo.com or wangzhenzhou@sia.cn
function [A] = gradient_image(C)
I = (double(C));
% figure,imagesc(I);colormap gray;
hy = fspecial('sobel');
hx = hy';
Iy = imfilter(double(I), hy, 'replicate');
Ix = imfilter(double(I), hx, 'replicate');
gradmag = sqrt(Ix.^2 + Iy.^2);
gradmag = gradmag./max(max(gradmag));
A=255*imadjust(gradmag);
% figure,imagesc(A);colormap gray;