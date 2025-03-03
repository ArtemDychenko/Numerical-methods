% N = 100;
% [A,b,x,time_direct,err_norm,index_number] = solve_direct(N);


N = 1000:1000:8000;
n = length(N);
vtime_direct = ones(1,n); 

for i = 1:length(N)
     [~, ~, ~, time_direct, ~, ~] = solve_direct(N(i));
     vtime_direct(i) = time_direct;
end

plot_direct(N,vtime_direct);

% N = 100;
% [A,b,M,bm,x,err_norm,time,iterations,index_number] = solve_Jacobi(N);

% N = 100;
% [A,b,M,bm,x,err_norm,time,iterations,index_number] = solve_Gauss_Seidel(N);

% N = 1000:1000:8000;
% n = length(N);
% time_Jacobi = ones(1,n);
% time_Gauss_Seidel = 2*ones(1,n);
% iterations_Jacobi = 40*ones(1,n);
% iterations_Gauss_Seidel = 40*ones(1,n);
% 
% for i = 1:length(N)
%      [~, ~, ~,~,~,~, timeJ, iterationsJ, ~] = solve_Jacobi(N(i));
%      [~, ~, ~, ~,~,~, timeG, iterationsG, ~] = solve_Gauss_Seidel(N(i));
%      time_Jacobi(i) = timeJ;
%      time_Gauss_Seidel(i) = timeG;
%      iterations_Jacobi(i) = iterationsJ;
%      iterations_Gauss_Seidel(i) = iterationsG;
% end
% 
% 
% plot_problem_5(N,time_Jacobi,time_Gauss_Seidel,iterations_Jacobi,iterations_Gauss_Seidel);

