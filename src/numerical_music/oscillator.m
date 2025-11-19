function x = oscillator(freq, fs, dur, A, D, S, R)
  %x = 0;
  t = 0:1/fs:dur-1/fs;
  x = sin(2*pi*freq*t);

  total_samples = length(x);
  A_sample = floor(A * fs);
  D_sample = floor(D * fs);
  R_sample = floor(R * fs);
  S_sample = total_samples - A_sample - D_sample - R_sample;

  A_envelope = linspace(0, 1, A_sample);
  D_envelope = linspace(1, S, D_sample);
  S_envelope = S * ones(1, S_sample);
  R_envelope = linspace(S, 0, R_sample);

  envelope = [A_envelope, D_envelope, S_envelope, R_envelope];

  x = (x .* envelope)';
endfunction