% Composite Trapezoidal Rule for Numerical Integration

% The Composite Trapezoidal Rule is a numerical method for approximating the 
% integral of a function over a given interval. The interval [a, b] is divided 
% into 'n' subintervals, and the area under the curve is approximated by 
% trapezoids formed between consecutive points. As 'n' increases, the approximation
% becomes more accurate.

% Define the function we are integrating
f = @(x) cos(pi * x.^2 / 2);  % Function to integrate

% Define the integration limits
a = 0;  % Lower limit of integration
b = pi;  % Upper limit of integration

% Define the number of subintervals for two different levels of accuracy
n1 = 10^3;  % First choice of subintervals (1000)
n2 = 10^5;  % Second choice of subintervals (100,000)

% Compute the approximate integral using the Composite Trapezoidal Rule
I1 = composite_trapezoid(f, a, b, n1);  % Approximation with n1 subintervals
I2 = composite_trapezoid(f, a, b, n2);  % Approximation with n2 subintervals

% Composite Trapezoidal Rule function
function I = composite_trapezoid(f, a, b, n)
    % Input:
    % f - the function to integrate
    % a - the lower limit of integration
    % b - the upper limit of integration
    % n - the number of subintervals
    
    h = (b - a) / n;  % Step size (width of each subinterval)

    % Initialize the integral with the contributions from the endpoints
    I = (f(a) + f(b)) / 2;  % (f(a) + f(b))/2 term handles the two end points
    
    % Loop over the subintervals and sum the values of the function at each x_i
    for i = 1:n-1
        x_i = a + i * h;  % Calculate the i-th point in the partition
        I = I + f(x_i);   % Add f(x_i) to the total integral
    end

    % Multiply the sum by the step size h to get the final integral value
    I = I * h;
end

% The exact value of the integral is computed using the Fresnel cosine integral
% fresnelc is the Fresnel cosine integral, which provides the exact solution for this type of problem
exact_value = fresnelc(sqrt(pi)/sqrt(2));  % Exact integral value

% Compute the error for both approximations
Err1 = abs(I1 - exact_value);  % Error for n1 subintervals
Err2 = abs(I2 - exact_value);  % Error for n2 subintervals

% Plot the error on a log-log scale to visualize how the error decreases with increasing n
loglog([n1, n2], [Err1, Err2], '-o', 'DisplayName', 'Error')  % Log-log plot of the error
legend('show');  % Display legend



