%dibuixar repostes frecuencials
%creem les senyals
D = 0.0003;
fs = 10000000;
t = 0:(1/fs):D-(1/fs);    
n = 1:1:D*fs;
C = 470e-9;
L = 22e-6;
R = 5;
chirp = funcions.chirp(20,200000,1,t);
filtrada = (funcions.lpf(chirp,R,L,C,fs));
%
figure(1)
subplot(2,1,1);
plot(t,chirp);
subplot(2,1,2);
plot(t,filtrada);
figure(2)
plot(t*fs,20*log10(abs(fft(filtrada))));
title("Resposta frecuencial del filtre")