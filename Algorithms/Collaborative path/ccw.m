function isCCW = ccw(A, B, C)
    % Verifica se i punti A, B e C sono in ordine antiorario
    isCCW = (C(2) - A(2)) * (B(1) - A(1)) > (B(2) - A(2)) * (C(1) - A(1));
end