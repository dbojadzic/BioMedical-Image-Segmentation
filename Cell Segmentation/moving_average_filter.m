%%%This program is written by Zhenzhou Wang, for more information please
%%%contact: zzwangsia@yahoo.com or wangzhenzhou@sia.cn
function [C] = moving_average_filter(A)
%%%moving average filtering
sd=1;
B=[(1/(2*pi*sd^2))*exp((-2^2-2^2)/(2*sd^2)),(1/(2*pi*sd^2))*exp((-1^2-2^2)/(2*sd^2)),(1/(2*pi*sd^2))*exp((-0^2-2^2)/(2*sd^2)),(1/(2*pi*sd^2))*exp((-1^2-2^2)/(2*sd^2)),(1/(2*pi*sd^2))*exp((-2^2-2^2)/(2*sd^2));
    (1/(2*pi*sd^2))*exp((-2^2-1^2)/(2*sd^2)),(1/(2*pi*sd^2))*exp((-1^2-1^2)/(2*sd^2)),(1/(2*pi*sd^2))*exp((-0^2-1^2)/(2*sd^2)),(1/(2*pi*sd^2))*exp((-1^2-1^2)/(2*sd^2)),(1/(2*pi*sd^2))*exp((-2^2-1^2)/(2*sd^2));
    (1/(2*pi*sd^2))*exp((-2^2-0^2)/(2*sd^2)),(1/(2*pi*sd^2))*exp((-1^2-0^2)/(2*sd^2)),(1/(2*pi*sd^2))*exp((-0^2-0^2)/(2*sd^2)),(1/(2*pi*sd^2))*exp((-1^2-0^2)/(2*sd^2)),(1/(2*pi*sd^2))*exp((-2^2-0^2)/(2*sd^2));
    (1/(2*pi*sd^2))*exp((-2^2-1^2)/(2*sd^2)),(1/(2*pi*sd^2))*exp((-1^2-1^2)/(2*sd^2)),(1/(2*pi*sd^2))*exp((-0^2-1^2)/(2*sd^2)),(1/(2*pi*sd^2))*exp((-1^2-1^2)/(2*sd^2)),(1/(2*pi*sd^2))*exp((-2^2-1^2)/(2*sd^2));
    (1/(2*pi*sd^2))*exp((-2^2-2^2)/(2*sd^2)),(1/(2*pi*sd^2))*exp((-1^2-2^2)/(2*sd^2)),(1/(2*pi*sd^2))*exp((-0^2-2^2)/(2*sd^2)),(1/(2*pi*sd^2))*exp((-1^2-2^2)/(2*sd^2)),(1/(2*pi*sd^2))*exp((-2^2-2^2)/(2*sd^2))
    ];
C=convn(A,B,'same');
C=255*imadjust(C);
% figure,imagesc(C);colormap gray;