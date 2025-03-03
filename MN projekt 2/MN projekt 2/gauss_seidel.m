function [x, iter, residuals] = gauss_seidel(A, b, x0, err, max_iter)
    n = length(b);
    x = x0;
    iter = 0;
    residuals = zeros(max_iter, 1);

    L = tril(A, -1);
    U = triu(A, 1);
    D = diag(diag(A));
    
    M = -inv(D+L)*(U);
    bm = inv(D+L)*b;


    while norm(A*x - b)  > err && iter < max_iter
        x_old = x;
        x = M * x_old + bm;
        iter = iter + 1;
        residuals(iter) = norm(A*x - b);
    end
    residuals = residuals(1:iter)
end