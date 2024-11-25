f = @(t, y) -12 * y; 
sol = @(t) exp(-12 * t); 
a = 0; b = 1; y0 = 1; 
N_values = [20, 50, 100];
Err1 = zeros(1, length(N_values)); 

y3 = RK4(f, a, b, y0, N_values(1));
y4 = RK4(f, a, b, y0, N_values(2));
y5 = RK4(f, a, b, y0, N_values(3));

exact_value = sol(b);
Err1(1) = abs(y3(end) - exact_value);
Err1(2) = abs(y4(end) - exact_value);
Err1(3) = abs(y5(end) - exact_value); 

function y = RK4(f, a, b, y0, N)
    h = (b - a) / N; 
    t = a;           
    y = zeros(N+1, 1); 
    y(1) = y0; 
    
    for k = 1:N
        k1 = f(t, y(k));
        k2 = f(t + h/2, y(k) + h/2 * k1);
        k3 = f(t + h/2, y(k) + h/2 * k2);
        k4 = f(t + h, y(k) + h * k3);
        y(k+1) = y(k) + (h / 6) * (k1 + 2*k2 + 2*k3 + k4);
        t = t + h;
    end
end

t3 = linspace(a, b, length(y3)); 
t4 = linspace(a, b, length(y4)); 
t5 = linspace(a, b, length(y5)); 
plot(t3, y3, t4, y4, t5, y5)

loglog(N_values, Err1)