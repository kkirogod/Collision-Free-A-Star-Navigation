function [velocidad_izquierda, velocidad_derecha] = modelo_cinematico_inv(velocidad, rho)

    global l
    global radio_rueda

    velocidad_derecha = velocidad*(1+l*rho)/radio_rueda;
    velocidad_izquierda = velocidad*(1-l*rho)/radio_rueda;

end