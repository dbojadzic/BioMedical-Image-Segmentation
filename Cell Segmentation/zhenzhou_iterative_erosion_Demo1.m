%%%This program is written by Zhenzhou Wang, for more information please
%%%contact: zzwangsia@yahoo.com or wangzhenzhou@sia.cn
%%%This program is free for academic use only.
%%%Please reference and acknowledge the following paper:
%%%Z.Z. Wang, "Automatic segmentation and classification of the reflected laser dots during analytic measurement of mirror surfaces, Optics and Lasers in Engineering,  2016
%%%Z.Z. Wang, "A semi-automatic method for robust and efficient identification of neighboring muscle cells," Pattern Recognition, Vol. 53, pp.300-312, 2016

function [rxc1, ryc1] = zhenzhou_iterative_erosion(Filtered_Seed,Case)
%%%Case= 1, 2, 3, to disting\guish the size type of the cells

seed=Filtered_Seed;
if Case==1
    m_id=1;
    l_id=0;
    s_id=0;
    n_id=0;
end;
if Case==2
    m_id=1;
    l_id=0;
    s_id=0;
    n_id=0;
end;
if Case==3
    m_id=0;
    l_id=0;
    s_id=1;
    n_id=0;
end;
if Case==4
    m_id=0;
    l_id=0;
    s_id=0;
    n_id=1;
end;
se = strel('disk',1);
% seed=bSeg;
isize=size(seed);
S1=isize(1);
S2=isize(2);
%%%%%%%%%%%%%%%%%%%%separate the cells
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mask_f=zeros(S1,S2);
mask_temp= seed;
%%%%%%%%%%%%%%%%%%%separate cells based on size threshold
a_temp=seed;
if m_id==1
    for i=1:10
        a_temp = imerode(a_temp, se);
        a_temp= bwareaopen(a_temp,5);
    end;
end;
if l_id==1
    for i=1:5
        a_temp = imerode(a_temp, se);
        a_temp= bwareaopen(a_temp,3);
    end;
end;
if s_id==1
    for i=1:4
        a_temp = imerode(a_temp, se);
        a_temp= bwareaopen(a_temp,1);
    end;
end;

if n_id==1
    for i=1:1
        a_temp = imerode(a_temp, se);
        a_temp= bwareaopen(a_temp,1);
    end;
end;

s  = regionprops(a_temp, 'Area');
areas = cat(1, s.Area);
% figure,imagesc(a_temp);colormap gray;

T_s=round(mean(areas));
T_s=round(T_s);
mask_em = bwareaopen(mask_temp, T_s);
mask_f=mask_temp-mask_em+mask_f;
% figure,imagesc(mask_f);

for i=1:20
    se = strel('disk',1);
    mask_temp = imerode(mask_em, se);
    mask_em = bwareaopen(mask_temp,T_s);
    %figure,imagesc(mask_temp);
    mask_f=mask_temp-mask_em+mask_f;
    %figure,imagesc(mask_f);
end;

mask_f=mask_f+mask_temp;
mask_ff=mask_f>0;
% figure,imagesc(mask_ff);colormap gray;


%%%General filtering 2016
if Case==1
mask_ff=bwareaopen(mask_ff,30);
end;
if Case==2
mask_ff=bwareaopen(mask_ff,20);
end;
if Case==3
mask_ff=bwareaopen(mask_ff,10);
end;

s  = bwlabel(mask_ff);

imagesc(s);

% ss1=bwlabel(sd1);
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



