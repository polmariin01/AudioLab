fs           = 1000;            % Sampling Rate (check with your computer/sound board doc)
duration     = 1.0;              % Signal duration time in seconds                     
soroll = 0.5*randn(1,fs*duration);

f = 200;                         % Frequency in Hz. 

t = 0:(1/fs):duration-(1/fs);    % Axis time.
n = 0:1:duration*fs-1;      % Index vector.
x = sin(2*pi*n*(f/fs)) + soroll;         % Discrete signal generation.
transformada = fft(x);


subplot(2,1,1)
plot(t,x);
subplot(2,1,2)
plot(t,abs(transformada));

