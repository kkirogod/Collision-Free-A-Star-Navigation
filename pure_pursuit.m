function punto = pure_pursuit(camino, pose, look_ahead)

    indexPunto = minima_distancia(camino, pose);
    indexPunto = indexPunto + look_ahead;

    if indexPunto > size(camino,1)
        indexPunto = size(camino,1);
    end
    
    punto = camino(indexPunto, :);

end

