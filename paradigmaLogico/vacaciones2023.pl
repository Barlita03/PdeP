%%%%%%%%%%%%%%%%%
%%%%%PUNTO 1%%%%%
%%%%%%%%%%%%%%%%%

%viaja(persona, lugares).
viaja(dodain, [pehuenia, sanMartin, esquel, sarmiento, camarones, playasDoradas]).
viaja(alf, [bariloche, sanMartin, elBolson]).
viaja(vale, [calafate, elBolson]).
viaja(nico, [marDelPlata]).
viaja(barla, [pehuenia, esquel]).

viaja(martu, Lugares) :-
    viajes(nico, ViajesNico),
    viajes(alf, ViajesAlf),
    append(ViajesNico, ViajesAlf, Lugares).

%viajes(persona, viajes).
viajes(Persona, Viajes) :-
    viaja(Persona, Viajes).

%Juan y Carlos no se agragan por el principio de universo cerrado

lugar(Lugar) :-
    viaja(_, Lugares),
    member(Lugar, Lugares).

persona(Persona) :-
    viaja(Persona, _).

%%%%%%%%%%%%%%%%%
%%%%%PUNTO 2%%%%%
%%%%%%%%%%%%%%%%%

%parqueNacional(nombre).
%cerro(nombre, altura).
%cuerpoDeAgua(nombre, sePuedePescar, temperaturaPromedio).
%playa(nombre, diferenciaMareas).
%excursion(nombre).

%atracciones(lugar, atracciones).
atracciones(esquel, [parqueNacional(losAlerces), excursion(trochita), excursion(travelin)]).
atracciones(pehuenia, [cerro(bateaMahuida, 2001), cuerpoDeAgua(moquehue, sePuedePescar, 14), cuerpoDeAgua(alumine, noSePuedePescar, 21)]).

%esCopada(atraccion).
esCopada(cerro(_, Altura)) :-
    Altura > 2000.

esCopada(cuerpoDeAgua(_, _, Temperatura)) :-
    Temperatura > 20.

esCopada(cuerpoDeAgua(_, sePuedePescar, _)).

esCopada(playa(_, Diferencia)) :-
    Diferencia < 5.

esCopada(excursion(Nombre)) :-
    atom_length(Nombre, Longitud),
    Longitud > 7.

esCopada(parqueNacional(_)).

%atraccion(Lugar, Atraccion).
atraccion(Lugar, Atraccion) :-
    atracciones(Lugar, Atracciones),
    member(Atraccion, Atracciones).

%tieneAtraccionCopada(lugar).
tieneAtraccionCopada(Lugar) :-
    lugar(Lugar),
    atraccion(Lugar, Atraccion),
    esCopada(Atraccion).

%lugarVisitado(persona, lugar).
lugarVisitado(Persona, Lugar) :-
    viaja(Persona, Lugares),
    member(Lugar, Lugares).

%vacacionesCopadas(persona).
vacacionesCopadas(Persona) :-
    persona(Persona),
    forall(lugarVisitado(Persona, Lugar), tieneAtraccionCopada(Lugar)).

%%%%%%%%%%%%%%%%%
%%%%%PUNTO 3%%%%%
%%%%%%%%%%%%%%%%%

seCruzaron(PersonaUno, PersonaDos) :-
    lugarVisitado(PersonaUno, Lugar),
    lugarVisitado(PersonaDos, Lugar).

noSeCruzaron(PersonaUno, PersonaDos) :-
    persona(PersonaUno),
    persona(PersonaDos),
    not(seCruzaron(PersonaUno, PersonaDos)).

%%%%%%%%%%%%%%%%%
%%%%%PUNTO 4%%%%%
%%%%%%%%%%%%%%%%%

%costoDeVida(Lugar, Costo).
costoDeVida(esquel, 150).
costoDeVida(elBolson, 145).
costoDeVida(pehuenia, 180).
costoDeVida(calafate, 240).
costoDeVida(sarmiento, 100).
costoDeVida(camarones, 135).
costoDeVida(bariloche, 140).
costoDeVida(sanMartin, 150).
costoDeVida(marDelPlata, 140).
costoDeVida(playasDoradas, 170).

%esGasolero(destino).
esGasolero(Destino) :-
    lugar(Destino),
    costoDeVida(Destino, Costo),
    Costo < 160.

%vacacionesGasoleras(persona).
vacacionesGasoleras(Persona) :-
    persona(Persona),
    forall(lugarVisitado(Persona, Lugar), esGasolero(Lugar)).

%%%%%%%%%%%%%%%%%
%%%%%PUNTO 5%%%%%
%%%%%%%%%%%%%%%%%

itinerario(Persona, Itinerario) :-
    persona(Persona),
    viaja(Persona, Lugares),
    reordenar(Lugares, Itinerario).

reordenar(Itinerario, Itinerario).

reordenar([Cabeza|Cola], Itinerario) :-
    append(Cola, [Cabeza], Lugares),
    reordenar(Lugares, Itinerario).

%Se hace infinitamente pero funciona