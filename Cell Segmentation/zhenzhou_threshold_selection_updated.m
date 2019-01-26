%%%This program is written by Zhenzhou Wang, for more information please
%%%contact: zzwangsia@yahoo.com or wangzhenzhou@sia.cn
%%%This program is free for academic use only.
%%%Please reference and acknowledge the following paper:
%%%[1]Z.Z. Wang, "Monitoring of GMAW weld pool from the reflected laser lines
%%%for real time control", IEEE Transactions on Industrial Informatics, No.
%%%10,Issue, 4, pp. 2073-2083, 2014
%%%[2] Z.Z. Wang, "A new approach for segmentation and quantification of
%%%%%% cells or nanoparticles", IEEE T IND INFORM, 12(3), pp.962-971,2016

function [T] = zhenzhou_threshold_selection_updated(C,km,bandwidth,Nfit,Case)
%%%Case=1: segment between 1 and 2; case2:segment between 2 and 3;and so on
interval=8;%%%user defined; default value is 8;
Image=round(C);
Ns=max(max(Image));
Ns1=max(min(min(Image)),1);
hist1=zeros(1,Ns);
for h=Ns1:Ns
for i=1:size(Image,1)
    for j=1:size(Image,2)
        if Image(i,j)==h;
            hist1(1,h)=hist1(1,h)+1;
        end;
    end;
end;

if hist1(1,h)<1
    hist1(1,h)=1;
end;
end;


% figure,plot(hist1);
hist1=hist1/max(hist1);
hist_orig=hist1;
fhist=fft(hist1);
fhist1=abs(fftshift(fhist));
% figure,plot(fhist1);
% fhist(10:245)=0;
fhist(bandwidth:(max(size(fhist1))-bandwidth))=0;
ahist=ifft(fhist);

hist=abs(ahist)/max(abs(ahist));
hist(1:Ns1)=0;
hist(Ns:255)=0;
% figure,plot(hist);


% %%%%%try the IIR filter
% % d = fdesign.lowpass('Fp,Fst,Ap,Ast',0.2, 0.22, 1, 60);
% d = fdesign.lowpass('Fp,Fst,Ap,Ast',0.2, 0.4, 1, 60);
% designmethods(d,'iir'); % List the available IIR design methods
% f = design(d, 'ellip');  % Design an elliptic IIR filter (SOS)
% % fvtool(f);               % visualize various filter responses
% % input = randn(100,1);
% hist = filter(f,hist1); % Process data through the elliptic filter.
% % figure,plot(hist);

% hist=smooth(hist1);


% %%%%%%%%%%%Try the FIR fileter
% %  b = fir1(34,0.48,'high',chebwin(35,30));    % FIR filter design
% b = fir1(48,0.1);
% freqz(b,1,512);                 % Frequency response of filter
% hist = filtfilt(b,1,hist1);       % Zero-phase digital filtering



% N=55;
 N=15;
 N=Nfit;
