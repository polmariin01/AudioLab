D = 1;
fs = 44100;
t = 0:(1/fs):D-(1/fs);    
n = 1:1:D*fs;
f = 40;
T = 1/fs;

s = sinusoide(1,f,t);
tr = triangular(1.1,f*20,t);
c = comparador(s,tr);
figure(1);
subplot(3,1,1);
plot(t,s);
subplot(3,1,2);
plot(t,tr);
subplot(3,1,3);
plot(t,c);
linkaxes;
figure(2);
subplot(3,1,1);
plot(n/length(n),abs(fft(s)));
subplot(3,1,2);
transformada = abs(fft(c));
plot(n/length(n),transformada);
subplot(3,1,3);
L = 87*10^-6;
C = 0.68*10^-6;
R = 8;
filtrada = lpf(c,R,L,C,T,fs);
% plot(n/length(n),abs(fft(filtrada)));


plot(t,filtrada);


player = audioplayer(s,fs);
player2 = audioplayer(c,fs);
player3 = audioplayer(filtrada,fs);

play(player);
pause;
%delay(1000);
%wait(1000);
play(player2);
pause;
%wait(1000);
play(player3);


function serra = dent_serra(A,fo,t)
    serra = 2*(A*mod(fo*t,1)-A/2);
end
function tr = triangular(A,fo,t)
    tr = 2*abs(dent_serra(A,fo,t))-A;
end
function c = comparador(s1,s2)
    l = s2;
    for i = 1:length(s1)
        if(s1(i)>s2(i))
            l(i) = 1;
        else
            l(i) = -1;
        end    
    end
    c = l;
end
function s = sinusoide(A,fo,t)
    s = A*sin(2*pi*t*fo);
end

function senyal= power_amplifier(G,s)
    senyal = G*s;
end

function senyal = lpf(s,R,L,C,T,fs)
%     wo = 1/sqrt(L*C);
%     theta = 1/(2*R)*sqrt(L/C);
%     phi = wo * sqrt(1 - theta^2 )* T;
%     alfa = (-1) * theta * wo * T;
%     b = [exp(alfa)*sin(phi) 0];
%     a = [1 -2*exp(alfa)*cos(phi) exp(2*alfa)];
%     senyal = wo/sqrt(1-theta^2)*filter(b,a,s);
%     figure(4);
%     freqz(b,a,1024);

LC = L*C;
RC = R*C;
b  = [1/LC 2/LC 1/LC];
a = [(1+1/RC+1/LC) (2/LC-2) (1-1/RC+1/LC)]
senyal = filter(b,a,s);
figure(4);
freqz(,a,1024);

% wo = 1/(L*C);
% theta = L/(2*R);
% T = 1/fs;
% 
% a = wo / sqrt(1 - theta^2);
% 
% b =  wo * sqrt(1 - theta^2) * T;
% 
% c = (-1) * theta * wo * T;
% 
% num = a * [exp(c)*sin(b) 0];
% 
% den = [1 -2*exp(c)*cos(b) exp(2*c)];
% senyal = filter(num,den,s);
%  figure(4);
%  freqz(num,den,1024);
 end
