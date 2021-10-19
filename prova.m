%dent de serra
fs           = 44101;            % Sampling Rate (check with your computer/sound board doc)
duration     = 1.0;              % Signal duration time in seconds
f = 10;                         % Frequency in Hz. 

t = 0:(1/fs):duration-(1/fs);    % Axis time.
l = duration*fs-(1/fs);
n = 0:1:l;      % Index vector.
c = l/f;
cicles = 0;
x = sin(2*pi*n*(f/fs))';
for i = 1 : l
    if(mod(i,c)==0)
        cicles = cicles +1;
    end
    x(i) = i/(c)-cicles*c;
end
subplot(2,1,1)
plot(t,x)
axis([0 2 -10 10])
xlabel('Time (sec)')
ylabel('Amplitude') 
title('Sinusoid Periodic Wave')