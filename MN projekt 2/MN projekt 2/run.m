% Zadanie A


NN =[100,500,1000,2000,3000];
n = length(NN);

a1 = 9;
a2 = -1;
a3 = -1;

time_jacobi = ones(1,n);
time_gauss_seidel = ones(1,n);
time_direct_solve = ones(1,n);

for i = 1:n

    N = NN(i);

% Tworzymy macierz A
A = zeros(N);
for j = 1:N
    A(j,j) = a1;
    if j > 1
        A(j, j-1) = -1;
    end
    if j > 2
         A(j, j-2) = -1;
    end
    if j < N
        A(j, j+1) = -1; 
    end
    if j < N-1  
        A(j, j+2) = -1;
    end
end

% Tworzymy macierz B
b = zeros(N,1);
for j = 1:N
    b(j) = sin(3*j);
end

% Zadanie B
x0 = zeros(N, 1);
err = 1e-9;
max_iter = 1000;

tic;
[x_jacobi, iter_jacobi, residuals_jac] = jacobi(A, b, x0, err, max_iter);
time_jacobi(i) = toc;

tic;
[x_gauss_seidel, iter_gauss_seidel, residuals_gau] = gauss_seidel(A, b, x0, err, max_iter);
time_gauss_seidel(i) = toc;

tic;
[x, residuum_dir] = direct_solve(A, b);
time_direct_solve(i) = toc;


end


% Wykres nprmy residum w kolejnych iteracjach
figure;
semilogy(1:iter_jacobi, residuals_jac, '-o', 'DisplayName', 'Jacobi');
hold on;
semilogy(1:iter_gauss_seidel, residuals_gau, '-*', 'DisplayName', 'Gauss-Seidel');
xlabel('Liczba iteracji');
ylabel('Norma residuum');
title('Zmiana normy residuum w kolejnych iteracjach');
legend('Location', 'best');
grid on;


figure;
plot(NN, time_direct_solve, '-o', 'DisplayName', 'Faktoryzacja LU');
hold on;
plot(NN, time_jacobi, '-*', 'DisplayName', 'Metoda Jacobiego');
plot(NN, time_gauss_seidel, '-^', 'DisplayName', 'Metoda Gaussa-Seidla');
xlabel('Liczba niewiadomych (N)');
ylabel('Czas (s)');
title('Zależność czasu od liczby niewiadomych');
legend('Location', 'best');
grid on;

%Porównanie czasu trwania algorytmow
fprintf('Czas trwania metody Jacobiego: %.4f sekund\n', time_jacobi);
fprintf('Czas trwania metody Gaussa-Seidla: %.4f sekund\n', time_gauss_seidel);
fprintf('Czas trwania metody direct solve: %.4f sekund\n', time_direct_solve);
fprintf('Norma residuum: %e\n', residuum_dir);


