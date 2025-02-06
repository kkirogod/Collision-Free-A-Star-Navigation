
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Simulación del movimiento de un robot móvil diferencial
% implementando el método de la persecución pura.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% clear all
% clc

j=1;

global l
global radio_rueda
global camino
global pose
global punto


l=3.5; %distancia entre rudas delanteras y traseras, tambien definido en modelo
radio_rueda=1;

%-------------------------------------------
% Carga y representación del mapa
%

MAPA = imread('cuadro6.bmp');

%Transformación para colocar correctamente el origen del Sistema de
%Referencia
MAPA(1:end,:,:)=MAPA(end:-1:1,:,:);
%image(MAPA);
%axis xy
%---------------------------------------------------
% A_Star
delta = 10;
pose_ini = [pose0(1), pose0(2)];
pose_dest = [posef(1), posef(2)];
Optimal_path = A_estrella_modificado_2(MAPA,delta,pose_ini,pose_dest)';

% Definicion de la spline

% Distancias de despegue y aterrizaje
dd = direccion;
da = dd;

posicion_despegue = [pose0(1)+(dd*cos(pose0(3)))  pose0(2)+(dd*sin(pose0(3)))];
posicion_aterriza = [posef(1)-(da*cos(posef(3)))  posef(2)-(da*sin(posef(3)))];

% Definicion del poligono
xc = [pose0(1) posicion_despegue(1) Optimal_path(1, :) posicion_aterriza(1) posef(1)];
yc = [pose0(2) posicion_despegue(2) Optimal_path(2, :) posicion_aterriza(2) posef(2)];

ds = 0.1; % Distancia entre puntos en el camino
camino = funcion_spline_cubica_varios_puntos(xc, yc, ds)';

% camino=load('camino.dat');

t0=0;

%final de la simulación
tf=60;

%paso de integracion
h=0.1;
%vector tiempo
t=0:h:tf;
%indice de la matriz
k=0;

%inicialización valores iniciales
pose(:,k+1)=pose0;

t(k+1)=t0;

velocidad=20;

look_ahead = 30; % variar si la trayectoria del robot hace oscilaciones

while ((t0+h*k)< tf)
    
    %actualización
    k=k+1;
    
    punto = pure_pursuit(camino, pose(:,k), look_ahead);

    % [~, rho] = controlador_geometrico(pose(:,k), punto);
    [velocidad, rho] = controlador_geometrico_v3(pose(:,k), punto, camino(end,:), direccion);

    [velocidad_izquierda, velocidad_derecha] = modelo_cinematico_inv(velocidad, rho);
    conduccion = [velocidad_derecha velocidad_izquierda]; 
    
    pose(:,k+1)=kuta_diferencial_mapa(t(k),pose(:,k),h,conduccion,MAPA);


    if (velocidad < 0.05) && (direccion == 1)
        break
    end

    if (velocidad > -0.05) && (direccion == -1)
        break
    end

end


grid on