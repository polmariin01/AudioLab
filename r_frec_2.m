clear;
D = 1;
fs = 10^5;
t = 0:(1/fs):D-(1/fs);    
n = 1:1:D*fs;
f = 0:1/D:fs-(1/D);
F = f/fs;
C = 470e-9;
L = 22e-6;
R = 5;

%SOROLL GAUSSIÀ
num = 100;
soroll = funcions.soroll(1,t,num);
% transformades = zeros(num,size(t));
promedios = zeros(1,length(t));
filtrades = zeros(1,length(t));
for i = 1:num
    filtrades(i,:) = funcions.lpf(soroll(i,:),R,L,C,fs);
%     transformades(i,:) = abs(fft(filtrada));
    promedios = promedios + abs(fft(filtrades(i,:)));
end
promedios = promedios / (D*fs*num);
figure(9)
plot(f,promedios);
figure(10)
semilogx((f(1:round(D*fs/2))),20*log10(promedios(1:round(D*fs/2))));