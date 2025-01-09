% Simulating Signal Data
fs = 1e3; % 1 kHz Sample Freq
t = 0:1/fs:1-1/fs; % t = Time vector, 1 sec duration

% Radar-esque signal: sinusoidal with chirp:
signalFreq = 100; % 100 Hz
signal = sin(2*pi*signalFreq*t);

% Adding Noise to the Signal:
noisePower = 0.5;
noisySignal = signal + sqrt(noisePower)*randn(size(t));

% plot signal:
figure;
subplot(2,1,1);

plot(t, noisySignal);
title('Noisy Radar Signal (Time Domain)');
xlabel('Time (s)');
ylabel('Amplitude (height)');

% Performing Fast Fourier Transform for Freq-Domain Analysis:
fftSignal = fft(noisySignal);
frequencies = (0:length(fftSignal)-1)*fs/length(fftSignal);
subplot(2,1,2);
plot(frequencies, abs(fftSignal));
title('Signal in Frequency Domain');
xlabel('Frequency (Hz)');
ylabel('Magnitude');