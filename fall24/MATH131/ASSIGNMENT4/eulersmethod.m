a = 0; %coding exam3 problem 2 making a correct value
b = 2; %coding exam3 problem 2 making b correct value

%coding exam 3 problem 2
%f = @(t, y) (sin(2*t) - 2*t*y)/(t^2);
f = @(t, y) (y^2) * (cos(25 * t)); %new ode
sol = @(t) 25 / (25 - sin(25 * t)); %solution provided in hint
true_val = sol(2); %actual value needed for error calc

N = 10;
N1 = 100;
N2 = 1000;

alpha = 1; %coding exam3 problem 2 making alpha correct val

y0 = euler_timestep(f, a, b, alpha, N);
y1 = euler_timestep(f, a, b, alpha, N1);
y2 = euler_timestep(f, a, b, alpha, N2);



function y = euler_timestep(f, a, b, alpha, N)
    steps = linspace(a, b, N + 1);
    step_size = steps(2) - steps(1);
    y = zeros(N + 1, 1);
    y(1) = alpha;
    for i = 1:N
        y(i + 1) = y(i) + step_size * f(steps(i), y(i));
    end
end

%coding exam 3 problem 3/4:
y1_heun = heuns_method(f, a, b, alpha, N1);
erry1 = abs(y1_heun(end) - true_val);
y0_heun = heuns_method(f, a, b, alpha, N);
erry0 = abs(y0_heun(end) - true_val);
y2_heun = heuns_method(f,a,b,alpha,N2);
erry2 = abs(y2_heun(end) - true_val);


function y = heuns_method(f, a, b, alpha, N)
    steps = linspace(a,b,N + 1);
    step_size = steps(2) - steps(1);
    y = zeros(N + 1, 1);
    y(1) = alpha;
    for i = 1:N
        y(i + 1) = y(i) + step_size/2 * (f(steps(i), y(i)) + f(steps(i + 1), y(i) + step_size * f(steps(i), y(i))));
    end


end


t0 = linspace(a, b, N + 1)';
t1 = linspace(a, b, N1 + 1)';
t2 = linspace(a, b, N2 + 1)';

%figure
%plot(t0, y0, '-o', t1, y1, '-x', t2, y2, '-s');

syms y(t)
Dy = diff(y);
ode = Dy == (sin(2 * t) - 2 * t * y) / t^2;
cond = y(1) == 2;
exactSol = dsolve(ode, cond);
exactVal = double(subs(exactSol, t, 5));

error0 = abs(y0(end) - exactVal);
error1 = abs(y1(end) - exactVal);
error2 = abs(y2(end) - exactVal);

%CODING EXAM 3 problem two getting the error for y2
erry2 = abs(y2(end) - true_val);

%figure
%loglog([N, N1, N2], [error0, error1, error2], '-o');

%CODING EXAM 3: getting the h values to calculate order of conv
bro = linspace(a, b, N1 + 1);
bro1 = linspace(a,b,N2 + 1);
h1 = bro(2) - bro(1);
h2 = bro1(2) - bro1(1);
bro0 = linspace(a,b,N + 1);
h0 = bro0(2) - bro0(1);

%calculating order of convergence
p = log(erry2/erry0)/log(h2/h0)