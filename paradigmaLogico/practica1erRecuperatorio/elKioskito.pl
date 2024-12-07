%%%%%%%%%%%%%
%%%Punto 1%%%
%%%%%%%%%%%%%

%turno(Empleado, Dia, HoraDeInicio, HoraDeSalida)
turno(dodain, lunes, 9, 15).
turno(dodain, miercoles, 9, 15).
turno(dodain, viernes, 9, 15).

turno(lucas, martes, 10, 20).

turno(juanC, sabados, 18, 22).
turno(juanC, domingos, 18, 22).

turno(juanFds, jueves, 10, 20).
turno(juanFds, viernes, 12, 20).

turno(leoC, lunes, 14, 18).
turno(leoC, miercoles, 14, 18).

turno(martu, miercoles, 23, 24).

turno(vale, Dia, HoraDeInicio, HoraDeSalida) :-
    turno(dodain, Dia, HoraDeInicio, HoraDeSalida).

turno(vale, Dia, HoraDeInicio, HoraDeSalida) :-
    turno(juanC, Dia, HoraDeInicio, HoraDeSalida).

%Las cosas que no se agregan es por el principio de universo cerrado

%%%%%%%%%%%%%
%%%Punto 2%%%
%%%%%%%%%%%%%

quienAtiende(Empleado, Dia, Hora) :-
    turno(Empleado, Dia, HoraDeInicio, HoraDeSalida),
    between(HoraDeInicio, HoraDeSalida, Hora).

%%%%%%%%%%%%%
%%%Punto 3%%%
%%%%%%%%%%%%%

foreverAlone(Empleado, Dia, Hora) :-
    quienAtiende(Empleado, Dia, Hora),
    not(estaAcompaniado(Empleado, Dia, Hora)).

estaAcompaniado(Empleado, Dia, Hora) :-
    quienAtiende(OtroEmpleado, Dia, Hora),
    Empleado \= OtroEmpleado.

%%%%%%%%%%%%%
%%%Punto 4%%%
%%%%%%%%%%%%%

%! distinct sirve para que una respuesta aparezca una unica vez

posibilidadesDeAtencion(Dia, PosiblesEmpleados) :-
    findall(Empleado, distinct(Empleado, quienAtiende(Empleado, Dia, _)), Posibilidades),
    combinar(Posibilidades, PosiblesEmpleados).

combinar([], []).

combinar( [ UnEmpleado | OtrosEmpleados ], [ UnEmpleado | OtrasPosibilidades ] ) :-
    combinar(OtrosEmpleados, OtrasPosibilidades).

combinar( [ _ | OtrosEmpleados ], OtrasPosibilidades ) :-
    combinar(OtrosEmpleados, OtrasPosibilidades).

%%%%%%%%%%%%%
%%%Punto 5%%%
%%%%%%%%%%%%%

%venta(Empleado, fecha(Dia, Mes), Producto)
venta(dodain, fecha(10, 8), [ golosinas(1200), golosinas(50), cigarrillos(jockey) ]).

venta(dodain, fecha(12, 8), [ bebidas(alcoholica, 8), bebidas(noAlcoholica, 1), golosinas(10) ]).

venta(martu, fecha(12, 8), [ golosinas(1000), cigarrillos([ chesterfield, parisiennes, colorado ]) ]).

venta(lucas, fecha(11, 8), [ golosinas(600), bebidas(noAlcoholica, 2), cigarrillos(derby) ]).

ventaImportante(venta(_, _, golosinas(Valor))) :-
    Valor >= 100.

ventaImportante(venta(_, _, cigarrillos(Marcas))) :-
    length(Marcas, Cuantas),
    Cuantas >= 2.

ventaImportante(venta(_, _, bebidas(alcoholica, _))).

ventaImportante(venta(_, _, bebidas(noAlcoholica, Cantidad))) :-
    Cantidad >= 5.

suertudo(Empleado) :-
    turno(Empleado, _, _, _),
    forall(venta(Empleado, _, Ventas), laPrimeraEsImportante(Ventas)).

laPrimeraEsImportante( [ PrimeraVenta | _ ] ) :-
    ventaImportante(PrimeraVenta).