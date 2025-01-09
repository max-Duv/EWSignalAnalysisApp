% Feature Extraction; Computing features for the filtered signal:
signalEnergy = sum(filteredSignal.^2);
[~, peakIndex] = max(abs(fftFilteredSignal));
peakFrequency = frequencies(peakIndex);
% Bandwidth:
powerSpectrum = abs(fftFilteredSignal).^2; % Power spectral density
totalPower = sum(powerSpectrum);
cumulativePower = cumsum(powerSpectrum);
lowerIndex = find(cumulativePower >= 0.05 * totalPower, 1, 'first');
upperIndex = find(cumulativePower >= 0.95 * totalPower, 1, 'first');
bandwidth = frequencies(upperIndex) - frequencies(lowerIndex);

disp('Extracted Features:');
disp(['Signal Energy: ', num2str(signalEnergy)]);
disp(['Peak Frequency: ', num2str(peakFrequency), ' Hz']);
disp(['Bandwidth: ', num2str(bandwidth), ' Hz']);

% Mock dataset of signals; some normal activity some mock threat data;
% Simulating Multiple Signals
numSignals = 100; % Total number of signals
features = zeros(numSignals, 3); % Feature matrix (Energy, Peak Frequency, Bandwidth)
labels = zeros(numSignals, 1); % Labels (0 = Normal, 1 = Threat)

for i = 1:numSignals
    % Generate random signal frequency
    signalFreq = randi([80, 120]);  % Generates random frequency for each signal between 80 and 120 hz.
    signal = sin(2 * pi * signalFreq * t);

    % Add noise
    noisePower = rand * 0.5; % Random noise power
    noisySignal = signal + sqrt(noisePower) * randn(size(t));

    % Filter the signal
    filteredSignal = filtfilt(b, a, noisySignal);

    % Extract features
    fftSignal = fft(filteredSignal);
    signalEnergy = sum(filteredSignal.^2);
    [~, peakIndex] = max(abs(fftSignal));
    peakFrequency = frequencies(peakIndex);
    powerSpectrum = abs(fftSignal).^2;
    totalPower = sum(powerSpectrum);
    cumulativePower = cumsum(powerSpectrum);
    lowerIndex = find(cumulativePower >= 0.05 * totalPower, 1, 'first');
    upperIndex = find(cumulativePower >= 0.95 * totalPower, 1, 'first');
    bandwidth = frequencies(upperIndex) - frequencies(lowerIndex);

    % Store features
    features(i, :) = [signalEnergy, peakFrequency, bandwidth];

    labels(i) = rand < 0.3; % 1 = Threat, 0 = Normal
end

% Creating a Support Vector Machine (SVM) Classifer that'll be trained:
SVMModel_Classifier = fitcsvm(features, labels, 'KernelFunction','linear','ClassNames',[0,1]);
disp('SVM Classifier Trained Successfully');

% Testing the Model:
numTestSignals = 20;
testFeatures = zeros(numTestSignals, 3);
trueLabels = zeros(numTestSignals, 1);
for i = 1:numTestSignals
    signalFreq = randi([80, 120]);
    signal = sin(2 * pi * signalFreq * t);
    noisePower = rand * 0.5;
    noisySignal = signal + sqrt(noisePower) * randn(size(t));
    filteredSignal = filtfilt(b,a, noisySignal);
    fftSignal = fft(filteredSignal);
    signalEnergy = sum(filteredSignal.^2);
    [~, peakIndex] = max(abs(fftSignal));
    peakFrequency = frequencies(peakIndex);
    powerSpectrum = abs(fftSignal).^2;
    totalPower = sum(powerSpectrum);
    cumulativePower = cumsum(powerSpectrum);
    lowerIndex = find(cumulativePower >= 0.05 * totalPower, 1, 'first');
    upperIndex = find(cumulativePower >= 0.95 * totalPower, 1, 'first');
    bandwidth = frequencies(upperIndex) - frequencies(lowerIndex);
    testFeatures(i, :) = [signalEnergy, peakFrequency, bandwidth];
    trueLabels(i) = rand < 0.3; % Assigns true labels and has 30% of being a threat.
end
    % Make predictions with the trained model
    predictedLabels = predict(SVMModel_Classifier, testFeatures);
    % Calculateaccuracy
    accuracy = sum(predictedLabels == trueLabels) / numTestSignals * 100;
    disp(['Classifier Accuracy: ', num2str(accuracy), '%']);