%part10
clc;
close all;
%wave reading
[x,fs]=wavread('NoisySound');
%sound(x,fs);
%filter the wave
b = load('filter10.mat');
c=  struct2cell(b);
d = cell2mat(c);
myfilter = dfilt.dffir(d);
freqz(myfilter);
