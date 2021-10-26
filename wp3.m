D = 1;
fs = 44100;
t = 0:(1/fs):D-(1/fs);    
n = 1:1:D*fs;
s = sinusoide(1,4000,t);
tr = triangular(1.1,1.2*fs+1,t);
c = comparador(s,tr);
%subplot(2,1,1);
%plot(t,s);
%subplot(2,1,2);
%plot(t,tr);
%subplot(2,1,1);
%plot(t,c);
subplot(2,1,1);
transformada = abs(fft(c));
plot(n/length(n),transformada);
subplot(2,1,2);
filtrada = lpf(transformada);
plot(n,filtrada);

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

function senyal = lpf(s)
    transformada = abs(fft(s));
    [a,b] = max(transformada(5:length(transformada)));
    a
    b
    senyal = zeros([length(transformada) 1]);
    senyal(1:ceil(b*1.5)) = transformada(1:ceil(b*1.5));
end
