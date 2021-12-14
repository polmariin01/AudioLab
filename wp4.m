%programa que envia un audio
%en temps real medim el guany, la thd i (resposta frequencial)
clear
Fs           = 128000;   
duration     = 5;      
Nbits        = 16;
%generem la senyal que volem reproduir
F= 1000;                        
samples = duration*Fs;
t = 0:(1/Fs):duration-(1/Fs);    
%%
%chirp
y(:,1)  = sin(2*pi*F*t);                  
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
THD_ = thd2(signal)



%%
%GIL FREC RESP
D = 1;
fs = Fs;
t = 0:(1/Fs):D-(1/Fs);    
n = 1:1:D*Fs;

N = 100;
freq = logspace(0,5,N);
guanys = zeros(1,N);
senyal = 0;

for i = 1:N
    senyal = senyal + sin(2*pi*freq(i)*t);
end

    y2(:,1)  = senyal;                  
    y2(:,2)  = y2(:,1);
    
    player = audioplayer(y2, Fs, Nbits);
    recorder = audiorecorder(Fs, Nbits, 1);
    record(recorder,duration);
    playblocking(player);
    stop(recorder);
    signal = getaudiodata(recorder, 'single');

    guanys(i) = max(signal(:,1))/max(senyal);
    
figure(5)

TF1 = abs(fft(senyal));
TF2 = abs(fft(signal(:,1) , N));
valors = zeros(2,N);

for i = 1 : N -1
    %a = TF1(round(freq(i+1)));
    a = max( max(TF1(round(freq(i+1)) / Fs) - 1 , 1) : TF1(round(freq(i+1) )/Fs) +10);
    valors(1,i) = a;
    %valors(2,i) = TF2(round(freq(i+1)));
end



%freq2 = logspace(0,5,D*fs);
hold on
semilogx(freq ,20*log10(valors(1,:)),'b');
hold on
semilogx(freq ,20*log10(valors(2,:)),'r');
hold on
%semilogx(freq2 ,
%semilogx(freq ,20*log10(guanys));
hold off









%funcions prèvies
function guany = guany(x,y,mostres)
    px = (x(1).*x(1));
    py = (y(1).*y(1));
    guany = sqrt(py/px);
end

function THD = thd2(d)
    td = abs(fft(d));
%     Df = td(1:floor(length(td)/2));
    len = floor(length(td)/2)
    figure(1);
    plot( 0:len -1 , td(1:len) ); 
    
    figure(2);
    plot( 0:length(td) - 1, td);
    
    [a0,f0] = max(td(1:floor(len/2)));
    num_har = floor(len / f0)
    p_har = 0;
    
    for i = 2:num_har      
        [ai,fi] = max( td( floor( (i) * f0 - 5 ) : floor( (i) * f0 + 5 ) ) );
        p_har = p_har + ai^2;
    end
   
    THD = sqrt(p_har)/a0;
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