% Normalizzazione per rendere tutte le serie confrontabili (0 a 1)
normalized_comparable_data = data; % Copia i dati originali
for i = 2:width(data) % Normalizzazione di ogni serie
    col = data{:, i};
    normalized_col = (col - min(col)) / (max(col) - min(col)); % Porta ciascuna serie nel range [0, 1]
    normalized_comparable_data{:, i} = normalized_col;
end

% Allineamento iniziale: tutte le serie partono dallo stesso valore (0)
for i = 2:width(normalized_comparable_data)
    initial_value = normalized_comparable_data{1, i}; % Valore iniziale della serie
    normalized_comparable_data{:, i} = normalized_comparable_data{:, i} - initial_value; % Sottrai il valore iniziale
end

% Plot del grafico comparativo normalizzato e allineato
figure;
hold on;
for i = 2:width(normalized_comparable_data)
    plot(normalized_comparable_data.Date, normalized_comparable_data{:, i}, 'DisplayName', normalized_comparable_data.Properties.VariableNames{i});
end
title('Confronto delle Serie Storiche Normalizzate e Allineate');
xlabel('Data');
ylabel('Spread Normalizzato e Allineato');
legend('Location', 'best');
grid on;
hold off;