%programa que envia un audio
%en temps real medim el guany, la thd i (resposta frequencial)
clear
Fs           = 44100;   
duration     = 10;      
Nbits        = 16;
%generem la senyal que volem reproduir
F       = 20000;                        
samples = duration*Fs;
fmi     = (0:1:samples-1)'./(samples-1); 
x       = pi*(F/Fs)*(0:samples-1)';
%chirp
y(:,1)  = sin(x.*fmi);                  
y(:,2)  = y(:,1);
%soroll blanc gaussià
% y(:,1)  = ;                  
% y(:,2)  = y(:,1);
%reproduim i grabem
player = audioplayer(y, Fs, Nbits);
recorder = audiorecorder(Fs, Nbits, 1);
record(recorder,duration);
playblocking(player);
stop(recorder);
signal = getaudiodata(recorder, 'single');
[N,M]=size(signal);

%processem la senyal a la sortida del sistema
G = guany(y,signal,samples)
THD_ = thd(y,signal,samples)





%funcions prèvies
function guany = guany(x,y,mostres)
    px = (x*x)/mostres;
    py = (y.*y)/mostres;
    guany = sqrt(py/px);
end

function THD = thd(z,k,mostres)  %z senyal entrada, k senyal sortida
    Kf = fft(k);
    [a,b] = max(abs(Kf(1:mostres/2)));
    cicles = floor((mostres/2)/(b-1)); %utilitzem (b-1) perquè en el vector el primer índex es 1
    valors = 0:1:cicles-2; %creem un vector buit per posar-hi els valors de les amplituds als diferents harmònics
    for i = 2:cicles
        l = i*(b-1)+1;
        [valors(i),c] = max(abs(Kf(l-4:l+4)));
    end
    l = sum(valors*valors');
    THD = sqrt(l)/a
end
function serra = dent_serra(A,fo,t)
    serra = 2*(A*mod(fo*t,1)-A/2);
end
function tr = triangular(A,fo,t)
    tr = 2*abs(dent_serra(A,fo,t))-A;
end
function s = sinusoide(A,fo,t)
    s = A*sin(2*pi*t*fo);
end
function tren = polsos(A,fo,t)
    a = sinusoide(A,fo,t);
    for i = 1: length(a)
        if(a(i)>0)
            a(i) = 1;
        else
            a(i)=-1;
        end
    end
    tren = a;
end

function s = soroll(var,t)
    s = randn(var,length(t));
end

function c = chirp(f1,f2,A,t)
    frec = linspace(f1,f2,length(t));
    c = sin(2*pi*frec.*t);
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
function senyal= power_amplifier(G,s)
    senyal = G*s;
end