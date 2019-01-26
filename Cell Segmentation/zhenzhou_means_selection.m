%%%%%%%%%%%%%%%%%%Zhenzhou_threshold_method
function [Mu]=zhenzhou_means_selection(C,km)
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
% hist_orig=hist1;
fhist=fft(hist1);
fhist1=abs(fftshift(fhist));
% figure,plot(fhist1);
% fhist(10:245)=0;
fhist(10:(max(size(fhist1))-10))=0;
ahist=ifft(fhist);
% figure,plot(abs(ahist),'b-');
% hold on;
% plot(hist1,'r-');
% plot(hist2,'g-');


% ahist=hist1;%%%not use Fourier filtering
hist=abs(ahist)/max(abs(ahist));
hist(1:Ns1)=0;
hist(Ns:255)=0;
% figure,plot(hist);


% N=55;
N=11;
% N=35
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
M=15;
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
for i=15:max(size(sd))
    if sd(i)>0
        peaks(i)=sd(i);
    end;
end;
%figure,plot(peaks);
% valleys=zeros(1,max(size(sd)));
% for i=1:max(size(sd))
%     if sd(i)<0
%         valleys(i)=-sd(i);
%     end;
% end;
% %figure,plot(valleys);

ps=findpeaks(peaks);
% peak_intensity=[];
% peak_value=[];
% for i=1:max(size(ps))
%     if ps(i)>0.1
%         [m n]=find(peaks==ps(i));
%         peak_intensity=[peak_intensity,n];
%         peak_value=[peak_value,ps(i)];
%     end;
% end;
% vs=findpeaks(valleys);
% valley_intensity=[];
% for i=1:max(size(vs))
% [m n]=find(valleys==vs(i));
% valley_intensity=[valley_intensity,n];
% end;

% Vm=(peak_intensity)
%  keyboard;
% Um=[];
% for kk=1:k
%     Um=[Um,peak_intensity(1)];
% end;


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
    Mu=[n1, n2];
    
    dis=abs(n1-n2);
    if dis<interval
        ps2=[];
        for i=1:max(size(ps1))
            if ps1(i)<max(ps1)
                ps2=[ps2,ps1(i)];
            end;
        end;
        [m n3]=find(peaks==max(ps2));
        Mu=[(n1+n2)/2, n3];
    end;    
end;


% keyboard;
if km==3
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
        Mu=sort([(n1+n2)/2, n3, n4]);
        
    end;
    
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
    Mu=[n1, n2, n3];
    ps3=[];
    for i=1:max(size(ps2))
        if ps2(i)<max(ps2)
            ps3=[ps3,ps2(i)];
        end;
    end;
    [m n4]=find(peaks==max(ps3));
    Mu=[n1, n2, n3, n4];
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
    Mu=[n1, n2, n3];
    ps3=[];
    for i=1:max(size(ps2))
        if ps2(i)<max(ps2)
            ps3=[ps3,ps2(i)];
        end;
    end;
    [m n4]=find(peaks==max(ps3));
    Mu=[n1, n2, n3, n4];
    ps4=[];
    for i=1:max(size(ps3))
        if ps3(i)<max(ps3)
            ps4=[ps4,ps3(i)];
        end;
    end;
    [m n5]=find(peaks==max(ps4));
    Mu=[n1, n2, n3, n4, n5];
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
    Mu=[n1, n2, n3, n4];
    ps4=[];
    for i=1:max(size(ps3))
        if ps3(i)<max(ps3)
            ps4=[ps4,ps3(i)];
        end;
    end;
    [m n5]=find(peaks==max(ps4));
    Mu=[n1, n2, n3, n4, n5];
      ps5=[];
    for i=1:max(size(ps4))
        if ps4(i)<max(ps4)
            ps5=[ps5,ps4(i)];
        end;
    end;
    [m n6]=find(peaks==max(ps5));
    Mu=[n1, n2, n3, n4, n5, n6];
end;

if km==7
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
    Mu=[n1, n2, n3, n4];
    ps4=[];
    for i=1:max(size(ps3))
        if ps3(i)<max(ps3)
            ps4=[ps4,ps3(i)];
        end;
    end;
    [m n5]=find(peaks==max(ps4));
    Mu=[n1, n2, n3, n4, n5];
      ps5=[];
    for i=1:max(size(ps4))
        if ps4(i)<max(ps4)
            ps5=[ps5,ps4(i)];
        end;
    end;
    [m n6]=find(peaks==max(ps5));
    Mu=[n1, n2, n3, n4, n5, n6];
    
    ps6=[];
    for i=1:max(size(ps5))
        if ps5(i)<max(ps5)
            ps6=[ps6,ps5(i)];
        end;
    end;
    [m n7]=find(peaks==max(ps6));
    Mu=[n1, n2, n3, n4, n5, n6,n7];
end;

if km==8
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
    Mu=[n1, n2, n3, n4];
    ps4=[];
    for i=1:max(size(ps3))
        if ps3(i)<max(ps3)
            ps4=[ps4,ps3(i)];
        end;
    end;
    [m n5]=find(peaks==max(ps4));
    Mu=[n1, n2, n3, n4, n5];
      ps5=[];
    for i=1:max(size(ps4))
        if ps4(i)<max(ps4)
            ps5=[ps5,ps4(i)];
        end;
    end;
    [m n6]=find(peaks==max(ps5));
    Mu=[n1, n2, n3, n4, n5, n6];
    
    ps6=[];
    for i=1:max(size(ps5))
        if ps5(i)<max(ps5)
            ps6=[ps6,ps5(i)];
        end;
    end;
    [m n7]=find(peaks==max(ps6));
    Mu=[n1, n2, n3, n4, n5, n6,n7];
    
    ps7=[];
    for i=1:max(size(ps6))
        if ps6(i)<max(ps6)
            ps7=[ps7,ps6(i)];
        end;
    end;
    [m n8]=find(peaks==max(ps7));
    Mu=[n1, n2, n3, n4, n5, n6,n7,n8];
    
end;


Mu=sort(Mu);


figure,plot(hist1,'g-','linewidth',3);%,'Color',[.6 0 0]);
hold on;
plot(hist,'r-','linewidth',3);
plot(sd,'b-','linewidth',3);
% plot(s,'g-','linewidth',2);
plot(hl,'k-','linewidth',3);
for i=1:max(size(Mu))
    plot(Mu(i),0,'bx','markersize',15,'linewidth',3);
end;
mylegend=legend('normalized histogram distribution','smoothed histogram distribution','slope difference distribution','horizontal axis');
set(mylegend,'Fontsize',13);
axis([1 250 -1 1]);
set(gca,'FontSize',13);


