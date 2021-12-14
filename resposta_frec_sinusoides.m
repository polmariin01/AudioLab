clear;
D = 0.1;
fs = 10000000;
t = 0:(1/fs):D-(1/fs);    
n = 1:1:D*fs;
C = 470e-9;
L = 22e-6;
R = 8;
N = 1000;
freq = logspace(0,5,N);
guanys = zeros(1,N);
senyal = 0;

for i = 1:N
    senyal = sin(2*pi*freq(i)*t);
    filtrada = funcions.lpf(senyal,R,L,C,fs);
    guanys(i) = max(filtrada)/max(senyal);
end

semilogx(freq,log10(guanys));

