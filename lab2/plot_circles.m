function plot_circles(a, circles, index_number)
    figure;
    axis equal;
    axis([0 a 0 a]);
    hold on;
    L1 = mod(index_number, 10);
    if mod(L1, 2) == 0
        for i = 1:size(circles, 1)
            plot_circle(circles(i, 3), circles(i, 1), circles(i, 2));
            pause(0.1);
        end
       
    else
        for i = 1:size(circles, 2)
            plot_circle(circles(1, i), circles(2, i), circles(3, i));
            pause(0.1);
        end
    end

end