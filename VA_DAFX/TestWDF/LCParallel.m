Fs = 44100; % sample rate (Hz)
N = Fs; % number of samples to simulate

output = zeros(N,1);
CapVal = 3.1e-2; % the capacitance value in Farads
C1 = Capacitor(1/(2*CapVal*Fs));
%C1.State = 1;
Lval = 2.5e-6;
L1 = Inductor(Fs/2*Lval);
%L1.State = 1;
%R2 = Resistor(160); % create the capacitance
p1 = Parallel(C1,L1); % create WDF tree as a ser. conn. of V1,C1, and R1
r = 1/(2*pi*sqrt(CapVal*Lval)) % resonant frequency, from wiki: https://en.wikipedia.org/wiki/LC_circuit

gain = 30; % input signal gain parameter
f0 = 501; % excitation frequency (Hz)
t = 0:N-1; % time vector for the excitation
input = gain.*sin(2*pi*f0/Fs.*t); % the excitation signal

for i=1:N
    WaveUp(p1); % get the waves up to the root
    setWD(p1,input(i)); % open circuit structure b = 0?
    output(i) = Voltage(L1);

end
%% 
plot(output)
soundsc(output, Fs)