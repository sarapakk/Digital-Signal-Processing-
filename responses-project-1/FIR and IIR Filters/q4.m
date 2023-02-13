%part4
clc;
close all;
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

