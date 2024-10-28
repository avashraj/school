% Lagrange Polynomial Interpolation

% The Lagrange interpolation polynomial is a method for constructing a polynomial
% that passes through a given set of points. For n data points, the interpolating 
% polynomial is constructed by summing n Lagrange basis polynomials, each of which 
% is zero at all but one of the data points. This method avoids solving linear 
% systems, making it computationally easier when dealing with few points.

% The Lagrange polynomial at point x for data points (datx, daty) is given by:
% P(x) = sum( daty(k) * Lk(x) ), where Lk(x) is the Lagrange basis polynomial
% defined as:
% Lk(x) = product ( (x - datx(j)) / (datx(k) - datx(j)) ) for j ≠ k.

% Setting up data points and prediction points

datx = -3:1:3; % CODING EXAM commented out datx to make datx the chebyshev
%points
x = -3:.01:3;   % Points where we want to predict (finer grid for plotting)


%QUESTION 3 CODING EXAM - created chebyshev points for 1 to 7 for datx
n = 7;
 datx = 1:7;
 for k = 1:7
    cheb = @(x) 3 * cos((2.*k - 1).*pi / (2 .* n));
    datx(k) = cheb(k);
 end

%QUESTION 4 CODING EXAM - created chebyshev points for 1 to 15 for datx1
 n = 15;
 datx1 = 1:15;
 for k = 1:15
    cheb = @(x) 3 * cos((2.*k - 1).*pi / (2 .* n));
    datx1(k) = cheb(k);
 end

% Define two functions that we'll interpolate using Lagrange polynomials
f1 = @(x) exp(-x.^2);  
f2 = @(x) 1./(1+x.^2);  

% Interpolating and predicting values for the first function
daty = f1(datx);        % Get the y-values of interpolating points for f1
P1 = Lagrange_poly(x,datx,daty);  % Interpolated polynomial for f1 at points 'x'

% Interpolating and predicting values for the second function
daty = f2(datx);        % Get the y-values of interpolating points for f2
P2 = Lagrange_poly(x,datx,daty);  % Interpolated polynomial for f2 at points 'x'

% Now use a denser grid of interpolation points to see the effect on accuracy


%%CODING EXAM commented out datx1 to make it chebyshev points
%datx1 = -3:.5:3;        % More interpolation points with smaller spacing


daty = f1(datx1);       % y-values of the new interpolation points for f1
P3 = Lagrange_poly(x,datx1, daty);  % Interpolated polynomial for f1 (denser grid)

daty = f2(datx1);       % y-values of the new interpolation points for f2
P4 = Lagrange_poly(x,datx1,daty);  % Interpolated polynomial for f2 (denser grid)

% Lagrange polynomial interpolation function
function y = Lagrange_poly(x,datx,daty)
    % Input:
    % x - points where we want to evaluate the interpolating polynomial
    % datx - known x-values (interpolation points)
    % daty - known y-values corresponding to the datx points
    
    n = length(datx);  % Number of interpolation points
    lnk = zeros(n, length(x));  % Preallocate for the Lagrange basis polynomials
    
    % Loop over each interpolation point to calculate its corresponding Lagrange basis polynomial
    for k = 1:n
        prod = 1;  % Initialize the product for the Lagrange basis polynomial Lk(x)
        
        % Nested loop to compute the product for the basis polynomial Lk(x)
        for i = 1:n
            if i == k  % Skip if i equals k to avoid dividing by zero
                continue;
            else
                % Compute the product term (x - datx(i)) / (datx(k) - datx(i))
                prod = prod .* (x - datx(i)) / (datx(k) - datx(i));
            end
        end
        % Store the k-th Lagrange basis polynomial
        lnk(k,:) = prod;
    end
    
    % Initialize the output y, which will be the final interpolated polynomial values at points 'x'
    y = zeros(1, length(x));
    
    % Sum over all Lagrange basis polynomials to form the final polynomial
    for j = 1:n
        % Multiply each Lagrange basis polynomial by its corresponding y-value and sum them
        y = y + (daty(j) .* lnk(j,:));
    end
    
    % Transpose the result to match the expected output format
    %y = y.';
end

% 
% figure;
% hold on;
% % Plot actual function f1
% plot(x, f1(x), 'k-', 'LineWidth', 1.5, 'DisplayName', 'f1(x) = exp(-x^2)');
% % Plot Lagrange interpolation P1
% plot(x, P1, 'r--', 'LineWidth', 1.5, 'DisplayName', 'P1 Interpolant (even)');
% % Plot Lagrange interpolation P3
% plot(x, P3, 'b--', 'LineWidth', 1.5, 'DisplayName', 'P3 Interpolant (dense)');
% % Scatter plot of data points used for P1 and P3
% scatter(datx, f1(datx), 'ro', 'DisplayName', 'Interpolation Points (even)');
% scatter(datx1, f1(datx1), 'bo', 'DisplayName', 'Interpolation Points (dense)');
% % Customize plot
% title('Lagrange Interpolation for f1(x)');
% xlabel('x');
% ylabel('y');
% legend('Location', 'Best');
% hold off;

% % Plot for f2
% figure;
% hold on;
% % Plot actual function f2
% plot(x, f2(x), 'k-', 'LineWidth', 1.5, 'DisplayName', 'f2(x) = 1/(1+x^2)');
% % Plot Lagrange interpolation P2
% plot(x, P2, 'r--', 'LineWidth', 1.5, 'DisplayName', 'P2 Interpolant (even)');
% % Plot Lagrange interpolation P4
% plot(x, P4, 'b--', 'LineWidth', 1.5, 'DisplayName', 'P4 Interpolant (dense)');
% % Scatter plot of data points used for P2 and P4
% scatter(datx, f2(datx), 'ro', 'DisplayName', 'Interpolation Points (even)');
% scatter(datx1, f2(datx1), 'bo', 'DisplayName', 'Interpolation Points (dense)');
% % Customize plot
% title('Lagrange Interpolation for f2(x)');
% xlabel('x');
% ylabel('y');
% legend('Location', 'Best');
% hold off;

%QUESTION 1 coding exam - used the norm function to calculate
%relative error of P2 ... later uses it for chebyshev points
err_f2_P2 = (norm(f2(x) - P2) / norm(P2));

%QUESTION 2 coding exam - same as question 1 but relative error for P4
%... later uses it for chebyshev points
err_f2_P4 = (norm(f2(x) - P4)) / norm(P4)