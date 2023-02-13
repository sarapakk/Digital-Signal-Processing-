clc
clear all
close all
%% part A
figure(1)
k=0:50;
n=0:10; % original signal
x = (-1).^n ./(n+1);
y = x(mod(-n,11)+1);
subplot(2,1,1); stem(n,x); title('Original sequence')
xlabel('n'); ylabel('x(n)');
subplot(2,1,2); stem(n,y); title('Circularly folded sequence')
xlabel('n'); ylabel('x(-n mod 11)');
%% part B verification
figure(2)

X = DFT(x,n); Y = DFT(y,n);
subplot(2,2,1); stem(k,real(X));
title('Real{DFT[x(n)]}'); xlabel('k');
subplot(2,2,2); stem(k,imag(X));
title('Imag{DFT[x(n)]}'); xlabel('k');
subplot(2,2,3); stem(k,real(Y));
title('Real{DFT[x((-n))11]}'); xlabel('k');
subplot(2,2,4); stem(k,imag(Y));
title('Imag{DFT[x((-n))11]}'); xlabel('k');

%% part c
figure(3)

[xf,nf]=sigfold(x,n); % folded one to make x1[-n]
[xs,ns]=sigshift(xf,nf,-11); % shifted signal to make x1[11-n]

[xep,nep] = sigadd(x,n,xf,nf); % add to signal
[xop,nop] = sigadd(x,n,-xf,nf);
subplot(2,1,1)
stem(nep,xep/2)
title('even part')
subplot(2,1,2)
stem(nop,xop)
title('odd part')

%% part d

Xep = DFT(xep,nep);
Xr = real(DFT(x,n));
Xop = DFT(xop,nop);
Xi = j*imag(DFT(x,n));
Xsi = -j*imag(DFT(xf,nf));
de =norm(real(Xep)/2-Xr);
do1 = norm(Xop/2 - Xi)
do2 = norm(Xop/2 - Xsi);
disp(['norm(Xep,Xr) is: ' num2str(de)])
disp(['norm(Xop,Xi) is: ' num2str(do1)])
disp(['norm(Xop,Xsi) is: ' num2str(do2)])


%% part e
figure(4)

x_circ_sh = cirshftt(x,-4,11); % circular shift toward left

xtild = x' * ones(1,3); % make x periodic
xtild=xtild(:);

[xx,nn] = sigshift(xtild,-11:21,-4); % periodic shift toward left
stem(nn,xx')
hold on
stem(n,x_circ_sh,'r')
title('periodic shift and circular 4 toward left')
%% part f
figure(5)

xh =[x 0 0 0 0];
n_new = 0:length(xh)-1;
xhs = cirshftt(xh,3,15); % circular shift toward right
xtild_h = xh'*ones(1,3); % make xhs periodic
xtild_h = xtild_h(:)';

[xhs_new,kk]=sigshift(xtild_h,-15:29,3); % periodic shift toward right
stem(kk,xhs_new,'r')
hold on
stem(n_new,xhs)
title('periodic shift and circular 3 toward right')
