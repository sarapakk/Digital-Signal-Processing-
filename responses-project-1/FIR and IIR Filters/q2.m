%part2
clc;
clear;
close all;
 b = load('FIR.mat');
c=  struct2cell(b);
d = cell2mat(c);

%defining xa(t)
T=0.001;
t=0:T:20;
xa = 1+ sin(4*pi*t)+exp(1i*t).*(sin(2*pi*t)+sin(pi*t));
%fast fourier transform

L=length (xa);
NFFT=2^nextpow2(L);
Xa=fft(xa,NFFT)/L;
w=1/(2*T)*linspace(0,1,(NFFT/2)+1);
%sampling xa(t)
fs=6;
x=resample(xa,fs,1/T);
xFIR= filter(d ,1,x);
yFIR= reconst(xFIR,t,1/fs);

%fast fourier transform
Lr=length (yFIR);
NFFT=2^nextpow2(Lr);
YFIR=fft(yFIR,NFFT)/Lr;
%comparing magnitude of YFIR(f) & Xa(f)
figure
subplot(2,1,1);
plot(w,2*abs(YFIR(1:NFFT/2+1)))
title('Magntiude of YFIR(f)');
xlabel('freq(Hertz)');
ylabel('|YFIR(f)|');

subplot(2,1,2);
plot(w,2*abs(Xa(1:NFFT/2+1)))
title('Magntiude of Xa(f)');
xlabel('freq(Hertz)');
ylabel('|Xa(f)|');
%comparing phase of Xr(f) & Xa(f)
figure
subplot(2,1,1);
plot(w,angle(YFIR(1:NFFT/2+1)))
title('phase of YFIR(f)');
xlabel('freq(Hertz)');
ylabel('phs_YFIR(f)');

subplot(2,1,2);
plot(w,angle(Xa(1:NFFT/2+1)))
title('phase of Xa(f)');
xlabel('freq(Herts)');
ylabel('phs_Xa(f)');

figure
subplot(2,1,1);
plot(t,abs(yFIR))
title('reconstruction signal yFIR(t)');
xlabel('time(sec)');
ylabel('yFIR(t)');
subplot(2,1,2);
plot(t,abs(xa));
title('Analog signal xa(t)');
xlabel('time(sec)');
ylabel('xa(t)');
