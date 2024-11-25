f = @(t, y) -12 * y; 
sol = @(t) exp(-12 * t);
a = 0; b = 1; alpha = 1; 
N_values = [20, 50, 100];
Err = zeros(1, length(N_values)); 

y0 = RK2(f, a, b, alpha, N_values(1));
y1 = RK2(f, a, b, alpha, N_values(2));
y2 = RK2(f, a, b, alpha, N_values(3));

exact_value = sol(b);
Err(1) = abs(y0(end) - exact_value);
Err(2) = abs(y1(end) - exact_value);
Err(3) = abs(y2(end) - exact_value);

function y = RK2(f, a, b, alpha, N)
    h = (b - a) / N; 
    t = a;           
    y = zeros(N+1, 1); 
    y(1) = alpha; 
    
    for k = 1:N
        k1 = f(t, y(k));
        k2 = f(t + h, y(k) + h * k1);
        y(k+1) = y(k) + (h / 2) * (k1 + k2);
        t = t + h;
    end
end

t0 = linspace(a, b, length(y0)); 
t1 = linspace(a, b, length(y1)); 
t2 = linspace(a, b, length(y2));
plot(t0, y0, t1, y1, t2, y2)

loglog(N_values, Err)