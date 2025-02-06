clc, close all, clear all

%% Desplazamiento 1

pose0 = [15; 12; 0];
posef = [216; 250; pi/2];

direccion = 1;

simulacion_A_estrella_modificado

%% Desplazamiento 2

pose0 = pose(:,end);
posef = [237; 225; pi];

pose = [];

direccion = -1; %

simulacion_A_estrella_modificado

%% Desplazamiento 3

pose0 = pose(:,end);
posef = [237; 77; 5*pi/4];

pose = [];

direccion = 1;

simulacion_A_estrella_modificado

%% Desplazamiento 4

pose0 = pose(:,end);
posef = [56; 25; -pi/4];

pose = [];

direccion = 1;

simulacion_A_estrella_modificado

%% Desplazamiento 5

pose0 = pose(:,end);
posef = [15; 12; 0];

pose = [];

direccion = -1; %

simulacion_A_estrella_modificado