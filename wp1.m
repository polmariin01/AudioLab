A = 2;
fo = 10;
D = 0.67;
fs = 44100;
t = 0:(1/fs):D-(1/fs);    
n = 0:1:D*fs-(1/fs);
a = dent_serra(4,15,t);
a = triangular(4,15,t);
plot(t,a);

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



