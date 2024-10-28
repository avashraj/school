% Newton's Divided Differences Interpolation

% Newton's Divided Differences is a method used to construct an interpolating 
% polynomial for a given set of points. This method calculates the divided differences
% of the data points and builds the polynomial incrementally, making it more efficient 
% than the Lagrange method when adding new points. It is also numerically stable when 
% interpolating using a hierarchical form of the polynomial.

% The divided difference table is built recursively based on the formula:
% f[x0, x1, ..., xk] = (f[x1, ..., xk] - f[x0, ..., xk-1]) / (xk - x0)

% Once the divided differences are computed, the polynomial can be evaluated at any 
% given point by recursively multiplying the terms with factors (x - xi).

% Setup data points and points for prediction
datx = -3:1:3;  % Interpolation points (x-values where the function is known)
x = -3:.01:3;   % Points where we want to evaluate the interpolating polynomial

% Define the function we want to interpolate
f1 = @(x) exp(-x.^2);  

% Get the y-values at the interpolation points
daty = f1(datx);

% Perform Newton's Divided Differences interpolation
P5 = Newtons_divided_differences(x, datx, daty);  % Compute the polynomial at points 'x'

% Newton's Divided Differences interpolation function
function y = Newtons_divided_differences(x, datx, daty)
    % Input:
    % x - points where we want to evaluate the interpolating polynomial
    % datx - known x-values (interpolation points)
    % daty - known y-values corresponding to datx
    
    n = length(datx);  % Number of data points
    
    % Create an empty table for divided differences (nxn matrix)
    dd = zeros(n,n);  
    
    % First column of divided differences is simply the y-values (function values)
    dd(:, 1) = daty(:);  % Ensure that daty is treated as a column vector
    
    % Loop over the columns of the divided differences table (j: order of difference)
    for j = 2:n
        % Loop over the rows (i: index of the divided difference)
        for i = j:n
            % Compute the divided differences using the recursive formula
            % dd(i,j) = (dd(i,j-1) - dd(i-1,j-1)) / (datx(i) - datx(i-j+1))
            dd(i, j) = (dd(i, j-1) - dd(i-1, j-1)) / (datx(i) - datx(i-j+1));  % Adjust indices for MATLAB (1-based)
        end
    end
    
    % Now we evaluate the Newton interpolating polynomial at each point in 'x'
    y = zeros(size(x));  % Preallocate space for the output values
    
    % Loop over each evaluation point in 'x'
    for i = 1:length(x)
        % Initialize the polynomial value with the first divided difference (constant term)
        p = dd(1,1);  
        prod = 1;  % This will hold the cumulative product (x - datx(k))
        
        % Loop to build up the polynomial term-by-term
        for k = 2:n
            prod = prod * (x(i) - datx(k-1));  % Update the product term (x - datx(k-1))
            p = p + dd(k,k) * prod;  % Add the next term in the polynomial
        end
        
        % Store the evaluated value of the polynomial at x(i)
        y(i) = p;
    end
    
    y = y.';  % Return the output as a column vector (consistent with MATLAB format)
end

% Plotting the results
figure;
hold on;
plot(x, f1(x), 'k-', 'LineWidth', 1.5, 'DisplayName', 'f1(x) = exp(-x^2)');  % Original function
plot(x, P5, 'b--', 'LineWidth', 1.5, 'DisplayName', 'Newton Interpolation');  % Interpolated polynomial
hold off;
legend('show');  % Display legend
