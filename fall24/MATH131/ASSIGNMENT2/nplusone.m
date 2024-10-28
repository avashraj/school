% Numerical Differentiation using (n + 1)-Point Methods

% The purpose of this script is to numerically approximate the derivative of a function
% at a specific point using different finite difference methods: Forward Difference, 
% 3-Point Centered Difference, and 5-Point Centered Difference. We compare the errors 
% of these methods by computing the difference between the numerical derivative and 
% the actual derivative (calculated analytically).

% The (n + 1)-point method refers to using either 2, 3, or more points to approximate
% the derivative. More points generally increase accuracy by capturing more information
% about the function’s local behavior, but can also introduce complexity.

% Define the function f(x) and its analytical derivative f'(x)
f = @(x) (x.^2 - 3.*x + 2) .* atan(x);  % Function for which we want the derivative
fprime = @(x) atan(x).*(2.*x-3) + ((x.^2-3.*x+2)./(x.^2+1));  % Analytical derivative of f(x)

% Point at which we will predict the derivative
x0 = 0;  % Point where we want to approximate the derivative
fprimeatx = fprime(x0);  % True derivative at x0 using the analytical derivative

% Different step sizes (h values) we will use for the finite differences
H_VALUES = 10.^(-[1, 3, 6]);  % Step sizes h = 10^(-1), 10^(-3), 10^(-6)

% Initialize variables to store the computed numerical derivatives
FD1 = 0; FD3 = 0; FD6 = 0;    % Forward Difference values for each h
CD31 = 0; CD33 = 0; CD36 = 0;  % 3-Point Centered Difference values for each h
CD51 = 0; CD53 = 0; CD56 = 0;  % 5-Point Centered Difference values for each h

% Initialize arrays to store the errors for each method
error_FD = zeros(size(H_VALUES));   % Error for Forward Difference
error_CD3 = zeros(size(H_VALUES));  % Error for 3-Point Centered Difference
error_CD5 = zeros(size(H_VALUES));  % Error for 5-Point Centered Difference

% Loop over each step size h to compute the numerical derivative and errors
for i = 1:length(H_VALUES)
    h = H_VALUES(i);  % Get the current step size
    
    % Forward Difference Method: f'(x) ≈ (f(x0 + h) - f(x0)) / h
    FD = (f(x0 + h) - f(x0)) / h;  % Compute Forward Difference approximation
    error_FD(i) = abs(FD - fprimeatx);  % Compute the error for FD
    
    % Store FD values for each step size
    if i == 1
        FD1 = FD;
    elseif i == 2
        FD3 = FD;
    elseif i == 3
        FD6 = FD;
    end

    % 3-Point Centered Difference Method: f'(x) ≈ (f(x0 + h) - f(x0 - h)) / (2h)
    CD3 = (f(x0 + h) - f(x0 - h)) / (2 * h);  % Compute 3-Point Centered Difference
    error_CD3(i) = abs(CD3 - fprimeatx);  % Compute the error for CD3
    
    % Store CD3 values for each step size
    if i == 1
        CD31 = CD3;
    elseif i == 2
        CD33 = CD3;
    elseif i == 3
        CD36 = CD3;
    end
    
    % 5-Point Centered Difference Method: f'(x) ≈ (-f(x0 + 2h) + 8*f(x0 + h) - 8*f(x0 - h) + f(x0 - 2h)) / (12h)
    CD5 = (-f(x0 + 2*h) + 8*f(x0 + h) - 8*f(x0 - h) + f(x0 - 2*h)) / (12 * h);  % Compute 5-Point Centered Difference
    error_CD5(i) = abs(CD5 - fprimeatx);  % Compute the error for CD5
    
    % Store CD5 values for each step size
    if i == 1
        CD51 = CD5;
    elseif i == 2
        CD53 = CD5;
    elseif i == 3
        CD56 = CD5;
    end

end

% Plot the errors in a log-log scale to compare the performance of each method
figure;
loglog(H_VALUES, error_FD, '-o', 'DisplayName', 'Forward Difference')  % Plot error for Forward Difference
hold on
loglog(H_VALUES, error_CD3, '-x', 'DisplayName', '3-Point Centered Difference')  % Plot error for 3-Point Centered Difference
loglog(H_VALUES, error_CD5, '-s', 'DisplayName', '5-Point Centered Difference')  % Plot error for 5-Point Centered Difference
hold off
legend('show');  % Show the legend to distinguish the methods
