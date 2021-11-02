%medició del TDH i el guany
fs = 44100;           
duration = 0.01;              
f = 3000; 
mostres = duration*fs;
t = 0:(1/fs):duration-(1/fs);    
n = 1:1:mostres;      
x = sin(2*pi*n*(f/fs))+ sin(2*pi*n*(2*f/fs));
soroll = 0.3*randn(1,fs*duration);
y = 10*x+soroll;



%funció que mesura el guany entre dues senyals x(entrada) i y(sortida)

function guany = guany(x,y)
    px = sum(x.*x)/(duration*fs);
    py = sum(y.*y)/(duration*fs);
    guany = sqrt(py/px);
end



%mesura de la THD 
A = 1;
z = A*sin(2*pi*n*(f/fs)); %senyal original
k = z+ A/4*sin(2*pi*n*(2*f/fs))+ A/8*sin(2*pi*n*(3*f/fs))+ A/32*sin(2*pi*n*(4*f/fs)); %senyal amb distorsió interharmònica
Kf = fft(k);
plot(n,abs(Kf));
[a,b] = max(abs(Kf(1:mostres/2)));
cicles = floor((mostres/2)/(b-1)); %utilitzem (b-1) perquè en el vector el primer índex es 1
valors = 0:1:cicles-2; %creem un vector buit per posar-hi els valors de les amplituds als diferents harmònics
for i = 2:cicles
    l = i*(b-1)+1;
    [valors(i),c] = max(abs(Kf(l-4:l+4)));
end
l = sum(valors*valors');
THD = sqrt(l)/a


