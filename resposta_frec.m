%dibuixar repostes frecuencials
%creem les senyals
clear;
D = 0.0003;
fs = 10000000;
t = 0:(1/fs):D-(1/fs);    
n = 1:1:D*fs;
C = 470e-9;
L = 22e-6;
R = 5;
chirp = funcions.chirp(1,100000,1,t);
filtrada = (funcions.lpf(chirp,R,L,C,fs));
%CHIRP
figure(1)
subplot(2,1,1);
plot(t,chirp);
subplot(2,1,2);
plot(t,filtrada);
title("Chirp i chirp filtrada");
figure(2)
plot(t*fs,20*log10(abs(fft(filtrada))));
title("Resposta frecuencial del filtre (chirp)");
figure(3)
a= 20*log10(abs(fft(filtrada)));
plot(t(1:fs*D/4)*fs,a(1:fs*D/4));
title("Resposta frecuencial del filtre (chirp) ampliat");

%SOROLL GAUSSIÀ
soroll = funcions.soroll(1,t);
soroll_filtrat = (funcions.lpf(soroll,R,L,C,fs));
figure(4)
subplot(2,1,1);
plot(t,soroll);
subplot(2,1,2);
plot(t,soroll_filtrat);
title("Soroll i soroll filtrat");
figure(5)
plot(t*fs,20*log10(abs(fft(soroll_filtrat))));
title("Resposta frecuencial del filtre (soroll)");
figure(6)
b= 20*log10(abs(fft(soroll_filtrat)));
plot(t(1:fs*D/4)*fs,b(1:fs*D/4));
title("Resposta frecuencial del filtre (soroll) ampliat");

figure(7)
%plot(t*fs, 20*log10( abs(fft(chirp))));
% hold on;
plot(t*fs, 20*log10( abs(fft(filtrada))));
normalitzada = 20*log10(abs(fft(filtrada))/(fs*fs*D*D/100000));
hold on;
plot(t*fs,   normalitzada);
hold on;
plot(t(1:120)*fs, normalitzada(1:120));

% title("Resposta frecuencial del filtre normalitzada");
