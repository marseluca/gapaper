function adjacent = isAdjacent(tri1, tri2)
    % Verifica se due triangoli sono adiacenti (condividono un lato)
    % Genera tutte le coppie di vertici (lati) di ciascun triangolo
    edges1 = nchoosek(tri1, 2); % Lati del primo triangolo
    edges2 = nchoosek(tri2, 2); % Lati del secondo triangolo
    
    % Ordina i vertici di ogni lato per facilitare il confronto
    edges1 = sort(edges1, 2);
    edges2 = sort(edges2, 2);
    
    % Verifica se c'è almeno un lato in comune
    adjacent = any(ismember(edges1, edges2, 'rows'));
end