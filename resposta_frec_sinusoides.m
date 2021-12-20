clear;
D = 2;
fs = 192000;
t = 0:(1/fs):D-(1/fs);    
n = 1:1:D*fs;
C = 470e-9;
L = 22e-6;
R = 8;
N = 20;
freq = logspace(1.3,5,N);

guanys = zeros(1,N);
senyal = zeros(2,fs*D);






for i = 1:N
    %figure(1);
    senyal(1,:) = 0.02*sin(2*pi*freq(i)*t);
    senyal(2,:) = senyal(1,:);
    %hold on;
    player = (audioplayer(senyal,fs,16));
    recorder = audiorecorder(fs, 16, 2);
    record(recorder);
    playblocking(player);
    stop(recorder);
    filtrada = getaudiodata(recorder, 'single');
    
    %guany = funcions.guany(senyal(1,:),filtrada(:,1));
    guany = funcions.guany(filtrada(:,2),filtrada(:,1));

    %guany = max(filtrada)/max(senyal);
    guanys(i) = guany;
    figure(2);
    
    
    
    semilogx(freq,20*log10(guanys),'b');
    xlim([20 100000]);
    ylim([-50 20]);
    grid on;
end

semilogx(freq,20*log10(guanys));
xlim([20 100000]);
ylim([-50 20]);
grid on;

