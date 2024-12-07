%%%%%%%%%%%%%%%%%
%%%Ejercicio 1%%%
%%%%%%%%%%%%%%%%%

%precio(Comida, Precio)
precio(hamburguesa, 2000).
precio(pancho, 1500).
precio(lomito, 2500).
precio(caramelo, 0).

%visitante(Nombre, datosSuperficiales(Edad, Dinero), sentimiento(Hambre, Aburrimiento))
visitante(eusebio, datosSuperficiales(80, 3000), sentimiento(50, 0)).
visitante(carmela, datosSuperficiales(80, 0), sentimiento(0, 25)).
visitante(fede, datosSuperficiales(35, 3000), sentimiento(50, 0)).
visitante(feli, datosSuperficiales(30, 3000), sentimiento(25, 25)).

%grupoFamiliar(Grupo, Integrante)
grupoFamiliar(viejitos, eusebio).
grupoFamiliar(viejitos, carmela).

grupoFamiliar(pdep, fede).
grupoFamiliar(pdep, feli).

%atraccion(Nombre, Informacion)
%Informacion:
    %tranquila(Tipo) : familiar o exclusiva para chicos
    %intensa(CoeficienteDeLanzamiento)
    %montaniaRusa(CantidadDeGiros, Minutos, Segundos)
    %actuatica

atraccion(autosChocadores, tranquila(familiar)).
atraccion(laCasaEmbrujada, tranquila(familiar)).
atraccion(laberinto, tranquila(familiar)).
atraccion(tobogan, tranquila(chicos)).
atraccion(calesita, tranquila(chicos)).

atraccion(barcoPirata, intensa(14)).
atraccion(tazasChinas, intensa(6)).
atraccion(simulador3D, intensa(2)).

atraccion(abismoMortalRecargada, montaniaRusa(3, 2, 14)).
atraccion(paseoPorElBosque, montaniaRusa(0, 0, 45)).

atraccion(torpedoSalpicon, acuatica).
atraccion(esperoQueHayasTraidoUnaMudaDeRopa, acuatica).

%%%%%%%%%%%%%%%%%
%%%Ejercicio 2%%%
%%%%%%%%%%%%%%%%%

bienestar(Visitante, felicidadPlena) :-
    coeficienteDeFelicidad(Visitante, 0),
    grupoFamiliar(_, Visitante).

bienestar(Visitante, podriaEstarMejor) :-
    coeficienteDeFelicidad(Visitante, 0),
    not(grupoFamiliar(_, Visitante)).

bienestar(Visitante, podriaEstarMejor) :-
    coeficienteDeFelicidad(Visitante, Coeficiente),
    between(1, 50, Coeficiente).

bienestar(Visitante, necesitaEntretenerse) :-
    coeficienteDeFelicidad(Visitante, Coeficiente),
    between(51, 99, Coeficiente).

bienestar(Visitante, seQuiereIrACasa) :-
    coeficienteDeFelicidad(Visitante, Coeficiente),
    Coeficiente >= 100.

coeficienteDeFelicidad(Visitante, Coeficiente) :-
    visitante(Visitante, _, sentimiento(Hambre, Aburrimiento)),
    Coeficiente is Hambre + Aburrimiento.

%! Podria haber hecho una abstraccion mas que sea:

%! coeficienteDeFelicidadEntre(Visitante, UnNumero, OtroNumero) :-
%!     coeficienteDeFelicidad(Visitante, Coeficiente),
%!     between(UnNumero, OtroNumero, Coeficiente).

%%%%%%%%%%%%%%%%%
%%%Ejercicio 3%%%
%%%%%%%%%%%%%%%%%

puedeSatisfacerSuHambreCon(Grupo, Comida) :-
    grupoFamiliar(Grupo, _),
    precio(Comida, _),
    forall(grupoFamiliar(Grupo, Integrante), puedeComprarYSatisfaceSuHambre(Integrante, Comida)).

puedeComprarYSatisfaceSuHambre(Visitante, Comida) :-
    puedeComprar(Visitante, Comida),
    satisfaceSuHambre(Visitante, Comida).

puedeComprar(Visitante, Comida) :-
    visitante(Visitante, datosSuperficiales(_, Dinero), _),
    precio(Comida, Precio),
    Dinero >= Precio.

satisfaceSuHambre(Visitante, hamburguesa) :-
    visitante(Visitante, _, sentimiento(Hambre, _)),
    Hambre < 50.

satisfaceSuHambre(Visitante, pancho) :-
    esChico(Visitante).

