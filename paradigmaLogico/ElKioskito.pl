atiende(dodain, lunes, 9, 15).
atiende(dodain, miercoles, 9, 15).
atiende(dodain, viernes, 9, 15).
atiende(lucas, martes, 10, 20).
atiende(juanC, sabado, 18, 22).
atiende(juanC, domingo, 18, 22).
atiende(juanFds, jueves, 10, 20).
atiende(juanFds, viernes, 12, 20).
atiende(leoC, lunes, 14, 18).
atiende(leoC, miercoles, 14, 18).
atiende(martu, miercoles, 23, 24).

%%%%%%%%%%%%%%%%
%%%%%PUNTO1%%%%%
%%%%%%%%%%%%%%%%

atiende(vale, Dia, HoraInicio, HoraFin) :- 
    atiende(dodain, Dia, HoraInicio, HoraFin).

atiende(vale, Dia, HoraInicio, HoraFin) :- 
    atiende(juanC, Dia, HoraInicio, HoraFin).

%No se agregan por principio de universo cerrado

%%%%%%%%%%%%%%%%
%%%%%PUNTO2%%%%%
%%%%%%%%%%%%%%%%

quienAtiende(Persona, Dia, Hora) :- 
    quienAtiende(Persona, Dia, HoraInicio, HoraFin),
    between(HoraInicio, HoraFin, Hora).

%%%%%%%%%%%%%%%%
%%%%%PUNTO3%%%%%
%%%%%%%%%%%%%%%%

estaAcompaniado(Persona, Dia, Hora) :-
    quienAtiende(OtraPersona, Dia, Hora),
    Persona \= OtraPersona.

foreverAlone(Persona, Dia, Hora) :-
    quienAtiende(Persona, Dia, Hora),
    not(estaAcompaniado(Persona, Dia, Hora)).

%%%%%%%%%%%%%%%%
%%%%%PUNTO4%%%%%
%%%%%%%%%%%%%%%%

posibilidadDeAtencion(Persona, Dia, Hora) :- 
    quienAtiende(_, Dia, Hora).
    findall(Persona, quienAtiende(Persona, Dia, Hora), ListaEmpleados).

%%%%%%%%%%%%%%%%
%%%%%PUNTO5%%%%%
%%%%%%%%%%%%%%%%

ventas(dodain, fecha(10, agosto), [golosinas(1200), cigarrillos([jockey]), golosinas(50)]).
ventas(dodain, fecha(12, agosto), [bebidas(alcoholica, 8), bebidas(noAlcoholica, 1), golosinas(10)]).
ventas(martu, fecha(12, agosto), [golosinas(1000), cigarrillos([chesterfield, colorado, parisiennes])]).
ventas(lucas, fecha(11, agosto), [golosinas(600)]).
ventas(lucas, fecha(18, agosto), [bebidas(noAlcoholica, 2), cigarrillos([jockey])]).

esSuertudo(Persona) :-
    quienAtiende(Persona, _, _, _),
    forall(ventas(Persona, _, Ventas), ventaImportante(Ventas)).

ventaImportante(Ventas) :-
    nth0(0, Ventas, PrimeraVenta),
    esImportante(PrimeraVenta).

esImportante(golosinas(Monto)) :-
    Monto > 100.

esImportante(cigarrillos(Marcas)) :-
    length(Marcas, Cantidad),
    Cantidad > 2.

esImportante(bebidas(alcoholica, _)).

esImportante(bebidas(_, Cantidad)) :-
    Cantidad > 5.