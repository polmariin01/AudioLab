%dibuixar repostes frecuencials
%creem les senyals
clear;
D = 0.01;
fs = 1000000;
t = 0:(1/fs):D-(1/fs);    
n = 1:1:D*fs;
C = 470e-9;
L = 22e-6;
R = 5;

%SOROLL GAUSSIÀ
num = 1000;
%soroll = funcions.soroll(1,t,num);
% transformades = zeros(num,size(t));
promedios = 0;
potencia_total = 0;
potenciaF_total = 0;
mitja_soroll = 0;
for i = 1:num
    soroll = funcions.soroll(1,t,1);
    soroll_filtrat = funcions.lpf(soroll,R,L,C,fs);
    FTsoroll = abs(fft(soroll_filtrat));
    FTsoroll_meitat = FTsoroll(1:round(length(FTsoroll))/2);
    promedios = promedios + FTsoroll_meitat;
    
    potencia = sum(soroll.*soroll);
    potenciaF = sum(soroll_filtrat.*soroll_filtrat);
    
    potencia_total = potencia_total + potencia;
    potenciaF_total = potenciaF_total + potenciaF;
    
    mitja_soroll = mitja_soroll + soroll;
end
potenciaF_total/potencia_total
%potencia_total = potencia_total/num;

promedios = promedios/num/sqrt(length(t));

f = 0:1/D:fs/2-1/D;
f2 = logspace(0,5-1/(fs*D),(fs*D)/2);
figure(1);
semilogx(f,20*log10(promedios));

figure(2);
mitja_soroll = mitja_soroll/num;
semilogx(t,20*log10(abs(fft(mitja_soroll))));

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

% figure(10)
% plot(t,promedios);
% figure(4)
% subplot(2,1,1);
% plot(t,soroll);
% subplot(2,1,2);
% plot(t,filtrades);
% title("Soroll i soroll filtrat");
% figure(5)
% plot(t*fs,20*log10(abs(fft(soroll_filtrat))));
% title("Resposta frecuencial del filtre (soroll)");
% figure(6)
% b= 20*log10(abs(fft(soroll_filtrat)));
% plot(t(1:fs*D/4)*fs,b(1:fs*D/4));
% title("Resposta frecuencial del filtre (soroll) ampliat");