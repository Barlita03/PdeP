%%%%%%%%%%%%%
%%%Punto 1%%%
%%%%%%%%%%%%%

%destino(Persona, Lugar)
destino(dodain, pehuenia).
destino(dodain, sanMartin).
destino(dodain, esquel).
destino(dodain, sarmiento).
destino(dodain, camarones).
destino(dodain, playasDoradas).

destino(alf, bariloche).
destino(alf, sanMartin).
destino(alf, elBolson).

destino(nico, marDelPlata).

destino(vale, calafate).
destino(vale, elBolson).

destino(martu, Destino) :-
    destino(alf, Destino).

destino(martu, Destino) :-
    destino(nico, Destino).

%!Juan y Carlos no se agregan por principio de universo cerrado

%%%%%%%%%%%%%
%%%Punto 2%%%
%%%%%%%%%%%%%

%atraccion(Lugar, parqueNacional(Nombre))
%atraccion(Lugar, cerro(Nombre, Altura))
%atraccion(Lugar, cuerpoDeAgua(Nombre, SePuedePescar, temperaturaPromedio))
%atraccion(Lugar, playa(diferenciaPromedio))
%atraccion(Lugar, excursion(Nombre))

atraccion(esquel, parqueNacional(losAlerces)).
atraccion(esquel, excursion(trochita)).
atraccion(esquel, excursion(travelin)).

atraccion(villaPehuenia, cerro(bateaMahuida, 2000)).
atraccion(villaPehuenia, cuerpoDeAgua(moquehue, true, 14)).
atraccion(villaPehuenia, cuerpoDeAgua(alumine, true, 19)).

%esCopada(Atraccion)
esCopada(cerro(_, Altura)) :-
    Altura > 2000.

esCopada(cuerpoDeAgua(_, true, _)).

esCopada(cuerpoDeAgua(_, _, Temperatura)) :-
    Temperatura > 20.

esCopada(playa(Diferencia)) :-
    Diferencia < 5.

esCopada(excursion(Nombre)) :-
    atom_length(Nombre, CantidadDeLetras),
    CantidadDeLetras > 7.

esCopada(parqueNacional(_)).

%vacacionesCopadas(Persona)
vacacionesCopadas(Persona) :-
    destino(Persona, _),
    forall(destino(Persona, Destino), tieneAtraccionCopada(Destino)).

%tieneAtraccionCopada(Destino)
tieneAtraccionCopada(Destino) :-
    atraccion(Destino, Atraccion),
    esCopada(Atraccion).

%%%%%%%%%%%%%
%%%Punto 3%%%
%%%%%%%%%%%%%

seCruzaron(UnaPersona, OtraPersona) :-
    destino(UnaPersona, Destino),
    destino(OtraPersona, Destino).

noSeCruzaron(UnaPersona, OtraPersona) :-
    distinct(UnaPersona, destino(UnaPersona, _)),
    distinct(OtraPersona, destino(OtraPersona, _)),
    not(seCruzaron(UnaPersona, OtraPersona)).

%%%%%%%%%%%%%
%%%Punto 4%%%
%%%%%%%%%%%%%

%costoDeVida(Lugar, Costo)
costoDeVida(sarmiento, 100).
costoDeVida(esquel, 150).
costoDeVida(pehuenia, 180).
costoDeVida(sanMartin, 150).
costoDeVida(camarones, 135).
costoDeVida(playasDoradas, 170).
costoDeVida(bariloche, 140).
costoDeVida(elCalafate, 240).
costoDeVida(elBolson, 145).
costoDeVida(marDelPlata, 140).

%esGasolero(Lugar)
esGasolero(Lugar) :-
    costoDeVida(Lugar, Costo),
    Costo < 160.

vacacionesGasoleras(Persona) :-
    distinct(Persona, destino(Persona, _)),
    forall(destino(Persona, Lugar), esGasolero(Lugar)).

%%%%%%%%%%%%%
%%%Punto 5%%%
%%%%%%%%%%%%%

itinerariosPosibles(Persona, Itinerario) :-
    destino(Persona, _),
    findall(Destino, destino(Persona, Destino), Destinos),
    reordenar(Destinos, Itinerario).

reordenar(Lista, Lista).

reordenar([ Cabeza | Cola ], Lista) :-
    append(Cola, [Cabeza], OtraLista),
    reordenar(OtraLista, Lista).