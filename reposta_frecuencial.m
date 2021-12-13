hold off;
clear;
D = 0.001;
fs = 10000000;
t = 0:(1/fs):D-(1/fs);    
n = 1:1:D*fs;
C = 470e-9;
L = 22e-6;
R = 8;

num = 1000;
promigyx = 0;
promigy = 0;
promigx = 0;
for i = 1:num
    soroll = funcions.soroll(1,t,1);
    %soroll = funcions.chirp(20,20000,1,t);
    soroll_filtrat = funcions.lpf(soroll,R,L,C,fs);

    
                                      	
    FTx = abs(fft(soroll));
    FTy = abs(fft(soroll_filtrat));
%     Fs = 1;                                         % Sampling Frequency
%     Fn = Fs/2;
%     Fv = linspace(0, 1, fix(L/2)+1)*Fn;             % Frequency Vector
%     Iv = 1:length(Fv);                              % Index Vector

    TFyx = FTy./FTx;
    promigyx = promigyx + TFyx;
    promigy = promigy + FTy;
    promigx = promigx + FTx;
end

L = numel(soroll);
figure(1)
%subplot(2,1,1)
f = 0:1/D:fs/2-1/D;
If = 1:length(f);
semilogx(f,20*log10(promigyx(If)/sqrt(L)))
hold on;
semilogx(f,20*log10(promigy(If)/sqrt(L*promigx(1))))
hold on;
semilogx(f,20*log10(promigx(If)))
ylabel('|H(f)| (dB)')
% subplot(2,1,2)
% semilogx(Fv, angle(TFyx_promig(Iv))*180/pi)
% ylabel('Phase (°)')
% xlabel('Frequency (Hz)')