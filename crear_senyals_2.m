% codi per crear els diferents tipus de senyals i representar-los

%sinusiode
fs           = 44100;            % Sampling Rate (check with your computer/sound board doc)
duration     = 1.0;              % Signal duration time in seconds
f = 10;                         % Frequency in Hz. 

t = 0:(1/fs):duration-(1/fs);    % Axis time.
n = 0:1:duration*fs-(1/fs);      % Index vector.
x = sin(2*pi*n*(f/fs))';         % Discrete signal generation.
% subplot(2,2,1)
% plot(t,x)
% axis([0 1 -1.1 1.1])
% xlabel('Time (sec)')
% ylabel('Amplitude') 
% title('Sinusoid Periodic Wave')

%pulse
fs           = 44100;            % Sampling Rate (check with your computer/sound board doc)
duration     = 1.0;              % Signal duration time in seconds
f = 10;                         % Frequency in Hz. 
t = 0:(1/fs):duration-(1/fs);    % Axis time.
n = 0:1:duration*fs-(1/fs);      % Index vector.
a = sin(2*pi*n*(f/fs))'; % Discrete signal generation.
b = 0;
for i = 1: duration*fs
    if(a(i)>0)
        a(i) = 1;
    else
        a(i)=-1;
    end    
end
% subplot(2,2,2)
% plot(t,a)
% axis([0 1 -1.1 1.1])
% xlabel('Time (sec)')
% ylabel('Amplitude') 
% title('Pulse train Wave')


% senyal triangular
A = 1;
fo = 5;
D = 1;
fs = 44100;
To = 1/fo;
Lperiod = To*fs;   
segmentElements = Lperiod/4 + 1;
segment1 = linspace(0, A, segmentElements);
segment2 = linspace(A, 0, segmentElements);
segment3 = linspace(0, -A, segmentElements);
segment4 = linspace(-A, 0, segmentElements);
period  =  [segment1,  segment2(2:end),  segment3(2:end), segment4(2:end-1)];
Nperiods = ceil(D/To);
tr = repmat(period, [1 Nperiods]);
% subplot(2,2,3)
% plot(t,tr)
% axis([0 1 -1.1 1.1])
% xlabel('Time (sec)')
% ylabel('Amplitude') 
% title('Triangular wave')


%dent de serra
A = 1;
fo = 5;
D = 1;
fs = 44100;
To = 1/fo;
Lperiod = To*fs;   
segmentElements = Lperiod ;
period = linspace(-A, A, segmentElements);

Nperiods = ceil(D/To);
st = repmat(period, [1 Nperiods]);
% subplot(2,2,4)
% plot(t,st)
% axis([0 1 -1.1 1.1])
% xlabel('Time (sec)')
% ylabel('Amplitude') 
% title('Sawtooth wave')

%soroll gausià blanc
soroll = randn(1,fs*duration);

%calcular i representar la fft d'una sinusiode

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
