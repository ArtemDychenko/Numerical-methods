function [numer_indeksu, Edges, I, B, A, b, r] = page_rank()
    numer_indeksu = 192441;
    L1 = mod(numer_indeksu, 100);
    L1 = floor(L1/10);
    L2 = mod(numer_indeksu, 1000);
    L2 = floor(L2/100);
    connection1 = mod(L1, 7) + 1;
    connection2 = mod(L2, 7) + 1;
    
    
    N = 8;
    
    
    
    Edges = sparse([1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 5, 5, 6, 6, 7, 8, connection2;
                    4, 6, 3, 4, 5, 5, 6, 7, 5, 6, 4, 6, 4, 7, 6, connection1, 8]);
    Edges = full(Edges);

    I = speye(N);
    
    B = sparse(Edges(2,:), Edges(1,:), 1, N, N);
    
    L = sum(B, 1); 
    L_inv = 1 ./ L;
    
    
    A = spdiags(L_inv', 0, N, N);
   

    d = 0.85;
    b = ((1-d)/N) * ones(N, 1);
    
    M = sparse(I - d*B*A);
    r = M\b;
end


