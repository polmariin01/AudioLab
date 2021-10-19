fs = 10000;
t = 0:1/fs:1.5;
f_serra = 3;
A = 4;
x1 = 2*A* mod(f_serra*t,1)-A;
%x1 = sawtooth(2*pi*50*t);

x2 = square(2*pi*50*t);

subplot(2,1,1)
plot(t,x1)
 axis([0 1.5 -A A])
% xlabel('Time (sec)')
% ylabel('Amplitude') 
% title('Sawtooth Periodic Wave')

% subplot(2,1,2)
% plot(t,x2)
% axis([0 0.2 -1.2 1.2])
% xlabel('Time (sec)')
% ylabel('Amplitude')
% title('Square Periodic Wave')