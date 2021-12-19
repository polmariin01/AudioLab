%llegir fitxer i convertir a fs desitjada
Nbits = 16;
[y,Fs] = audioread('fitxer_prova.wav');
plot(y);
modificada = interpn(y,2);
player = audioplayer(modificada, Fs, Nbits);
play(player);