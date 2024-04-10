load('filtr_dielektryczny.mat');

% Metoda Jacobiego
tic;
[~,~, ~,~,~ ,err_norm_jac,~,iterations_jac,~] = solve_Jacobi_dla_filtra(A, b);
time_jac = toc;


% Motoda Gaussa-Seidla

tic;
[~,~, ~,~,~,err_norm_gau,~,iterations_gau,~] = solve_Gauss_Seidel_dla_filtra(A, b);
time_gau = toc;

% metoda bezpośrednia
tic;
[~,~,~,~,err_norm_dir,~] = solve_direct_dla_filtra(A, b);
time_dir = toc;

% % Wygenerowanie wykresu dla metody Jacobiego
% figure;
% plot(1:iterations_jac, err_norm_jac, '-o');
% xlabel('Iteracja');
% ylabel('Norma błędu residualnego');
% title('Metoda Jacobiego');
% grid on;
% 
% % Wygenerowanie wykresu dla metody Gaussa-Seidla
% figure;
% plot(1:iterations_gau, err_norm_gau, '-o');
% xlabel('Iteracja');
% ylabel('Norma błędu residualnego');
% title('Metoda Gaussa-Seidla');
% grid on;



fprintf('Norma błędu residualnego dla metody Jacobiego: %f\n', err_norm_jac);
fprintf('Norma błędu residualnego dla metody Gaussa-Seidla: %f\n', err_norm_gau);
fprintf('Norma błędu residualnego dla metody bezpośredniej: %f\n', err_norm_dir);

fprintf('Czy metoda Jacobiego zbiega się? %s\n', string(err_norm_jac < 1E-12 && iterations_jac >= 1000));
fprintf('Czy metoda Gaussa-Seidla zbiega się? %s\n', string(err_norm_gau < 1E-12 && iterations_gau >= 1000));