%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%Base de conocimiento%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%

herramientasRequeridas(ordenarCuarto, [aspiradora(100), trapeador, plumero]).
herramientasRequeridas(ordenarCuarto, [escoba, trapeador, plumero]).
herramientasRequeridas(limpiarTecho, [escoba, pala]).
herramientasRequeridas(cortarPasto, [bordedadora]).
herramientasRequeridas(limpiarBanio, [sopapa, trapeador]).
herramientasRequeridas(encerarPisos, [lustradpesora, cera, aspiradora(300)]).

%%%%%%%%%%%%%%%%%
%%%Ejercicio 1%%%
%%%%%%%%%%%%%%%%%

%tiene(Empleado, Herramienta)
tiene(egon, aspiradora(200)).
tiene(egon, trapeador).
tiene(peter, trapeador).
tiene(winston, varitaDeNeutrones).

%%%%%%%%%%%%%%%%%
%%%Ejercicio 2%%%
%%%%%%%%%%%%%%%%%

satisfaceHerramienta(Empleado, Herramienta) :-
    tiene(Empleado, Herramienta).

satisfaceHerramienta(Empleado, aspiradora(PotenciaRequerida)) :-
    tiene(Empleado, aspiradora(Potencia)),
    between(0, Potencia, PotenciaRequerida).

%%%%%%%%%%%%%%%%%
%%%Ejercicio 3%%%
%%%%%%%%%%%%%%%%%

puedeRealizarTarea(Empleado, _) :-
    tiene(Empleado, varitaDeNeutrones).

puedeRealizarTarea(Empleado, Tarea) :-
    tiene(Empleado, _),
    herramientasRequeridas(Tarea, Herramientas),
    forall(member(Herramienta, Herramientas), satisfaceHerramienta(Empleado, Herramienta)).

%%%%%%%%%%%%%%%%%
%%%Ejercicio 4%%%
%%%%%%%%%%%%%%%%%

%tareaPedida(Cliente, Tarea, MetrosCuadrados)
tareaPedida(fede, ordenarCuarto, 3).

%precio(Tarea, PrecioPorMetroCuadrado)
precio(ordenarCuarto, 10).

precioTarea(Tarea, MetrosCuadrados, PrecioFinal) :-
    precio(Tarea, PrecioPorMetroCuadrado),
    PrecioFinal is PrecioPorMetroCuadrado * MetrosCuadrados.

costoACobrar(Cliente, PrecioFinal) :-
    tareaPedida(Cliente, _, _),
    findall(Precio, (tareaPedida(Cliente, Tarea, MetrosCuadrados), precioTarea(Tarea, MetrosCuadrados, Precio)), ListaDePrecios),
    sumlist(ListaDePrecios, PrecioFinal).

pedido(Cliente, TareasPedidas) :-
    tareaPedida(Cliente, _, _),
    findall(Tarea, tareaPedida(Cliente, Tarea, _), TareasPedidas).

%%%%%%%%%%%%%%%%%
%%%Ejercicio 5%%%
%%%%%%%%%%%%%%%%%

aceptaPedido(Empleado, Cliente) :-
    pedido(Cliente, TareasPedidas),
    puedeRealizarTodasLasTareas(Empleado, TareasPedidas),
    estaDispuestoAAceptarlo(Empleado, Cliente).

puedeRealizarTodasLasTareas(Empleado, TareasPedidas) :-
    forall(member(Tarea, TareasPedidas), puedeRealizarTarea(Empleado, Tarea)).

estaDispuestoAAceptarlo(peter, _).

estaDispuestoAAceptarlo(ray, Cliente) :-
    not(tareaPedida(Cliente, limpiarTecho)).

estaDispuestoAAceptarlo(winston, Cliente) :-
    costoACobrar(Cliente, Precio),
    Precio > 500.

estaDispuestoAAceptarlo(egon, Cliente) :-
    not(tareaPedida(Cliente, Tarea, _), esCompleja(Tarea)).

esCompleja(limpiarTecho).

esCompleja(Tarea) :-
    herramientasRequeridas(Tarea, HerramientasRequeridas),
    length(HerramientasRequeridas, Cantidad),
    Cantidad > 2.

%%%%%%%%%%%%%%%%%
%%%Ejercicio 6%%%
%%%%%%%%%%%%%%%%%

