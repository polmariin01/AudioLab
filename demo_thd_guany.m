fs = 44100;           
duration = 1;              
f = 3000; 
mostres = duration*fs;
t = 0:(1/fs):duration-(1/fs);    
n = 1:1:mostres;      

%mesura de la THD 
A = 1;
o = A*sin(2*pi*n*(f/fs)); %senyal original
d = o+ A/4*sin(2*pi*n*(2*f/fs))+ A/8*sin(2*pi*n*(3*f/fs))+ A/32*sin(2*pi*n*(4*f/fs)); %senyal amb distorsió interharmònica
a = 5*o;
G = guany(o,a,mostres)
distor = thd(o,d,mostres)


function guany = guany(x,y,mostres)
    px = (x(1).*x(1))/mostres;
    py = (y(1).*y(1))/mostres;
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
    THD = sqrt(l)/a;
end