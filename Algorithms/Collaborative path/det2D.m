function det = det2D(v1, v2)
    % Calcola il determinante di una matrice 2x2 data da due vettori 2D
    % v1 e v2 sono vettori 2x1 [x; y]
    det = v1(1) * v2(2) - v1(2) * v2(1);
end