% Caricamento del file Excel
file_path = 'CDS_historical_UE.xlsx';
data = readtable(file_path);

% Controllo che la colonna "Date" sia in formato datetime
if ~isdatetime(data.Date)
    data.Date = datetime(data.Date, 'InputFormat', 'MM/dd/yyyy');
end

% Ordinamento dei dati in ordine crescente di data
data = sortrows(data, 'Date');

% Calcolo di statistiche per ciascun paese (senza normalizzazione)
fprintf('\nStatistiche per Paese:\n');
for i = 2:width(data)
    country = data.Properties.VariableNames{i};
    col = data{:, i};
    col = col(~isnan(col)); % Ignora eventuali valori NaN
    
    % Calcolo delle metriche
    std_dev = std(col);
    skew = skewness(col);
    kurt = kurtosis(col);
    mean_val = mean(col);
    median_val = median(col);
    max_val = max(col);
    min_val = min(col);
    
    % Stampa a schermo
    fprintf('Paese: %s\n', country);
    fprintf('  Deviazione Standard: %.2f\n', std_dev);
    fprintf('  Skewness: %.2f\n', skew);
    fprintf('  Curtosi: %.2f\n', kurt);
    fprintf('  Valore Medio: %.2f\n', mean_val);
    fprintf('  Mediana: %.2f\n', median_val);
    fprintf('  Valore Massimo: %.2f\n', max_val);
    fprintf('  Valore Minimo: %.2f\n\n', min_val);
    
    % Rolling Volatility per il paese
    windows = [20, 50, 100];
    figure;
    hold on;
    for w = windows
        rolling_volatility = movstd(col, w, 'omitnan');
        plot(data.Date(w:end), rolling_volatility(w:end), 'DisplayName', [num2str(w) ' gg']);
    end
    title(['Rolling Volatility - ', country], 'Interpreter', 'none');
    xlabel('Data');
    ylabel('Volatilità');
    legend('Location', 'best');
    grid on;
    hold off;
end

% Serie storiche raggruppate in subplot
num_countries = width(data) - 1;
num_rows = ceil(sqrt(num_countries));
num_cols = ceil(num_countries / num_rows);

figure;
for i = 2:width(data)
    country = data.Properties.VariableNames{i};
    col = data{:, i};
    
    % Crea un subplot per ogni paese
    subplot(num_rows, num_cols, i-1);
    plot(data.Date, col, 'LineWidth', 1.5);
    title(country, 'Interpreter', 'none');
    xlabel('Data');
    ylabel('Spread');
    grid on;
end
sgtitle('Serie Storiche dei Paesi');

% Boxplot per ciascun paese come subplot in un unico plot
num_countries = width(data) - 1; % Numero di paesi
num_rows = ceil(sqrt(num_countries));
num_cols = ceil(num_countries / num_rows);

figure;
for i = 2:width(data)
    country = data.Properties.VariableNames{i};
    col = data{:, i};
    
    % Creazione di un subplot per ogni paese
    subplot(num_rows, num_cols, i-1);
    boxplot(col, 'Labels', {country});
    title(country, 'Interpreter', 'none');
    xlabel('Paese');
    ylabel('Valori');
    grid on;
end
sgtitle('Boxplot dei Valori per Paese');



% Heatmap delle correlazioni tra le serie storiche
correlation_matrix = corr(data{:, 2:end}, 'Rows', 'pairwise'); % Matrice di correlazione
figure;
heatmap(data.Properties.VariableNames(2:end), ...
        data.Properties.VariableNames(2:end), ...
        correlation_matrix, ...
        'Colormap', parula, ...
        'ColorbarVisible', 'on');
title('Heatmap delle Correlazioni tra le Serie Storiche');
xlabel('Paesi');
ylabel('Paesi');