satisfaceSuHambre(_, lomito).

satisfaceSuHambre(Visitante, caramelo) :-
    visitante(Visitante, _, _),
    forall((precio(Comida, _), Comida \= caramelo), not(puedeComprar(Visitante, Comida))).

esChico(Visitante) :-
    visitante(Visitante, datosSuperficiales(Edad, _), _),
    Edad < 13.

%%%%%%%%%%%%%%%%%
%%%Ejercicio 4%%%
%%%%%%%%%%%%%%%%%

%! Podria haber generado una abstraccion en:

%! lluviaDeHamburguesas(Visitante, Atraccion) :-
%!     puedeComprar(Visitante, hamburguesa),
%!     ...

lluviaDeHamburguesas(Visitante, tobogan) :-
    puedeComprar(Visitante, hamburguesa).

lluviaDeHamburguesas(Visitante, Atraccion) :-
    puedeComprar(Visitante, hamburguesa),
    atraccion(Atraccion, intensa(CoeficienteDeLanzamiento)),
    CoeficienteDeLanzamiento > 10.

lluviaDeHamburguesas(Visitante, Atraccion) :-
    puedeComprar(Visitante, hamburguesa),
    atraccion(Atraccion, montaniaRusa(_, _)),
    esPeligrosa(Visitante, Atraccion).

esPeligrosa(Visitante, Atraccion) :-
    esChico(Visitante),
    atraccion(Atraccion, montaniaRusa(_, Minutos, _)),
    Minutos >= 1.

esPeligrosa(Visitante, montaniaRusa(CantidadDeGiros, _, _)) :-
    not(esChico(Visitante)),
    not(bienestar(Visitante, necesitaEntretenerse)),
    esLaMontaniaRusaConMasGiros(CantidadDeGiros).

esLaMontaniaRusaConMasGiros(CantidadDeGiros) :-
    forall(atraccion(_, montaniaRusa(OtraCantidadDeGiros, _, _)), CantidadDeGiros >= OtraCantidadDeGiros).

%%%%%%%%%%%%%%%%%
%%%Ejercicio 5%%%
%%%%%%%%%%%%%%%%%

mejoresOpcionesDeEntretenimiento(Visitante, MesDeVisita, Opciones) :-
    opcionesPuestosDeComida(Visitante, PuestosDeComida),
    opcionesDeAtracciones(Visitante, MesDeVisita, Atracciones),
    append(PuestosDeComida, Atracciones, Opciones).

opcionesPuestosDeComida(Visitante, PuestosDeComida) :-
    visitante(Visitante, _, _),
    findall(Comida, puedeComprar(Visitante, Comida), PuestosDeComida).

opcionesDeAtracciones(Visitante, MesDeVisita, Atracciones) :-
    visitante(Visitante, _, _),
    findall(Atraccion, esRecomendable(Visitante, MesDeVisita, Atraccion), Atracciones).

esRecomendable(_, _, Atraccion) :-
    atraccion(Atraccion, intensa(_)).

esRecomendable(_, _, Atraccion) :-
    atraccion(Atraccion, tranquila(familiar)).

esRecomendable(Visitante, _, Atraccion) :-
    atraccion(Atraccion, tranquila(chicos)),
    esChico(Visitante).

esRecomendable(Visitante, _, Atraccion) :-
    atraccion(Atraccion, tranquila(chicos)),
    acompaniaAUnChico(Visitante).

esRecomendable(Visitante, _, Atraccion) :-
    visitante(Visitante, _, _),
    atraccion(Atraccion, montaniaRusa(_, _, _)),
    not(esPeligrosa(Visitante, Atraccion)).

esRecomendable(_, septiembre, Atraccion) :-
    atraccion(Atraccion, acuatica).

esRecomendable(_, octubre, Atraccion) :-
    atraccion(Atraccion, acuatica).

esRecomendable(_, noviembre, Atraccion) :-
    atraccion(Atraccion, acuatica).

esRecomendable(_, diciembre, Atraccion) :-
    atraccion(Atraccion, acuatica).

esRecomendable(_, enero, Atraccion) :-
    atraccion(Atraccion, acuatica).

esRecomendable(_, febrero, Atraccion) :-
    atraccion(Atraccion, acuatica).

esRecomendable(_, marzo, Atraccion) :-
    atraccion(Atraccion, acuatica).

acompaniaAUnChico(Visitante) :-
    grupoFamiliar(Grupo, Visitante),
    grupoFamiliar(Grupo, OtroVisitante),
    esChico(OtroVisitante).