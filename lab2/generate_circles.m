function [circles, index_number, circle_areas, rand_counts, counts_mean] = generate_circles(a, r_max, n_max) 
    index_number = 192441; 
    L1 = mod(index_number, 10);
    var_circle = mod(index_number, 100);
    var_circle = floor(var_circle/10);
    rand_counts = zeros(1, n_max);
    counts_mean = zeros(1, n_max);

    

    if mod(L1, 2) == 0
        circles = zeros(n_max, 3);
        for i = 1:n_max
            rand_count = 1;
            X = rand() * a;
            Y = rand() * a;
            R = rand() * r_max;
            while circle_intersects(circles(1:i-1, :), X, Y, R, index_number) || is_circle_in_area(X, Y, R, a)
                rand_counts(i) = rand_counts(i) + 1;
                X = rand() * a;
                Y = rand() * a;
                R = rand() * r_max;
                rand_count = rand_count +1;
            end
            circles(i, :) = [X, Y, R];
            circle_areas = cumsum(pi * (circles(1:i, 3)).^2);
            rand_counts(i) = rand_count;
            if mod(var_circle, 2) == 0
               circle_areas = circle_areas';
            else
               
            end
        end

    else
        circles = zeros(3, n_max);
        for i = 1:n_max
            rand_count = 1;
            X = rand() * a;
            Y = rand() * a;
            R = rand() * r_max;
            while circle_intersects(circles(:, 1:i-1), X, Y, R, index_number) || is_circle_in_area(X, Y, R, a)
                X = rand() * a;
                Y = rand() * a;
                R = rand() * r_max;
                rand_count = rand_count +1;
            end
            circles(:, i) = [R; X; Y];
            circle_areas = cumsum(pi * (circles(1, 1:i)).^2);
            rand_counts(i) = rand_count;
            if mod(var_circle, 2) == 0
                
            else
                circle_areas = circle_areas';
            end
        end

    end
    counts_mean = cumsum(rand_counts) ./ (1:n_max);
end

function intersects = circle_intersects(circles, X, Y, R, index_number)
    L1 = mod(index_number, 10);
    intersects = false;
    if mod(L1, 2) == 0
        for i = 1:size(circles, 1)
            x_c = circles(i, 1);
            y_c = circles(i, 2);
            r_c = circles(i, 3);
            distance = sqrt((X - x_c)^2 + (Y - y_c)^2);
            if distance < (R + r_c)
                intersects = true;
                break;
            end
        end
    else
        for i = 1:size(circles, 2)
            x_c = circles(2, i);
            y_c = circles(3, i);
            r_c = circles(1, i);
            distance = sqrt((X - x_c)^2 + (Y - y_c)^2);
            if distance < (R + r_c)
                intersects = true;
                break;
            end
        end

    end
end


function check = is_circle_in_area(X, Y, R, a)
    check = false;
    if X + R - a > 0 || X - R < 0 || Y + R - a > 0 || Y - R < 0
        check = true;    
    end

end

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
