%Wczytujemy dane i obrócamy ich żeby 1000 numer był najpoźniejszą datą
data = flipud(Netflix);

dates = data(:,1);
close_prices = data(:, 2); 
open_prices = data(:, 3);
High = data(:,5);
Low = data(:, 6);

row_dates = table2array(dates)';
row_close_prices = table2array(close_prices)';
row_open_prices = table2array(open_prices)';
row_high = table2array(High)';
row_low = table2array(Low)';

MACD = [];
SIGNAL = [];



for i = 1:1000
   EMA_12 = ema(i, 12, row_close_prices);

   EMA_26 = ema(i, 26, row_close_prices);

   difference = EMA_12 - EMA_26;

   MACD = [MACD, difference];
end

for i = 1:length(MACD)
    %Signal

    EMA_9 = ema(i, 9, MACD);

    SIGNAL = [SIGNAL, EMA_9];
end



adxVal = calculateADX(row_high, row_low, row_close_prices, 14, 6);
% Parametr dla ADX
adxThreshold = 15.2;
figure;
plot(adxVal);

sell_points = false(size(MACD));
buy_points = false(size(MACD));

% Określenie punktów kupna/sprzedaży
% for index = 2:numel(MACD)
% buy_points(index) = ((MACD(index) > SIGNAL(index)) & MACD(index - 1) < SIGNAL(index - 1)); % Kup
% sell_points(index) = ((MACD(index) < SIGNAL(index)) & MACD(index - 1) > SIGNAL(index - 1)); % Sprzedaj
% end

inPosition = false(size(MACD));
% Określenie punktów kupna/sprzedaży(Zaproponowany algorytm)
for i = 2:numel(MACD)
    if MACD(i) > SIGNAL(i) && adxVal(i) > adxThreshold && ~inPosition(i-1)
        buy_points(i) = 1; % sygnał kupna
        inPosition(i) = true;
    elseif MACD(i) < SIGNAL(i) && inPosition(i-1)
        sell_points(i) = -1; % sygnał sprzedaży
        inPosition(i) = false;
    else
        inPosition(i) = inPosition(i-1);
    end

end


% Wykres zmiany stanu portfela inwestycyjnego
portfolio_state = zeros(size(MACD));
for i = 1:length(buy_points)
    if buy_points(i) == 1
        portfolio_state(i) = 1; % Kupno
    end
end
for i = 1:length(sell_points)
    if sell_points(i) == 1
        portfolio_state(i) = -1; % Sprzedaż
    end
end

% Wykres wartości portfela inwestycyjnego
portfolio_value = zeros(size(row_close_prices));
number_stocks = zeros(size(row_close_prices));
money = 1000; % Początkowy kapitał
stocks = 0; % Liczba posiadanych akcji
for i = 1:numel(row_close_prices)
    if portfolio_state(i) == 1 % Kupno
        stocks = stocks + ((money) / row_close_prices(i));
        money = 0;
    elseif portfolio_state(i) == -1 % Sprzedaż
        money = money + ((stocks) * row_close_prices(i));
        stocks = 0;
        
    end
    portfolio_value(i) = money + stocks * row_close_prices(i);
    number_stocks(i) = stocks;
end


plot_SIGNAL_MACD(MACD, SIGNAL, buy_points, sell_points, row_close_prices);
plot_portfolio(number_stocks, portfolio_value, buy_points, sell_points);