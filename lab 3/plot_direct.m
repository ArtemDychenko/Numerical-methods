function plot_direct(N,vtime_direct)
    % N - wektor zawierający rozmiary macierzy dla których zmierzono czas obliczeń metody bezpośredniej
    % vtime_direct - czas obliczeń metody bezpośredniej dla kolejnych wartości N
    figure;
    
    plot(N, vtime_direct)
    
    xlabel('Rozmiar macierzy');
    ylabel('Czas obliczeń');
    title('Czas rozwiązania równania macierzowego metodą bezpośrednią');
    grid on;



    print -dpng zadanie2.png 

end
