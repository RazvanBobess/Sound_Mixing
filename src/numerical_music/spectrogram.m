function [S f t] = spectrogram(signal, fs, window_size)
  f = 0;
  t = 0;

  signal_length = length(signal);
  num_windows = floor(signal_length / window_size);

  f = (0:window_size-1)' * fs / (2 *window_size);

  hn = hanning(window_size);

  for i = 1:num_windows
        window = signal((i - 1) * window_size + 1 : i * window_size);
        FT = fft(window .*hn , 2 * window_size);
        S(:, i) = abs(FT(1 : window_size));
  endfor

  t = (0:num_windows-1)' * window_size / fs;
endfunction

