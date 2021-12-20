classdef funcions

    methods (Static)
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
%         figure(4);
%         freqz(b,a,1024);
        senyal = filter(b,a,s);
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
        
        function s = soroll(var,t,n)
            s = var.*randn(n,length(t));
        end
        
        function c = chirp(f1,f2,A,t)
            frec = linspace(f1,f2,length(t));
            c = sin(2*pi*frec.*t);
        end
        function g = guany(x,y)
            px = sum(x.*x)
            py = sum(y.*y)
            g  = sqrt(py/px);
        end
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
            valors = 0;
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
    end
end