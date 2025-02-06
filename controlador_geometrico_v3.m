function [velocidad, rho] = controlador_geometrico_v3(pose, punto, punto_final, direccion)

    delta = (pose(1) - punto(1)) * sin(pose(3)) - (pose(2) - punto(2)) * cos(pose(3));

    Lh = sqrt((pose(1) - punto(1))^2 + (pose(2) - punto(2))^2);

    distancia = sqrt((punto_final(1) - pose(1))^2 + (punto_final(2) - pose(2))^2);

    rho = 2*delta/Lh^2;
    
    kpv = 1*direccion;

    velocidad= kpv * distancia;

    if velocidad > 30
        velocidad = 30;
    end

    if velocidad < -30
        velocidad = -30;
    end

end