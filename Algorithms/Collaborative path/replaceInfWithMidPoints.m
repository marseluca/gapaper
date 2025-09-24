function updatedMatrix = replaceInfWithMidPoints(dynMatrix)
    % Determina la dimensione della matrice di input
    [numRows, ~] = size(dynMatrix);
    
    % Itera su ogni riga della matrice
    for i = 1:numRows
        % Estrai le coordinate della riga corrente
        rowCoords = dynMatrix(i, 3:end);
        
        % Inizializza un array per raccogliere i punti validi
        points = [];
        k = 1;
        
        % Raccogli le coppie di coordinate [x, y] fino a [Inf, Inf]
        while k + 1 <= length(rowCoords)
            x = rowCoords(k);
            y = rowCoords(k + 1);
            if isnumeric(x) && isnumeric(y) && ~isinf(x) && ~isinf(y)
                points = [points; x, y];
                k = k + 2;
            else
                break;
            end
        end
        
        % Inizia a inserire i punti medi
        newPoints = points;
        j = 1;
        while j < size(points, 1)
            % Estrai il punto corrente e il punto successivo
            point1 = points(j, :);
            point2 = points(j + 1, :);
            
            % Calcola il punto medio
            midPoint = (point1 + point2) / 2;
            
            % Inserisci il punto medio dopo il punto corrente
            newPoints = [newPoints(1:j, :); midPoint; newPoints(j+1:end, :)];
            
            % Incrementa l'indice di 2 per saltare il nuovo punto medio inserito
            j = j + 2;
        end
        
        % Appiattisci le coordinate nella riga
        newRowCoords = reshape(newPoints.', 1, []);
        dynMatrix(i, 3:2+length(newRowCoords)) = newRowCoords;
        
        % Imposta il resto delle colonne a [Inf, Inf] se necessario
        % if length(newRowCoords) < numCols - 2
        %     dynMatrix(i, 3+length(newRowCoords):numCols) = Inf;
        % end
    end
    
    % Ritorna la matrice aggiornata
    updatedMatrix = dynMatrix;
end
