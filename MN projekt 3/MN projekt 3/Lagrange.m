
data =[SpacerniakGdansk.Dystansm, SpacerniakGdansk.Wysokom]; % Podmień 'distance_column' i 'height_column' na odpowiednie kolumny z Twoimi danymi
lagrangeInterpolation(data);



function lagrangeInterpolation(data)
    
    num_points = 222;

    k = max(1, floor(size(data, 1) / num_points))

    
     %rand_indices = randperm(size(data, 1), num_points);
     %interpolation_data = data(rand_indices, :);

    interpolation_data = data(1:k:end, :)

    
    F = interpolationFunction(interpolation_data);
    
    distance = data(:, 1);
    height = data(:, 2);
    interpolated_height = arrayfun(F, distance);
    
    figure;
    semilogy(distance, height, 'r.', 'DisplayName', 'Pełne dane');
    hold on;
    semilogy(distance, interpolated_height, 'b', 'DisplayName', 'Funkcja interpolująca');
    semilogy(interpolation_data(:, 1), interpolation_data(:, 2), 'g.', 'DisplayName', 'Dane do interpolacji');
    hold off;
    legend;
    xlabel('Odległość');
    ylabel('Wysokość');
    title(['Przybliżenie interpolacją Lagrange''a, ', num2str(size(interpolation_data, 1)), ' punkt(ów)']);
    grid on;
end

function F = interpolationFunction(points)
    F = @(x) arrayfun(@(x) lagrangeInterpolation1(x, points), x);
end

function result = lagrangeInterpolation1(x, points)
    n = size(points, 1);
    result = 0;
    for i = 1:n
        xi = points(i, 1);
        yi = points(i, 2);
        base = 1;
        for j = 1:n
            if i ~= j
                xj = points(j, 1);
                base = base .* ((x - xj) ./ (xi - xj));
            end
        end
        result = result + yi .* base;
    end
end


