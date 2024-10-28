% Composite Simpson's Rule for Numerical Integration

% The Composite Simpson's Rule is a numerical method for approximating the
% integral of a function over a given interval. It approximates the function by
% parabolic segments, rather than straight lines like the Trapezoidal Rule.
% The interval [a, b] is divided into an even number of subintervals, and the
% integral is computed by summing contributions from parabolas that fit pairs of points.

% Define the function we are integrating
f = @(x) cos(pi * x.^2 / 2);  % Function to integrate

% Define the number of subintervals for two different levels of accuracy
n1 = 10^3;  % First choice of subintervals (1000), must be even for Simpson's rule
n2 = 10^5;  % Second choice of subintervals (100,000), also even

% Define the integration limits
a = 0;  % Lower limit of integration
b = pi;  % Upper limit of integration

% Compute the approximate integral using the Composite Simpson's Rule
I3 = composite_simpsons(f, a, b, n1);  % Approximation with n1 subintervals
I4 = composite_simpsons(f, a, b, n2);  % Approximation with n2 subintervals

% The exact value of the integral is computed using the Fresnel cosine integral
exact_value = fresnelc(sqrt(pi)/sqrt(2));  % Exact integral value

% Compute the error for both approximations
Err3 = abs(I3 - exact_value);  % Error for n1 subintervals (Simpson's Rule)
Err4 = abs(I4 - exact_value);  % Error for n2 subintervals (Simpson's Rule)

% Plot the error on a log-log scale to visualize how the error decreases with increasing n
loglog([n1, n2], [Err3, Err4], '-o', 'DisplayName', 'Simpson Error')  % Log-log plot of the error
legend('show');  % Show the legend

% Composite Simpson's Rule function
function I = composite_simpsons(f, a, b, n)
    % Input:
    % f - the function to integrate
    % a - the lower limit of integration
    % b - the upper limit of integration
    % n - the number of subintervals (must be even)
    
    % Ensure that n is even
    if mod(n, 2) ~= 0
        error("n must be even for Simpson's Rule");
    end
    
    h = (b - a) / n;  % Step size (width of each subinterval)
    
    % Initialize the integral with the contributions from the endpoints
    I = f(a) + f(b);  % First and last terms of the Simpson's Rule
    
    % Loop over odd indices (corresponds to x_i where i is odd) and add 4*f(x_i)
    for i = 1:2:n-1
        x_i = a + i * h;  % Calculate the i-th point in the partition
        I = I + 4 * f(x_i);  % Add 4 * f(x_i) for odd indices
    end

    % Loop over even indices (corresponds to x_i where i is even) and add 2*f(x_i)
    for i = 2:2:n-2
        x_i = a + i * h;  % Calculate the i-th point in the partition
        I = I + 2 * f(x_i);  % Add 2 * f(x_i) for even indices
    end
    
    % Multiply the sum by h/3 to get the final integral value
    I = I * h / 3;
end
