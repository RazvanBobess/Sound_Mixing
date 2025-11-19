function coef = spline_c2 (x, y)
	% Remember that the indexes in Matlab start from 1, not 0

	n = length(x) - 1;
	h = diff(x);

	A = zeros(n + 1, n + 1);
	rhs = zeros(n + 1, 1);

	% si(x)   = ai + bi(x - xi) + ci(x - xi)^2 + di(x - xi)^3
	% si'(x)  =      bi         + 2ci(x - xi)  + 3di(x - xi)^2
	% si''(x) =                   2ci          + 6di(x - xi)

	% TOOD 1: si(xi) = yi, i = 0 : n - 1

	A(1, 1) = 1;
	A(n + 1, n + 1) = 1;
	rhs(1) = 0;
	rhs(n + 1) = 0;

	for i = 2:n
		A(i, i - 1) = h(i-1) / 6;
		A(i, i) = (h(i - 1) + h(i)) / 3;
		A(i, i+1) = h(i) / 6;
		rhs(i) = (y(i+1) - y(i)) / h(i) - (y(i) - y(i-1)) / h(i-1);
	end

	% TODO 2: s_n-1(xn) = yn

	M = A \ rhs;

	coef = zeros(4 * n, 1);

	% TODO 3: si(x_i+1) = s_i+1(x_i+1), i = 0 : n - 1

	for i=1:n
		coef(4*i - 3, 1) = y(i);
		coef(4*i -2, 1) = (y(i+1) - y(i)) / h(i) - (2 * h(i) * M(i) + h(i) * M(i + 1)) / 6;
		coef(4*i - 1, 1) = M(i) / 2;
		coef(4*i, 1) = (M(i+1)-M(i)) / (6 * h(i));
	endfor

	% TODO 4: si'(x_i+1) = s_i+1'(x_i+1), i = 0 : n - 1

	% TODO 5: si''(x_i+1) = s_i+1''(x_i+1), i = 0 : n - 1

	% TODO 6: s0''(x0) = 0

	% TODO 7: s_n-1''(x_n) = 0

	% Solve the system of equations
end