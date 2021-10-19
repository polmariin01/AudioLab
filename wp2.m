fs           = 44100;           
duration     = 0.01;              
f = 3000;                         

t = 0:(1/fs):duration-(1/fs);    
n = 0:1:duration*fs-(1/fs);      
x = sin(2*pi*n*(f/fs))+ sin(2*pi*n*(2*f/fs));
soroll = 0.3*randn(1,fs*duration);
y = 10*x+soroll;
%%mesura del guany
t_x = fft(x);
t_y = fft(y);
syms T;
px = sum(x.*x)/(duration*fs);
py = sum(y.*y)/(duration*fs);
guany = sqrt(py/px);
fprintf("guany = "+guany+"\n")

%%mesura de la THD 
A = 1;
z = A*sin(2*pi*n*(f/fs));
k = A*sin(2*pi*n*(f/fs))+ A/2*sin(2*pi*n*(2*f/fs))+ A/4*sin(2*pi*n*(3*f/fs))+ A/8*sin(2*pi*n*(4*f/fs));
Kf = fft(k);
plot(n,abs(Kf));
[a,b] = max(abs(Kf))



