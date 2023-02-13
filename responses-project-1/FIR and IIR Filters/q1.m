%FIR and IIR Filters
%q1
clc;
clear all;
close all;
 b = load('FIR.mat');
c=  struct2cell(b);
d = cell2mat(c);
hd = dfilt.dffir(d);
freqz(hd);