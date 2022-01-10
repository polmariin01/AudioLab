%Test 2 - Guany teoric

Fs = 48000;
t = 0:(1/Fs):D-(1/Fs);
n = 0 : 1 : D*Fs - 1;
A = 1;
G_theo = 5
fo = 1000;

%Generate the pure sinusoid at 1000Hz
signal = A * sin(2*pi*fo*t);
signal_amplified = G_theo * signal;

figure(2)
plot(t,signal);
title('Gain Measuring');
hold on;
plot(t, signal_amplified);
hold off;

G_calculated = guany(signal, signal_amplified)










function g = guany(x,y) % Gets the gain of the system (x-input, y-output) 
    px = sum(x.*x);
    py = sum(y.*y);
    g = sqrt(py/px);
end