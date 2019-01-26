
%% Computer Assisted Retinal Blood Vessel Segmentation Algorithm
% Developed and Copyrighted by Tyler L. Coye (2015)
%
% Read Image
I = imread('10_right.jpeg');
% Resize image for easier computation
B = imresize(I, [584 565]);
% Read image
im = im2double(B);
% Convert RGB to Gray via PCA
lab = rgb2lab(im);
f = 0;
wlab = reshape(bsxfun(@times,cat(3,1-f,f/2,f/2),lab),[],3);
[C,S] = pca(wlab);
S = reshape(S,size(lab));
S = S(:,:,1);
gray = (S-min(S(:)))./(max(S(:))-min(S(:)));
%% Contrast Enhancment of gray image using CLAHE
J = adapthisteq(gray,'numTiles',[8 8],'nBins',128);
%% Background Exclusion
% Apply Average Filter
h = fspecial('average', [9 9]);
JF = imfilter(J, h);
figure, imshow(JF);
% Take the difference between the gray image and Average Filter
Z = imsubtract(JF, J);
figure, imshow(Z);
%% Threshold using the IsoData Method
level=isodata(Z); % this is our threshold level
%level = graythresh(Z)
%% Convert to Binary
BW = im2bw(Z, level-.008);
%% Remove small pixels
BW2 = bwareaopen(BW, 100);
%% Overlay
BW2 = imcomplement(BW2);
out = imoverlay(B, BW2, [0 0 0]);
figure, imshow(out);









