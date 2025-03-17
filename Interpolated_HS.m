% Lettura del file Excel "CDSSPREADS"
data = readtable('CDSSPREADS.xlsx');

% Interpolazione dei valori mancanti per ogni serie
interpolated_data = data;
for i = 2:width(data)
    interpolated_data{:, i} = fillmissing(data{:, i}, 'linear'); % Interpolazione lineare dei NaN
end

% Creazione di un plot per ogni serie storica
for i = 2:width(interpolated_data)
    figure; % Nuova figura per ciascuna serie
    plot(interpolated_data.Date, interpolated_data{:, i}, 'DisplayName', interpolated_data.Properties.VariableNames{i});
    title(['Serie Storica: ', interpolated_data.Properties.VariableNames{i}]);
    xlabel('Data');
    ylabel('Valore');
    grid on;
    legend('Location', 'best');
end
