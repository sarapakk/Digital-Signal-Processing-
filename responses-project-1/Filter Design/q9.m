%part9
clc;
close all;
%wave reading
[x,fs]=wavread('NoisySound');
%fft of the wave

NFFT = 2^nextpow2(length(x)); 
Y = fft(x,NFFT)/length(x);
f = fs/2*linspace(0,1,NFFT/2+1);
figure
%plot in freq domain
plot(f,2*abs(Y(1:NFFT/2+1))) 
title('The Magnitude of FFT of Signal');
xlabel('frequency(Hz)');
ylabel('|Y(f)|');