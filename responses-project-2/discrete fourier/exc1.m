clc
clear all
K = 50;
k=0:K;
n=0:3;
x = cos(n*pi);

%% part i

w = -10:0.01:10;    % frequency scope for X(e^jW)

X_W =  1 - exp(-j*w) + exp(-2j*w) - ...
    exp(-3j*w); % computed with the well known Fourier transform formula

magX = abs(X_W); % magnitude
angX = angle(X_W); % phase
% draw the result
figure(1) 

subplot(2,1,1); stem(w,magX);grid
xlabel('frequency in pi units'); title('Magnitude Part')
subplot(2,1,2)
stem(w,angX);grid
xlabel('frequency in pi units'); title('Angle Part')
%% part ii
figure(2)
X = DFT(x,n);
magX = abs(X); angX = angle(X);
realX = real(X); imagX = imag(X);
subplot(2,1,1); stem(k/K,magX);grid
xlabel('frequency in pi units'); title('Magnitude Part')
subplot(2,1,2); stem(k/K,angX/pi);grid
xlabel('frequency in pi units'); title('Angle Part')

% part iii
figure(3)
cnt = 1;
for N=[4 8 16]   
n=0:N;
x = cos(n*pi);
X = DFT(x,n);
magX = abs(X); angX = angle(X);
realX = real(X); imagX = imag(X);
subplot(3,2,cnt); stem(k/K,magX);grid
 cnt = cnt+1;
xlabel('frequency in pi units'); title(['Magnitude Part ',num2str(N),' point'])
subplot(3,2,cnt); plot(k/K,angX/pi);grid
xlabel('frequency in pi units'); title(['Angle Part for ',num2str(N),' point'])
 cnt = cnt+1;
end



