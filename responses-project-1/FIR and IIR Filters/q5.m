%part5
clc;
close all;
%load IIR filter
b = load('IIR.mat');
c=  struct2cell(b);
d = cell2mat(c);
b1=d(1,:);
b2=d(2,:);
b3=d(3,:);
a1=d(4,:);
a2=d(5,:);
a3=d(6,:);
bt1=conv(b1,b2);
bt=conv(bt1,b3);
at1=conv(a1,a2);
at=conv(at1,a3);
freqz(0.0781*bt,at);
Ifilter=freqz(0.0781*bt,at);

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
xIIR= filter(0.0781*bt ,at,x);
yIIR = reconst(xIIR,t,1/fs);

%fast fourier transform
Lr=length (yIIR);
NFFT=2^nextpow2(Lr);
YIIR=fft(yIIR,NFFT)/Lr;

%comparing magnitude of YIIR(f) & Xa(f)
figure
subplot(2,1,1);
plot(w,2*abs(YIIR(1:NFFT/2+1)))
title('Magntiude of YIIR(f)');
xlabel('freq(Hertz)');
ylabel('|YIIR(f)|');

subplot(2,1,2);
plot(w,2*abs(Xa(1:NFFT/2+1)))
title('Magntiude of Xa(f)');
xlabel('freq(Hertz)');
ylabel('|Xa(f)|');

%comparing phase of YIIR(f) & Xa(f)
figure
subplot(2,1,1);

plot(w,angle(YIIR(1:NFFT/2+1)))
title('phase of YIIR(f)');
xlabel('freq(Hertz)');
ylabel('phs_YIIR(f)');

subplot(2,1,2);
plot(w,angle(Xa(1:NFFT/2+1)))
title('phase of Xa(f)');
xlabel('freq(Herts)');
ylabel('phs_Xa(f)');

figure
subplot(2,1,1);
plot(t,abs(yIIR))
title('reconstruction signal yIIR(t)');
xlabel('time(sec)');
ylabel('yIIR(t)');
subplot(2,1,2);
plot(t,abs(xa));
title('Analog signal xa(t)');
xlabel('time(sec)');
ylabel('xa(t)');