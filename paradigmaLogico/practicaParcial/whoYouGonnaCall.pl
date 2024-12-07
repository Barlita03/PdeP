herramientasRequeridas(ordenarCuarto, [aspiradora(100), trapeador, plumero]).
herramientasRequeridas(limpiarTecho, [escoba, pala]).
herramientasRequeridas(cortarPasto, [bordedadora]).
herramientasRequeridas(limpiarBanio, [sopapa, trapeador]).
herramientasRequeridas(encerarPisos, [lustradpesora, cera, aspiradora(300)]).

%tareaPedida(tarea, cliente, metrosCuadrados).
tareaPedida(ordenarCuarto, dana, 20).
tareaPedida(cortarPasto, walter, 50).
tareaPedida(limpiarTecho, walter, 70).
tareaPedida(limpiarBanio, louis, 15).

%precio(tarea, precioPorMetroCuadrado).
precio(ordenarCuarto, 13).
precio(limpiarTecho, 20).
precio(limpiarBanio, 55).
precio(cortarPasto, 10).
precio(encerarPisos, 7).

%%%%%%%%%%%%%%%%%%
%%%%%%PUNTO1%%%%%%
%%%%%%%%%%%%%%%%%%

herramientas(egon, aspiradora(200)).
herramientas(egon, trapeador).
herramientas(peter, trapeador).
herramientas(winston, varitaDeNeutrones).

empleado(Persona) :-
    herramientas(Persona, _).

%%%%%%%%%%%%%%%%%%
%%%%%%PUNTO2%%%%%%
%%%%%%%%%%%%%%%%%%

tieneLaHerramienta(aspiradora(PotenciaMinima), Persona) :-
    empleado(Persona),
    herramientas(Persona, aspiradora(Potencia)),
    Potencia >= PotenciaMinima.

tieneLaHerramienta(Herramienta, Persona) :-
    empleado(Persona),
    herramientas(Persona, Herramienta).

%%%%%%%%%%%%%%%%%%
%%%%%%PUNTO3%%%%%%
%%%%%%%%%%%%%%%%%%

puedeRealizarTarea(Tarea, Persona) :- 
    empleado(Persona),
    herramientasRequeridas(Tarea, _),
    herramientas(Persona, varitaDeNeutrones).

puedeRealizarTarea(Tarea, Persona) :-
    empleado(Persona),
    herramientasRequeridas(Tarea, Herramientas),
    forall(herramientaRequerida(Herramientas, Herramienta), tieneLaHerramienta(Herramienta, Persona)).

herramientaRequerida(ListaDeHerramientas, Herramienta) :-
    member(Herramienta, ListaDeHerramientas).

%%%%%%%%%%%%%%%%%%
%%%%%%PUNTO4%%%%%%
%%%%%%%%%%%%%%%%%%

%tareaPedida(Cliente, Tarea, MetrosCuadrados).
%precio(Tarea, PrecioPorMetroCuadrado).

costoTrabajo(Cliente, Precio) :- 
    tareaPedida(Cliente, _, _),
    findall(Precios, precioTarea(Cliente, Precios), PreciosPorTarea),
    sumList(PreciosPorTarea, Precio).

precioTarea(Cliente, Precio) :-
    tareaPedida(Cliente, Tarea, MetrosCuadrados),
    precio(Tarea, PrecioPorMetroCuadrado),
    Precio is PrecioPorMetroCuadrado * MetrosCuadrados.

%%%%%%%%%%%%%%%%%%
%%%%%%PUNTO5%%%%%%
%%%%%%%%%%%%%%%%%%
%REPETI MUCHA LOGICA

puedeRealizarTodasLasTareas(Persona, Cliente) :-
    forall(tareaPedida(Cliente, Tarea, _), puedeRealizarTarea(Tarea, Persona)).

tareaCompleja(limpiarTecho).

tareaCompleja(Tarea) :-
    herramientasRequeridas(Tarea, Herramientas),
    length(Herramientas, Cantidad),
    Cantidad =< 2.

pedidoSimple(Cliente) :-
    forall(tareaPedida(Cliente, Tarea, _), not(tareaCompleja(Tarea))).

herramientaRequerida(ListaDeHerramientas, Herramienta) :-
    member(Herramienta, ListaDeHerramientas).

aceptaElPedido(ray, Cliente) :-
    tareaPedida(Cliente, _, _),
    not(tareaPedida(Cliente, limpiarTecho, _)),
    puedeRealizarTodasLasTareas(ray, Cliente).

aceptaElPedido(winston, Cliente) :-
    tareaPedida(Cliente, _, _),
    puedeRealizarTodasLasTareas(winston, Cliente).
    costoTrabajo(Cliente, Costo),
    Costo > 500.

aceptaElPedido(egon, Cliente) :-
    tareaPedida(Cliente, _, _),
    puedeRealizarTodasLasTareas(winston, Cliente).
    pedidoSimple(Cliente).

aceptaElPedido(Persona, Cliente) :-
    empleado(Persona),
    tareaPedida(Cliente, _, _),
    puedeRealizarTodasLasTareas(Persona, Cliente).


%%%%%%%%%%%%%%%%%%
%%%%%%PUNTO6%%%%%%
%%%%%%%%%%%%%%%%%%

%a)
herramientasRequeridas(ordenarCuarto, [escoba, trapeador, plumero]).

%b) No es necesario modificar mas nada

%c) 