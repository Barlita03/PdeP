%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%Base de conocimiento%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%persona(nombre, edad).
persona(laura, 24).
persona(federico, 31).
persona(maria, 23).
persona(jacobo, 45).
persona(enrique, 49).
persona(andrea, 38).
persona(gabriela, 4).
persona(gonzalo, 23).
persona(alejo, 20).
persona(andres, 11).
persona(ricardo, 39).
persona(ana, 7).
persona(juana, 15).

%quiere(quien, quiere).
quiere(andres, juguetes(maxSteel, 150)).
quiere(juana, juguetes(barbie, 175)).
quiere(gabriela, juguetes(gabeneitor2000, 5000)).
quiere(andres, bloques([piezaT, piezaL, cubo, piezaChata])).
quiere(maria, bloques([piezaT, piezaT])).
quiere(alejo, bloques([piezaT])).
quiere(federico, abrazo).
quiere(enrique, abrazo).
quiere(laura, abrazo).
quiere(gonzalo, abrazo).

%presupuesto(quien, presupuesto).
presupuesto(jacobo, 20).
presupuesto(andrea, 100).
presupuesto(laura, 2000).
presupuesto(ricardo, 154).
presupuesto(enrique, 2311).

%accion(quien, hizo).
accion(ana, travesura(1)).
accion(alejo, travesura(4)).
accion(andres, travesura(3)).
accion(andres, ayudar(ana)).
accion(maria, ayudar(federico)).
accion(ana, golpear(andres)).
accion(gonzalo, golpear(alejo)).
accion(federico, golpear(enrique)).
accion(maria, favor(juana)).
accion(juana, favor(maria)).

%padre(padre, hije).
padre(jacobo, ana).
padre(jacobo, juana).
padre(enrique, federico).
padre(ricardo, maria).
padre(andrea, andres).
padre(laura, gabriela).

creeEnEl(Persona) :-
    esNinio(Persona).

creeEnEl(federico).

esNinio(Persona) :-
    persona(Persona, Edad),
    Edad < 13.

persona(Persona) :-
    persona(Persona, _).

regalo(Regalo) :-
    quiere(_, Regalo).

regalo(Regalo) :-
    quiere(_, juguetes(Regalo, _)).

regalo(Regalo) :-
    quiere(_, bloques(Bloques)),
    member(Regalo, Bloques).

%%%%%%%%%%%%%%%%%
%%%%%PUNTO 1%%%%%
%%%%%%%%%%%%%%%%%

buenaAccion(ayudar(_)).

buenaAccion(favor(_)).

buenaAccion(travesura(Nivel)) :-
    between(0, 3, Nivel).

%%%%%%%%%%%%%%%%%
%%%%%PUNTO 2%%%%%
%%%%%%%%%%%%%%%%%

sePortoBien(Persona) :-
    persona(Persona),
    forall(accion(Persona, Accion), buenaAccion(Accion)).

%%%%%%%%%%%%%%%%%
%%%%%PUNTO 3%%%%%
%%%%%%%%%%%%%%%%%

malcriado(Persona) :-
    not(creeEnEl(Persona)).

malcriado(Persona) :-
    persona(Persona),
    forall(accion(Persona, Accion), not(buenaAccion(Accion))).

malcriador(Persona) :-
    padre(Persona, _),
    forall(padre(Persona, Hije), malcriado(Hije)).

%%%%%%%%%%%%%%%%%
%%%%%PUNTO 4%%%%%
%%%%%%%%%%%%%%%%%

puedeCostear(Padre, Hijo) :-
    padre(Padre, Hijo),
    cuantoDuele(Hijo, Precio),
    presupuesto(Padre, Presupuesto),
    Presupuesto >= Precio.

precio(juguetes(_, Precio), Precio).

precio(bloques(Bloques), Precio) :-
    length(Bloques, Cantidad),
    Precio is 3 * Cantidad.

precio(abrazo, 0).

cuantoDuele(Hijo, PrecioFinal) :-
    findall(Precio, precioRegalo(Hijo, Precio), Precios),
    sumlist(Precios, PrecioFinal).

precioRegalo(Hijo, Precio) :-
    quiere(Hijo, Objeto),
    precio(Objeto, Precio).

%%%%%%%%%%%%%%%%%
%%%%%PUNTO 5%%%%%
%%%%%%%%%%%%%%%%%

regaloCandidatoPara(Persona, Regalo) :-
    regalo(Regalo),
    persona(Persona),
    creeEnEl(Persona),
    sePortoBien(Persona),
    papiPaga(Persona, Regalo),
    quiereElRegalo(Persona, Regalo).

papiPaga(Hijo, Regalo) :-
    padre(Padre, Hijo),
    puedePagar(Padre, Regalo).

puedePagar(Persona, Regalo) :-
    persona(Persona),
    precio(Regalo, Precio),
    presupuesto(Persona, Presupuesto),
    Presupuesto >= Precio.

quiereElRegalo(Persona, Regalo) :-
    quiere(Persona, Regalo).

quiereElRegalo(Persona, Regalo) :-
    quiere(Persona, juguetes(Regalo, _)).

quiereElRegalo(Persona, Regalo) :-
    quiere(Persona, bloques(Bloques)),
    member(Regalo, Bloques).

%%%%%%%%%%%%%%%%%
%%%%%PUNTO 6%%%%%
%%%%%%%%%%%%%%%%%

regalosQueRecibe(Persona, Regalos) :-
    persona(Persona),
    papiCostea(Persona),
    findall(Regalo, quiere(Persona, Regalo), Regalos).

regalosQueRecibe(Persona, Regalos) :-
    persona(Persona),
    not(papiCostea(Persona)),
    sePortoBien(Persona),
    append([], [mediaBlanca, mediaGris], Regalos).

regalosQueRecibe(Persona, carbon) :-
    persona(Persona),
    not(papiCostea(Persona)),
    alMenosDosMalasAcciones(Persona).

papiCostea(Hijo) :-
    padre(Padre, Hijo),
    puedeCostear(Padre, Hijo).

alMenosDosMalasAcciones(Persona) :-
    accion(Persona, UnaAccion),
    accion(Persona, OtraAccion),
    not(buenaAccion(UnaAccion)),
    not(buenaAccion(OtraAccion)),
    UnaAccion \= OtraAccion.

%%%%%%%%%%%%%%%%%
%%%%%PUNTO 7%%%%%
%%%%%%%%%%%%%%%%%

sugarDaddy(Persona) :-
    padre(Persona, _),
    forall(padre(Persona, Hijo), regalosSugar(Hijo)).

regalosSugar(Hijo) :-
    forall(quiere(Hijo, Regalo), esSugar(Regalo)).

esSugar(Regalo) :-
    precio(Regalo, Precio),
    Precio > 500.

esSugar(juguetes(woody, _)).

esSugar(juguetes(buzz, _)).

esSugar(bloques(Bloques)) :-
    member(cubo, Bloques).
