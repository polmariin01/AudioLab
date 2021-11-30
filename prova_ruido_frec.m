%dibuixar repostes frecuencials
%creem les senyals
clear;
D = 0.0003;
fs = 1000000;
t = 0:(1/fs):D-(1/fs);    
n = 1:1:D*fs;
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
% a = zeros(1,size(t));
% for j = 1:size(t)
%     a(j) = sum(transformades(:,j))/num;
% end  




% soroll_filtrat = (funcions.lpf(soroll);
% trans = abs(fft(soroll_filtrat));
% 
% promig = 0;
% for i = 1:100
%     promig = promig + abs(fft(funcions.lpf(soroll(i:0),R,L,C,fs)));
% end
% promig = promig / 100;

figure(10)
plot(t,promedios);
figure(4)
subplot(2,1,1);
plot(t,soroll);
subplot(2,1,2);
plot(t,filtrades);
title("Soroll i soroll filtrat");
figure(5)
plot(t*fs,20*log10(abs(fft(soroll_filtrat))));
title("Resposta frecuencial del filtre (soroll)");
figure(6)
b= 20*log10(abs(fft(soroll_filtrat)));
plot(t(1:fs*D/4)*fs,b(1:fs*D/4));
title("Resposta frecuencial del filtre (soroll) ampliat");