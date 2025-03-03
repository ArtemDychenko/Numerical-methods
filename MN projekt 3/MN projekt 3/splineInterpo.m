data = [SpacerniakGdansk.Dystansm, SpacerniakGdansk.Wysokom]; % Podmień na odpowiednie kolumny z Twoimi danymi
splineInterpolation(data);

function splineInterpolation(data)
    
    num_points = 150;

    k = max(1, floor(size(data, 1) / num_points));

    %rand_indices = randperm(size(data, 1), num_points);
    %interpolation_data = data(rand_indices, :);


   interpolation_data = data(1:k:end, :);
    
    F = splineFunction(interpolation_data);
    
    distance = data(:, 1);
    height = data(:, 2);
    interpolated_height = F(distance);
    
    % Wykres
    figure;
    plot(distance, height, 'r.', 'DisplayName', 'Pełne dane');
    hold on;
    plot(distance, interpolated_height, 'b', 'DisplayName', 'Funkcja interpolująca');
    plot(interpolation_data(:, 1), interpolation_data(:, 2), 'g.', 'MarkerSize', 10, 'DisplayName', 'Dane do interpolacji');
    hold off;
    legend;
    xlabel('Odległość');
    ylabel('Wysokość');
    title(['Przybliżenie interpolacją splajnem trzeciego stopnia, ', num2str(size(interpolation_data, 1)), ' punkt(ów)']);
    grid on;
end

function F = splineFunction(points)
    xx = points(:, 1);
    yy = points(:, 2);
    splineFunc = spline(xx, yy);
    F = @(x) ppval(splineFunc, x);
end
