function f = Fault(x)

K = 6.672e-3;
sig = 1;
y = [-15000 -10000 -5000 0 5000 10000 15000 20000];
g = 2 * K *sig*(x(3)*1000)*(pi + atan(y/(x(1)*1000) + cot(x(4))) - atan(y/(x(2)*1000) + cot(x(4))));
Diff  = g - [-2.24 -3.47 -5.60 0 2.02 1.61 1.27 1.04];
f = sumsqr(Diff);

end
