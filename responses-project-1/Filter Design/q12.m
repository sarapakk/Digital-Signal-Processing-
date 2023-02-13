%part12
clc;
clear all;
close all;
%part a
[x,fs]=wavread('noiseless.wav');
t=0:1/fs:10-1/fs;
T=1/16000;
%Before filtering
sound(x/max(abs(x)),fs);

%After filtering
myfilt=load('filter12.mat');
c=  struct2cell(myfilt);
LPF= cell2mat(c);
y=filter(LPF,1,x);
sound(y/max(abs(y)),fs);
%part b
figure
plot(t,x,'y');
title('Signal Before Filtering');
xlabel('t(sec)');
figure
plot(t,y,'g');
title('Signal After Filtering');
xlabel('t(sec)');

%part c
%fft for signal without filtering

L=length (x);
NFFT=2^nextpow2(L);
X=fft(x,NFFT)/L;
w=1/(2*T)*linspace(0,1,(NFFT/2)+1);
figure
subplot(2,1,1);
plot(w,2*abs(X(1:NFFT/2+1)))
title('Magntiude of X(f)');
xlabel('freq(Hertz)');
ylabel('|X(f)|');

subplot(2,1,2);
plot(w,angle(X(1:NFFT/2+1)))
title('phase of X(f)');
xlabel('freq(Hertz)');
ylabel('phs_X(f)');
%fft for signal after filtering

L=length (y);
NFFT=2^nextpow2(L);
Y=fft(y,NFFT)/L;
w=1/(2*T)*linspace(0,1,(NFFT/2)+1);
figure
subplot(2,1,1);
plot(w,2*abs(Y(1:NFFT/2+1)))
title('Magntiude of Y(f)');
xlabel('freq(Hertz)');
ylabel('|Y(f)|');

subplot(2,1,2);
plot(w,angle(X(1:NFFT/2+1)))
title('phase of X(f)');
xlabel('freq(Hertz)');
ylabel('phs_X(f)');
 %part d
 figure
 freqz(LPF)