function [x, residuals] = direct_solve(A, b)

[L, U] = my_lu(A);

y = L \ b;
    
x = U \ y;
   
residuals = norm(A * x - b);
end

function [L, U] = my_lu(A)
    [m, n] = size(A);
    if m ~= n
        error('Macierz A musi być kwadratowa');
    end

    L = eye(n); 
    U = zeros(n); 

    for k = 1:n
        for j = k:n
            U(k, j) = A(k, j) - L(k, 1:k-1) * U(1:k-1, j);
        end
        for i = k+1:n
            L(i, k) = (A(i, k) - L(i, 1:k-1) * U(1:k-1, k)) / U(k, k);
        end
    end
end