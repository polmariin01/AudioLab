D = 1;
fs = 44100;
t = 0:(1/fs):D-(1/fs);    
n = 1:1:D*fs;
f = 400;
T = 1/fs;

s = sinusoide(1,f,t) + 1/2*sinusoide(1,2*f,t) + 1/3*sinusoide(1,3*f,t) + 1/4*sinusoide(1,4*f,t);
tr = triangular(1.1,f*20,t);
c = comparador(s,tr);
subplot(2,1,1);
plot(t,s);
subplot(2,1,2);
plot(t,tr);
subplot(2,1,1);
plot(t,c);
% figure(1);
% subplot(3,1,1);
% plot(n/length(n),abs(fft(s)));
% subplot(3,1,2);
% transformada = abs(fft(c));
% plot(n/length(n),transformada);
% subplot(3,1,3);
% L = 1*10^-4;
% C = 4*10^-5;
% R = 8;
% filtrada = lpf(c,R,L,C,T);
% plot(n/length(n),abs(fft(filtrada)));
% 
% figure(2);
% subplot(2,1,1);
% plot(t,s);
% subplot(2,1,2);
% plot(t,filtrada);
% 
% player = audioplayer(s,fs);
% player2 = audioplayer(c,fs);
% player3 = audioplayer(filtrada,fs);
% 
% play(player);
% pause;
% %delay(1000);
% %wait(1000);
% play(player2);
% pause;
% %wait(1000);
% play(player3);


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

function senyal = lpf(s,R,L,C,T)
    wo = 1/sqrt(L*C);
    theta = 1/(2*R)*sqrt(L/C);
    phi = wo * sqrt(1 - theta^2 )* T;
    alfa = (-1) * theta * wo * T;
    b = [exp(alfa)*sin(phi) 0];
    a = [1 -2*exp(alfa)*cos(phi) exp(2*alfa)];
    senyal = wo/sqrt(1-theta^2)*filter(b,a,s);
end
