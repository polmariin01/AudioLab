fs = 44100;
duration = 0.1;
f = 2000;
mostres = duration*fs;
t = 0:(1/fs):duration-(1/fs);
t2 = 0:(1/fs):2*duration-(1/fs);
n = 1:1:mostres;      

%mesura de la THD 
A = 1;
o = A*sin(2*pi*n*(f/fs)); %senyal original
% d = o + 0.75*sin(2*pi*n*(1.2*f/fs))+ 0.5*sin(2*pi*n*(1.5*f/fs))+ 0.25*sin(2*pi*n*(2*f/fs));%senyal amb distorsió interharmònica
d = o;
num = 0;
for k = 2 : floor(fs/2 / f)
    Aj = 2^(-k);
    fj = k*f;
    d = d + Aj*sin(2*pi*n*(fj/fs));
    num = num + Aj^2;
end
THDteo = sqrt(num)/A
THDmesurat = thd(d)

ampli = 5*d;
G = guany(d,ampli)

function THD = thd(d)
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

function g = guany(x,y)
    px = (x(1).*x(1))/length(x);
    py = (y(1).*y(1))/length(y);
    g = sqrt(py/px);
end

% function THD = thd(z,k,mostres)  %z senyal entrada, k senyal sortida
%     Kf = fft(k);
%     [a,b] = max(abs(Kf(1:mostres/2)));
%     cicles = floor((mostres/2)/(b-1)); %utilitzem (b-1) perquè en el vector el primer índex es 1
%     valors = 0:1:cicles-2; %creem un vector buit per posar-hi els valors de les amplituds als diferents harmònics
%     for i = 2:cicles
%         l = i*(b-1)+1;
%         [valors(i),c] = max(abs(Kf(l-4:l+4)));
%     end
%     l = sum(valors*valors');
%     THD = sqrt(l)/a;
% end