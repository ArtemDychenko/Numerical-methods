function plot_SIGNAL_MACD(MACD, SIGNAL, buy_points, sell_points, row_close_prices)
figure;

subplot(2,1,1);
plot(row_close_prices);
title('Notowania analizowanego instrumentu finansowego');
xlabel('Numer notowania');
ylabel('Cena');
legend('close prices');


subplot(2,1,2);
plot(MACD, 'b', 'LineWidth', 1);
hold on;
plot(SIGNAL, 'r', 'LineWidth',1);



stem(find(buy_points), MACD(buy_points), 'Color', [0, 0.75, 0], 'Marker', 's', 'MarkerFaceColor', 'none', 'LineStyle', 'none', 'LineWidth', 1.25, 'MarkerSize', 8);
stem(find(sell_points), MACD(sell_points),'r', 'Marker', 's', 'MarkerFaceColor', 'none', 'LineStyle', 'none', 'LineWidth', 1.25, 'MarkerSize', 8);

legend('MACD', 'SIGNAL', 'Kup', 'Sprzedaj');
title('Wykres MACD i SIGNAL z punktami kupna/sprzedaży');
xlabel('Numer obserwacji');
ylabel('Wartość');

end