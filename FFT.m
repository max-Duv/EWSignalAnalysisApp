% FFT sections compute freq-domain and normalizes the magnitude.
% FFT Noisy:
fftNoisySignal = fft(noisySignal);
magnitudeNoisy = abs(fftNoisySignal) / length(fftNoisySignal);
frequencies = (0:length(fftNoisySignal)-1) * fs / length(fftNoisySignal); % Freq axis
% FFT Filtered:
fftFilteredSignal = fft(filteredSignal);
magnitudeFiltered = abs(fftFilteredSignal) / length(fftFilteredSignal);

% Plotting Freq Domain
figure;

subplot(2,1,1);
plot(frequencies, magnitudeNoisy);
title('Noisy Signal - Freq Domain');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
xlim([0, fs/2]); % Plots up to Nyquist freq.

subplot(2,1,2);
plot(frequencies, magnitudeFiltered);
title('Filtered Signal -Freq Domain');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
xlim([0,fs/2]); % Plots up to Nyquist freq.

% Plots up to Nyquist freq (fs/2) since higher frequencies aren't
% meaningful or viewable in this project.
% Looking for a peak at 100 Hz and additional noise across other frequencies in the Noisy Signal plot.
% In the filtered sigal plot, the noise should ideally be significantly
% reduced, having a sharp peak at ~100 Hz.