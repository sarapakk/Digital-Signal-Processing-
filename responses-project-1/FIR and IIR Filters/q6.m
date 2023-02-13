%part6
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
Ifilter=freqz(0.0781*bt,at);

%defining xa(t)
T=0.001;
t=0:T:20;
xa = 1+ sin(4*pi*t)+exp(1i*t).*(sin(2*pi*t)+sin(pi*t));
%fast fourier transform

L=length (xa);
NFFTx=2^nextpow2(L);
Xa=fft(xa,NFFTx)/L;
wx=1/(2*T)*linspace(0,1,(NFFTx/2)+1);
%sampling xa(t)
fs=6;
x=resample(xa,fs,1/T);
xIIR= filter(0.0781*bt ,at,x);
yIIR = reconst(xIIR,t,1/fs);
shiftedyIIR = yIIR(16260:-1:1);

%fast fourier transform
Lr=length (shiftedyIIR);
NFFTy=2^nextpow2(Lr);
ShiftedyIIR=fft(shiftedyIIR,NFFTy)/Lr;
wy=1/(2*T)*linspace(0,1,(NFFTy/2)+1);
%comparing magnitude of ShiftedyIIR(f) & Xa(f)
figure
subplot(2,1,1);
plot(wy,2*abs(ShiftedyIIR(1:NFFTy/2+1)))
title('Magntiude of ShiftedyIIR(f)');
xlabel('freq(Hertz)');
ylabel('|ShiftedyIIR(f)|');

subplot(2,1,2);
plot(wx,2*abs(Xa(1:NFFTx/2+1)))
title('Magntiude of Xa(f)');
xlabel('freq(Hertz)');
ylabel('|Xa(f)|');

%comparing phase of ShiftedyIIR(f) & Xa(f)
figure
subplot(2,1,1);

plot(wy,angle(ShiftedyIIR(1:NFFTy/2+1)))
title('phase of ShiftedyIIR(f)');
xlabel('freq(Hertz)');
ylabel('phs_ShiftedyIIR(f)');

subplot(2,1,2);
plot(wx,angle(Xa(1:NFFTx/2+1)))
title('phase of Xa(f)');
xlabel('freq(Herts)');
ylabel('phs_Xa(f)');

figure
subplot(2,1,1);
plot(t(1:length(shiftedyIIR)),abs(shiftedyIIR))
title('reconstruction signal shiftedyIIR(t)');
xlabel('time(sec)');
ylabel('shiftedyIIR(t)');
subplot(2,1,2);
plot(t,abs(xa));
title('Analog signal xa(t)');
xlabel('time(sec)');
ylabel('xa(t)');
