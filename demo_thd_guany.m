fs = 44100;
duration = 0.1;
f = 10000;
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
for j = 1:9
    Aj = 1-0.1*j;
    fj = (1+0.1*j)*f;
    d = d + Aj*sin(2*pi*n*(fj/fs));
    num = num + Aj^2;
end
THDteo = sqrt(num)/A
THDmesurat = thd(d)

ampli = 5*d;
G = guany(d,ampli)
function THD = thd(d)
    td = abs(fft(d));
    Df = td(1:floor(length(td)/2));
    figure(1);
    plot(1:length(Df),Df);
    [a,b] = max(Df);
    Df = Df(b+1:length(Df));
    figure(2);
    plot(1:length(Df),Df);
    i = 1;
    while 1
        [y,x] = max(Df);
        if(y<0.001)
            break;
        end
        Df = Df(x+1:length(Df));
        %figure(i+2);
        %plot(1:length(Df),Df);
        valors(i) = y;
        i = i+1;  
    end
    v = valors.*valors;
    w = sum(v);
    THD = sqrt(w)/a;
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