% N=7
hl=zeros(1,max(size(hist)));
sd=zeros(1,N+1);
% s=zeros(1,(N+1)/2);
for i=1+N:max(size(hist))-N
    Y=[];
    X=[];
    for j=1:N
        Y=[Y;hist(i-N+j-1)];
        temp=[i-N+j-1,1];
        X=[X;temp];
    end;
    k=inv(X'*X)*X'*Y;
    k1=k(1);
    Y=[];
    X=[];
    for j=1:N
        Y=[Y;hist(i+j)];
        temp=[i+j,1];
        X=[X;temp];
    end;
    k=inv(X'*X)*X'*Y;
    k2=k(1);
    sd=[sd,k1-k2];
       
end;
M=5;
s=zeros(1,(M+1)/2+2);
for i=1+M:max(size(sd))-M
    Y=[];
    X=[];
    Y=sd((i-(M-1)/2):(i+(M-1)/2))';
    temp=[(i-(M-1)/2):(i+(M-1)/2)];
    af=ones(1,max(size(temp)));
    X=[temp',af'];
    k=inv(X'*X)*X'*Y;
    s=[s,k(1)];
end;

s=s/max(s);
sd=sd/max(sd);

peaks=zeros(1,max(size(sd)));
for i=1:max(size(sd))
    if sd(i)>0
        peaks(i)=sd(i);
    end;
end;
%figure,plot(peaks);
valleys=zeros(1,max(size(sd)));
for i=1:max(size(sd))
    if sd(i)<0
        valleys(i)=-sd(i);
    end;
end;
%figure,plot(valleys);

ps=findpeaks(peaks((Nfit+5):(255-Nfit-5))); %%%Eliminate the peaks near the two ending sizes
peak_intensity=[];

for i=1:min(size(ps))
[m n]=find(peaks==ps(i));
peak_intensity=[peak_intensity,n];
end;
vs=findpeaks(valleys);
valley_intensity=[];
for i=1:min(size(vs))
[m n]=find(valleys==vs(i));
valley_intensity=[valley_intensity,n];
end;

% keyboard;

% keyboard;
if km==2
    [m n1]=find(peaks==max(ps));
    ps1=[];
    for i=1:max(size(ps))
        if ps(i)<max(ps)
            ps1=[ps1,ps(i)];
        end;
    end;
    [m n2]=find(peaks==max(ps1));
    Mu=[n1, n2]
    
    dis=abs(n1-n2);
    if dis<interval
        ps2=[];
        for i=1:max(size(ps1))
            if ps1(i)<max(ps1)
                ps2=[ps2,ps1(i)];
            end;
        end;
        [m n3]=find(peaks==max(ps2));
        Mu=[(n1+n2)/2, n3]
    end;
    
    Mu=sort(Mu)
%     keyboard;
    n_v_s=[];
    nvs=[];
    for i=1:max(size(vs))
        if valley_intensity(i)>Mu(1)&&valley_intensity(i)<Mu(2)
            n_v_s=[n_v_s,valley_intensity(i)];
            nvs=[nvs,vs(i)];
        end;
    end;
    
    [m n]=find(nvs==max(nvs));
    T=n_v_s(n)
    
end;


% keyboard;
if km==3
    [m n1]=find(peaks==min(size(ps)));
    ps1=[];
    for i=1:min(size(ps))
        if ps(i)<max(ps)
            ps1=[ps1,ps(i)];
        end;
    end;
    [m n2]=find(peaks==min(size(ps1)));
    
    ps2=[];
    for i=1:max(size(ps1))
        if ps1(i)<max(ps1)
            ps2=[ps2,ps1(i)];
        end;
    end;
%     keyboard;
    if max(size(ps2))>0
        [m n3]=find(peaks==max(ps2));
        Mu=sort([n1, n2, n3])
        
        dis=min(abs(diff(Mu)));
        if dis<interval
            ps3=[];
            for i=1:max(size(ps2))
                if ps2(i)<max(ps2)
                    ps3=[ps3,ps2(i)];
                end;
            end;
            [m n4]=find(peaks==max(ps3));
            %         if abs(n1-n2)<abs(n2-n3)
            %             Mu=sort([(n1+n2)/2, n3, n4]);
            %         end;
            %         if abs(n1-n2)>abs(n2-n3)
            %             Mu=sort([n1,(n2+n3)/2, n4]);
            %         end;
            
            if abs(n1-n2)<abs(n2-n3)
                Mu=sort([(n1+n2)/2, n3, n4]);
            else
                Mu=sort([n1,(n2+n3)/2, n4]);
            end;
            
        end;
        
        if Case==1
            n_v_s=[];
            nvs=[];
            for i=1:max(size(vs))
                if valley_intensity(i)>Mu(1)&&valley_intensity(i)<Mu(2)
                    n_v_s=[n_v_s,valley_intensity(i)];
                    nvs=[nvs,vs(i)];
                end;
            end;
            
            [m n]=find(nvs==max(nvs));
            T=n_v_s(n)
            if max(size(T))<1
                T=(Mu(1)+Mu(2))/2
            end;
        end;
        
        if Case==2
            n_v_s=[];
            nvs=[];
            for i=1:max(size(vs))
%                 if valley_intensity(i)>Mu(2)&&valley_intensity(i)<(Mu(3)+Mu(2))/2
                    if valley_intensity(i)>Mu(2)&&valley_intensity(i)<Mu(3) %%%change by zz 2015-11-27
                    n_v_s=[n_v_s,valley_intensity(i)];
                    nvs=[nvs,vs(i)];
                end;
            end;
            
            [m n]=find(nvs==max(nvs));
            T=n_v_s(n)
            if max(size(T))<1
                T=(Mu(1)+Mu(2))/2
            end;
        end;
        
    else
        Mu=sort([n1,n2]);        
        if Case==1
            n_v_s=[];
            nvs=[];
            for i=1:max(size(vs))
                if valley_intensity(i)>Mu(1)&&valley_intensity(i)<Mu(2)
                    n_v_s=[n_v_s,valley_intensity(i)];
                    nvs=[nvs,vs(i)];
                end;
            end;
            
            [m n]=find(nvs==max(nvs));
            T=n_v_s(n)
            if max(size(T))<1
                T=(Mu(1)+Mu(2))/2
            end;
        end;
        
        if Case==2
            n_v_s=[];
            nvs=[];
            for i=1:max(size(vs))
                if valley_intensity(i)>Mu(1)&&valley_intensity(i)<(Mu(1)+Mu(2))/2
                    n_v_s=[n_v_s,valley_intensity(i)];
                    nvs=[nvs,vs(i)];
                end;
            end;
            
            [m n]=find(nvs==max(nvs));
            T=n_v_s(n)
            if max(size(T))<1
                T=(Mu(1)+Mu(2))/2
            end;
        end;
        
    end;
    %     keyboard;
    
        
    
end;


if km==4
    [m n1]=find(peaks==max(ps));
    ps1=[];
    for i=1:max(size(ps))
        if ps(i)<max(ps)
            ps1=[ps1,ps(i)];
        end;
    end;
    [m n2]=find(peaks==max(ps1));
    ps2=[];
    for i=1:max(size(ps1))
        if ps1(i)<max(ps1)
            ps2=[ps2,ps1(i)];
        end;
    end;
    [m n3]=find(peaks==max(ps2));
    Mu=[n1, n2, n3]
    ps3=[];
    for i=1:max(size(ps2))
        if ps2(i)<max(ps2)
            ps3=[ps3,ps2(i)];
        end;
    end;
    [m n4]=find(peaks==max(ps3));
    Mu=[n1, n2, n3, n4]
end;

if km==5
    [m n1]=find(peaks==max(ps));
    ps1=[];
    for i=1:max(size(ps))
        if ps(i)<max(ps)
            ps1=[ps1,ps(i)];
        end;
    end;
    [m n2]=find(peaks==max(ps1));
    ps2=[];
    for i=1:max(size(ps1))
        if ps1(i)<max(ps1)
            ps2=[ps2,ps1(i)];
        end;
    end;
    [m n3]=find(peaks==max(ps2));
    Mu=[n1, n2, n3]
    ps3=[];
    for i=1:max(size(ps2))
        if ps2(i)<max(ps2)
            ps3=[ps3,ps2(i)];
        end;
    end;
    [m n4]=find(peaks==max(ps3));
    Mu=[n1, n2, n3, n4]
    ps4=[];
    for i=1:max(size(ps3))
        if ps3(i)<max(ps3)
            ps4=[ps4,ps3(i)];
        end;
    end;
    [m n5]=find(peaks==max(ps4));
    Mu=[n1, n2, n3, n4, n5]
end;

if km==6
    [m n1]=find(peaks==max(ps));
    ps1=[];
    for i=1:max(size(ps))
        if ps(i)<max(ps)
            ps1=[ps1,ps(i)];
        end;
    end;
    [m n2]=find(peaks==max(ps1));
    ps2=[];
    for i=1:max(size(ps1))
        if ps1(i)<max(ps1)
            ps2=[ps2,ps1(i)];
        end;
    end;
    [m n3]=find(peaks==max(ps2));
    Mu=[n1, n2, n3]
    ps3=[];
    for i=1:max(size(ps2))
        if ps2(i)<max(ps2)
            ps3=[ps3,ps2(i)];
        end;
    end;
    [m n4]=find(peaks==max(ps3));
    Mu=[n1, n2, n3, n4]
    ps4=[];
    for i=1:max(size(ps3))
        if ps3(i)<max(ps3)
            ps4=[ps4,ps3(i)];
        end;
    end;
    [m n5]=find(peaks==max(ps4));
    Mu=[n1, n2, n3, n4, n5]
      ps5=[];
    for i=1:max(size(ps4))
        if ps4(i)<max(ps4)
            ps5=[ps5,ps4(i)];
        end;
    end;
    [m n6]=find(peaks==max(ps5));
    Mu=[n1, n2, n3, n4, n5, n6]
end;




figure,plot(peaks,'b-','linewidth',2);%'Color',[.3 0 0]);
hold on;
plot(-valleys,'r-','linewidth',2);%'Color',[.6 0 0]);
plot(hist1,'m-','linewidth',2);
plot(hist,'c-','linewidth',2);

plot(s,'g-','linewidth',2);
plot(hl,'k-','linewidth',2);

plot(T,0,'r*','markersize',10,'LineWidth',2);
% plot(Totsu,0,'g*','markersize',10,'LineWidth',2);
for i=1:max(size(peak_intensity))
    plot(peak_intensity(i),0,'bx','markersize',10,'linewidth',2);
end;
for i=1:max(size(valley_intensity))
    plot(valley_intensity(i),0,'ro','markersize',10,'linewidth',2);
end;
legend('peak parts of slope difference','valley parts of slope difference','original histogram distribution','smoothed histogram distribution','derivative of slope difference','horizontal axis','selected threshold');



