%creem les senyals
D = 0.0003;
fs = 600000;
t = 0:(1/fs):D-(1/fs);    
n = 1:1:D*fs;
f = 20000;
T = 1/fs;
s = sinusoide(1,f,t);
tr = triangular(1.1,f*20,t);
c = comparador(s,tr);
%les visualitzem
figure(1);
subplot(3,1,1);
plot(t,s);
subplot(3,1,2);
plot(t,tr);
subplot(3,1,3);
plot(t,c);
%transformada de la pmw
% transformada = abs(fft(c));
% figure(2);
% plot(transformada);








%funcions previes
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

function senyal = lpf(s,R,L,C,fs)
LC = L*C;
RC = R*C;
b  = [1/LC 2/LC 1/LC];
a = [(4*fs^2+2*fs/RC+1/LC) (2/LC-8*fs^2) (4*fs^2-2*fs/RC+1/LC)]
figure(4);
freqz(b,a,1024);
senyal = filter(b,a,s);
 end