clear;
D = 0.01;
fs = 10000000;
t = 0:(1/fs):D-(1/fs);    
n = 1:1:D*fs;
C = 470e-9;
L = 22e-6;
R = 8;
freq = logspace(0,5,1000);
senyal = 0;
for i = 0:1000
    senyal = sin(2*pi*freq(i)*t);
    filtrada = funcions.lpf(senyal,R,L,C,fs);
    funcions.guany
end
