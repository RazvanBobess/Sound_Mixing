function filtered_signal = low_pass(signal, fs, cutoff_freq)
  signal_fft = fft(signal);
  
  n = length(signal);
  f = (0:n-1) * fs / n;
  
  mask = f <= cutoff_freq;
  
  filtered_fft = signal_fft .* mask';
  
  filtered_signal = ifft(filtered_fft);
  
  filtered_signal = filtered_signal / max(abs(filtered_signal));
end
