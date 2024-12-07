%%%%%%%%%%%%%%%%
%%%%%PUNTO1%%%%%
%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%
%%%%%COMIDA%%%%%
%%%%%%%%%%%%%%%%

comida(hamburguesa, 2000).
comida(panchitoConPapas, 1500).
comida(lomito, 2500).
comida(caramelos, 0).

comida(Comida) :-
    comida(Comida, _).

%%%%%%%%%%%%%%%%%%%%%
%%%%%ATRACCIONES%%%%%
%%%%%%%%%%%%%%%%%%%%%

%atraccion(nombre, tipo).
%tranquila(publico).
atraccion(autitosChocadores, tranquila(chicosYAdultos)).
atraccion(casaEmbrujada, tranquila(chicosYAdultos)).
atraccion(laberinto, tranquila(chicosYAdultos)).
atraccion(tobogan, tranquila(chicos)).
atraccion(calesita, tranquila(chicos)).

%intensa(coeficienteDeLanzamiento).
atraccion(barcoPirata, intensa(14)).
atraccion(tazasChinas, intensa(6)).
atraccion(simulador3D, intensa(2)).

%montaniaRusa(girosInvertidos, minutos, segundos).
atraccion(abismoMortal, montaniaRusa(3, 2, 14)).
atraccion(paseoPorElBosque, montaniaRusa(0, 0, 45)).

%acuatica
atraccion(torpedoSalpicon, acuatica([septiembre, octubre, nombiembre, diciembre, enero, febrero, marzo])).
atraccion(esperoQueHayasTraidoUnaMudaDeRopa, acuatica([septiembre, octubre, nombiembre, diciembre, enero, febrero, marzo])).

atraccion(Atraccion) :-
    atraccion(Atraccion, _).

%%%%%%%%%%%%%%%%%%%%
%%%%%VISITANTES%%%%%
%%%%%%%%%%%%%%%%%%%%

%visitante(nombre, edad, dinero, sentimiento(hambre, aburrimiento)).
visitante(eusebio, 80, 0, sentimiento(50, 0)).
visitante(carmela, 80, 0, sentimiento(0, 0)).
visitante(nicolas, 20, 5000, sentimiento(0, 0)).
visitante(juan, 20, 5000, sentimiento(0, 100)).
visitante(carola, 10, 500, sentimiento(0, 100)).

visitante(Persona) :-
    visitante(Persona, _, _, _).

esChico(Visitante) :-
    visitante(Visitante, Edad, _, _),
    Edad < 13.

%grupo(nombre, persona).
grupo(viejitos, eusebio).
grupo(viejitos, carmela).

grupo(familiaDeJuan, juan).
grupo(familiaDeJuan, carola).

grupo(Grupo) :-
    grupo(Grupo, _).

%%%%%%%%%%%%%%%%
%%%%%PUNTO2%%%%%
%%%%%%%%%%%%%%%%

%estado(persona, estado).
estado(Persona, felicidadPlena) :-
    visitante(Persona),
    grupo(_, Persona),
    sumaSentimientos(Persona, 0).

estado(Persona, podriaEstarMejor) :-
    visitante(Persona),
    not(grupo(_, Persona)),
    sumaSentimientos(Persona, 0).

estado(Persona, podriaEstarMejor) :-
    visitante(Persona),
    sumaSentimientos(Persona, Sentimientos),
    between(1, 50, Sentimientos).

estado(Persona, necesitaEntretenerse) :-
    visitante(Persona),
    sumaSentimientos(Persona, Sentimientos),
    between(51, 99, Sentimientos).

estado(Persona, seQuiereIrACasa) :-
    visitante(Persona),
    sumaSentimientos(Persona, Sentimientos),
    Sentimientos >= 100.

sumaSentimientos(Persona, Sentimientos) :-
    visitante(Persona, _, _, sentimiento(Hambre, Aburrimiento)),
    Sentimientos is Hambre + Aburrimiento.

%%%%%%%%%%%%%%%%
%%%%%PUNTO3%%%%%
%%%%%%%%%%%%%%%%

