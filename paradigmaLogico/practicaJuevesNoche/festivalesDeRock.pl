%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%Base de conocimiento%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%

% festival(NombreDelFestival, Bandas, Lugar).
% Relaciona el nombre de un festival con la lista de los nombres de bandas que tocan en él y el lugar dónde se realiza.
festival(lollapalooza, [gunsAndRoses, theStrokes, ..., littoNebbia], hipódromoSanIsidro).

% lugar(nombre, capacidad, precioBase).
% Relaciona un lugar con su capacidad y el precio base que se cobran las entradas ahí.
lugar(hipódromoSanIsidro, 85000, 3000).

% banda(nombre, nacionalidad, popularidad).
% Relaciona una banda con su nacionalidad y su popularidad.
banda(gunsAndRoses, eeuu, 69420).

% entradaVendida(NombreDelFestival, TipoDeEntrada).
% Indica la venta de una entrada de cierto tipo para el festival 
% indicado.
% Los tipos de entrada pueden ser alguno de los siguientes: 
%     - campo
%     - plateaNumerada(Fila)
%     - plateaGeneral(Zona).
entradaVendida(lollapalooza, campo).
entradaVendida(lollapalooza, plateaNumerada(1)).
entradaVendida(lollapalooza, plateaGeneral(zona2)).

% plusZona(Lugar, Zona, Recargo)
% Relacion una zona de un lugar con el recargo que le aplica al precio de las plateas generales.
plusZona(hipódromoSanIsidro, zona1, 1500).

%%%%%%%%%%%%%%%%%
%%%Ejercicio 1%%%
%%%%%%%%%%%%%%%%%

itinerante(Festival) :-
    festival(Festival, Bandas, UnLugar),
    festival(Festival, Bandas, OtroLugar),
    UnLugar \= OtroLugar.

%%%%%%%%%%%%%%%%%
%%%Ejercicio 2%%%
%%%%%%%%%%%%%%%%%

careta(personalFest).

careta(Festival) :-
    festival(Festival, _, _),
    not(entradaVendida(Festival, campo)).

%%%%%%%%%%%%%%%%%
%%%Ejercicio 3%%%
%%%%%%%%%%%%%%%%%

nacAndPop(Festival) :-
    festival(Festival, Bandas, _),
    not(careta(Festival)),
    forall(member(Banda, Bandas), esArgentaYFamosa(Banda)).

esArgentaYFamosa(Banda) :-
    banda(Banda, argentina, Popularidad),
    Popularidad > 1000.

%%%%%%%%%%%%%%%%%
%%%Ejercicio 4%%%
%%%%%%%%%%%%%%%%%

sobrevendido(Festival) :-
    festival(Festival, _, Lugar),
    lugar(Lugar, Capacidad, _),
    findall(Entrada, entradaVendida(Festival, Entrada), EntradasVendidas),
    length(EntradasVendidas, CantidadDeEntradasVendidas),
    CantidadDeEntradasVendidas > Capacidad.

%%%%%%%%%%%%%%%%%
%%%Ejercicio 5%%%
%%%%%%%%%%%%%%%%%

%! Podria haber hecho "precio(Lugar, Entrada, Precio)" y me ahorraba poner "festival(Festival, _, Lugar)" en todos lados

precio(Festival, campo, Precio) :-
    festival(Festival, _, Lugar),
    lugar(Lugar, _, Precio).

precio(Festival, plateaGeneral(Zona), Precio) :-
    festival(Festival, _, Lugar),
    lugar(Lugar, _, PrecioBase),
    plusZona(Lugar, Zona, Plus),
    Precio is PrecioBase + Plus.

precio(Festival, plateaNumerada(Fila), Precio) :-
    Fila > 10,
    festival(Festival, _, Lugar),
    lugar(Lugar, _, PrecioBase),
    Precio is PrecioBase * 3.

precio(Festival, plateaNumerada(Fila), Precio) :-
    Fila <= 10,
    festival(Festival, _, Lugar),
    lugar(Lugar, _, PrecioBase),
    Precio is PrecioBase * 6.

recaudacionTotal(Festival, TotalRecaudado) :-
    festival(Festival, _, _),
    findall(Precio, ( entradaVendida(Festival, Entrada), precio(Festival, Entrada, Precio) ), ListaDeRecaudos),
    sumlist(ListaDeRecaudos, TotalRecaudado).

%%%%%%%%%%%%%%%%%
%%%Ejercicio 6%%%
%%%%%%%%%%%%%%%%%

delMismoPalo(UnaBanda, OtraBanda) :-
    tocoCon(UnaBanda, OtraBanda).

delMismoPalo(UnaBanda, OtraBanda) :-
    tocoCon(UnaBanda, TercerBanda),
    esMasPopular(TercerBanda, OtraBanda),
    delMismoPalo(BandaTercera, OtraBanda).

tocoCon(UnaBanda, OtraBanda) :-
    festival(_, Bandas. _),
    member(UnaBanda, Bandas),
    member(OtraBanda, Bandas),
    UnaBanda \= OtraBanda.

esMasPopular(UnaBanda, OtraBanda) :-
    banda(UnaBanda, UnaPopularidad),
    banda(OtraBanda, OtraPopularidad),
    UnaPopularidad > OtraPopularidad.