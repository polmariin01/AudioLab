clear;
D = 1;
fs = 192000;
t = 0:(1/fs):D-(1/fs);    
n = 1:1:D*fs;
C = 470e-9;
L = 22e-6;
R = 8;
N = 100;
freq = logspace(0,5,N);
guanys = zeros(1,N);
senyal = 0;

for i = 1:N
    figure(1);
    senyal = sin(2*pi*freq(i)*t);
    hold on;
    player = (audioplayer(senyal,fs,16));
    recorder = audiorecorder(fs, 16, 1);
    record(recorder);
    playblocking(player);
    stop(recorder);
    filtrada = getaudiodata(recorder, 'single');
    i
    guany = funcions.guany(senyal,filtrada);
    guanys(i) = guany;
    figure(2);
    semilogx(freq,log10(guanys));
end

semilogx(freq,log10(guanys));

