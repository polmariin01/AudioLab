
clear;
D = 1;
fs = 192000;
t = 0:(1/fs):D-(1/fs);
n = 1:1:D*fs;
C = 470e-9;
L = 22e-6;
R = 8;

num = 1000;
promigyx = 0;
promigy = 0;
promigx = 0;

t2 = 0:(1/fs):D*num-(1/fs);

soroll = funcions.soroll(1,t2,1);
soroll_filtrat = funcions.lpf(soroll,R,L,C,fs);

for i = 1:num
    FTx = abs(fft(soroll(1+fs*D*(i-1):fs*D*i)));
    FTy = abs(fft(soroll_filtrat(1+fs*D*(i-1):fs*D*i)));

    TFyx = FTy./FTx;
    promigyx = promigyx + TFyx;
    promigy = promigy + FTy;
    promigx = promigx + FTx;
end

lng = numel(soroll);
figure(1)
%subplot(2,1,1)
f = 0:1/D:fs/2-1/D;
If = 1:length(f);
% semilogx(f,20*log10(promigyx(If)))

prom = sum(promigx)/length(promigx);

semilogx(f,20*log10(promigy(If)/prom))
hold on;
grid on
% hold on;
% semilogx(f,20*log10(promigx(If)))
ylabel('|H(f)| (dB)')
% subplot(2,1,2)
% semilogx(Fv, angle(TFyx_promig(Iv))*180/pi)
% ylabel('Phase (°)')
% xlabel('Frequency (Hz)')