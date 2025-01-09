% Creating a Low-Pass Filter For Noise Removal:
filterOrder = 4;
cutoffFreq = 150; % Cuttof freq in Hz
[b,a] = butter(filterOrder, cutoffFreq/(fs/2),'low'); % Low-pass 4th-order "Butterworth" filter; Assumes Signal Frequency is 100 Hz;
% Suppresses the high-freq noise.

% Applying filter to noisy signal

filteredSignal = filtfilt(b,a,noisySignal); % Applying the filter in both forward and reverse directions, aiming to remove phase distorts.

% Plotting Original with Noisy and Filtered Signals:
figure;
subplot(3,1,1);
plot(t, signal);
title('Original Radar Signal with Time Domain');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(3,1,2);
plot(t, noisySignal);
title('Noisy Radar Signal with Time Domain');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(3,1,3);
plot(t, filteredSignal);
title('Filtered Radar Signal with Time Domain');
xlabel('Time (s)');
ylabel('Amplitude');
