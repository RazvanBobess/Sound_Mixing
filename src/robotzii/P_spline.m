function y_interp = P_spline(coef, x, x_interp)
  n = length(x);
  y_interp = zeros(size(x_interp));

  for i = 1:length(x_interp)
    for j = 1:n-1
      if x(j) <= x_interp(i) && x_interp(i) <= x(j+1)
        a = coef(4 * j - 3);
        b = coef(4 * j - 2);
        c = coef(4 * j - 1);
        d = coef(4 * j);
        
        h = x_interp(i) - x(j);
        
        y_interp(i) = a + b * h + c * h^2 + d * h^3;
        
        break;
      endif
    endfor
  endfor
endfunction

