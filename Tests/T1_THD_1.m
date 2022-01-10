%We generate a signal with a artificial THD

%Initial parameters
D = 0.1;
Fs = 48000;
t = 0:(1/Fs):D-(1/Fs);
n = 0 : 1 : D*Fs - 1;
A0 = 1;
fo = 1000;
N = 23; %Num harmonics

%Generate the pure sinusoid at 1000Hz
senyal = A0 * sin(2*pi*fo*t);
sum_harm_sq = 0; %Sum harmonics squared

%9 harmonics
for i = 2:N
    A = A0 / i;
    senyal = senyal + A * sin(2*pi*fo*i*t);
    sum_harm_sq = sum_harm_sq + A^2;
end

plot(n, abs(fft(senyal)));
title('THD Measuring');
hold on;
thd_theo = sqrt(sum_harm_sq) / A0
thd_calculated = thd(senyal)
hold off;

%The same THD function that the final project has
function THD = thd(d) %Measures the THD of the d signal
        td = abs(fft(d));
        len = floor(length(td)/2);

        % Finds the first maximum and where is it located
        [a0,f0] = max(td(1:floor(len/2))); 
        scatter(f0,a0,'filled','r');
        %text(f0 + 100, a0, num2str(a0));
        hold on;
        num_har = floor(len / f0); % Calculates the number of harmonics the FFT will have
        p_har = 0; %Harmonics power

        %EXTRA FOR SHOWING A PLOT
        harmonics = zeros(num_har-1,2); %Primera fila amplitud, segona freq
        
        % Finds the power of every harmonic and adds them together
        for i = 1 : num_har - 1     
            [ai,fi] = max( td( floor( (i+1) * (f0-1) - 5 ) : floor( (i+1) * (f0-1) + 5 ) ) );
            p_har = p_har + ai^2;
            
            harmonics(i,1) = ai;
            harmonics(i,2) = (f0-1)*(i+1) - 5 + fi - 2;             
            %text((f0-1)*(i+1) - 5 + fi - 2, ai + 100, num2str(ai));
            hold on;
        end
        THD = sqrt(p_har)/a0; %THD calculation
        scatter(harmonics(:,2),harmonics(:,1),'g');
    end