puedeSatisfacerSuHambre(Grupo, Comida) :-
    grupo(Grupo),
    comida(Comida),
    forall(grupo(Grupo, Visitante), puedeSerSatisfecho(Visitante, Comida)).

puedeSerSatisfecho(Visitante, Comida) :-
    puedeComprar(Visitante, Comida),
    satisfaceSuHambre(Visitante, Comida).

puedeComprar(Visitante, Comida) :-
    visitante(Visitante, _, Plata, _),
    comida(Comida, Precio),
    Plata >= Precio.

satisfaceSuHambre(Visitante, hamburguesa) :-
    visitante(Visitante, _, _, sentimiento(Hambre, _)),
    Hambre < 50.

satisfaceSuHambre(Visitante, panchitoConPapas) :-
    esChico(Visitante).

satisfaceSuHambre(_, lomito).

satisfaceSuHambre(Visitante, caramelos) :-
    visitante(Visitante),
    not(puedeComprar(Visitante, Comida), Comida \= caramelos).

%%%%%%%%%%%%%%%%
%%%%%PUNTO4%%%%%
%%%%%%%%%%%%%%%%

lluviaDeHamburguesas(Visitante, Atraccion) :- 
    puedeComprar(Visitante, hamburguesa),
    puedeSubir(Visitante, Atraccion),
    atraccion(Atraccion, intensa(CoeficienteDeLanzamiento)),
    CoeficienteDeLanzamiento > 10.

lluviaDeHamburguesas(Visitante, Atraccion) :- 
    puedeComprar(Visitante, hamburguesa),
    puedeSubir(Visitante, Atraccion),
    atraccion(Atraccion, montaniaRusa(_, _, _)),
    esPeligrosa(Visitante, Atraccion).

lluviaDeHamburguesas(Visitante, tobogan) :- 
    puedeComprar(Visitante, hamburguesa),
    puedeSubir(Visitante, tobogan).

noPuedeSubir(Visitante, Atraccion) :-
    visitante(Visitante),
    not(esChico(Visitante)),
    not(vaConChicos(Visitante)),
    atraccion(Atraccion, tranquila(chicos)).

vaConChicos(Visitante) :-
    grupo(Grupo, Visitante),
    grupo(Grupo, OtroVisitante),
    esChico(OtroVisitante).

puedeSubir(Visitante, Atraccion) :-
    not(noPuedeSubir(Visitante, Atraccion)).

esPeligrosa(Visitante, Atraccion) :-
    visitante(Visitante),
    esChico(Visitante),
    atraccion(Atraccion, montaniaRusa(_, Minutos, _)),
    Minutos >= 1.

esPeligrosa(Visitante, Atraccion) :-
    visitante(Visitante),
    not(esChico(Visitante)),
    not(estado(Visitante, necesitaEntretenerse)),
    atraccion(Atraccion, montaniaRusa(_, _, _)),
    esLaMasGrosa(Atraccion).

esLaMasGrosa(Atraccion) :-
    atraccion(Atraccion, montaniaRusa(Giros, _, _)),
    forall(atraccion(_, montaniaRusa(OtrosGiros, _, _)), Giros >= OtrosGiros).

%%%%%%%%%%%%%%%%
%%%%%PUNTO5%%%%%
%%%%%%%%%%%%%%%%

lugaresDeInteres(Visitante, Lugar, _) :-
    visitante(Visitante),
    puedeComprar(Visitante, Lugar).

lugaresDeInteres(Visitante, Lugar, _) :-
    visitante(Visitante),
    atraccion(Lugar),
    puedeSubir(Visitante, Lugar),
    not(esPeligrosa(Visitante, Lugar)).

lugaresDeInteres(_, Lugar, Mes) :-
    atraccion(Lugar),
    puedeSubirAcuatica(Lugar, Mes).

puedeSubirAcuatica(Atraccion, Mes) :-
    atraccion(Atraccion, acuatica(MesesDisponible)),
    member(Mes, MesesDisponible).