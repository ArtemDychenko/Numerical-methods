function plot_portfolio(number_stocks, portfolio_value, buy_points, sell_points)
figure;
subplot(2,1,1);
plot(number_stocks);
title('Zmiana ilości akcji');
xlabel('Okres');
ylabel('Stan');

subplot(2,1,2);
plot(portfolio_value);
hold on;
stem(find(buy_points), portfolio_value(buy_points), 'g', 'filled');
stem(find(sell_points), portfolio_value(sell_points), 'r', 'filled');
fprintf('Wartość portfolio: %s\n', num2str(portfolio_value(1000 - 2)) )
title('Wartość portfela inwestycyjnego');
xlabel('Okres');
ylabel('Wartość');
legend('Wartość portfela', 'Punkt kupna', 'Punkt sprzedaży');