function orientation = computeOrientation(p, q, r)
    % Calcola l'orientazione di tre punti p, q, r
    % Restituisce 0 se i punti sono collineari, >0 se in senso orario, <0 se in senso antiorario
    v1 = q - p;
    v2 = r - q;
    orientation = det2D(v1, v2);
end