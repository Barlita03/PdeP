%persona(nombre, caracteristicas).
persona(nina, joven(22, 160)).
persona(marcos, ninio(8, 132)).
persona(osvaldo, adolescente(13, 129)).

persona(Persona) :-
    persona(Persona, _).

%atraccion(parque, nombre).
atraccion(parqueDeLaCosta, trenFantasma).
atraccion(parqueDeLaCosta, montaniaRusa).
atraccion(parqueDeLaCosta, maquinaTiquetera).
atraccion(parqueAcuatico, laOlaAzul).
atraccion(parqueAcuatico, corrienteSerpenteante).
atraccion(parqueAcuatico, maremoto).

atraccion(Atraccion) :-
    atraccion(_, Atraccion).

parque(Parque) :-
    atraccion(Parque, _).

%puedeSubir(persona, atraccion).
puedeSubir(Persona, Atraccion) :-
    persona(Persona),
    atraccion(Atraccion),
    cumpleRequisitos(Persona, Atraccion).

%cumpleRequisitos(persona, atraccion).
cumpleRequisitos(Persona, trenFantasma) :-
    edadPersona(Persona, Edad),
    Edad >= 12.

cumpleRequisitos(Persona, trenFantasma) :-
    alturaPersona(Persona, Altura),
    Altura > 130.

cumpleRequisitos(_, maquinaTiquetera).

cumpleRequisitos(Persona, laOlaAzul) :-
    alturaPersona(Persona, Altura),
    Altura >= 150.

cumpleRequisitos(_, corrienteSerpenteante).

cumpleRequisitos(Persona, maremoto) :-
    edadPersona(Persona, Edad),
    Edad >= 5.

%alturaPersona(persona, altura).
alturaPersona(Persona, Altura) :-
    persona(Persona, Caracteristicas),
    altura(Caracteristicas, Altura).

%altura(caracteristicas, altura).
altura(joven(_, Altura), Altura).
altura(ninio(_, Altura), Altura).
altura(adolescente(_, Altura), Altura).

%edadPersona(persona, edad).
edadPersona(Persona, Edad) :-
    persona(Persona, Caracteristicas),
    edad(Caracteristicas, Edad).

%edad(caracteristicas, edad).
edad(joven(_, Edad), Edad).
edad(ninio(_, Edad), Edad).
edad(adolescente(_, Edad), Edad).

%esParaElle(persona, parque).
esParaElle(Persona, Parque) :-
    persona(Persona),
    parque(Parque),
    forall(atraccion(Parque, Atraccion), puedeSubir(Persona, Atraccion)).

esMalaIdea(GrupoEtareo, Parque) :-
    parque(Parque),
    grupoEtareo(GrupoEtareo),
    grupoEtareo(Persona, GrupoEtareo),
    not(esParaElle(Persona, Parque)).

%grupoEtareo(persona, grupo).
grupoEtareo(Persona, joven) :-
    persona(Persona, joven(_, _)).

grupoEtareo(Persona, ninio) :-
    persona(Persona, ninio(_, _)).

grupoEtareo(Persona, adolescente) :-
    persona(Persona, adolescente(_, _)).

grupoEtareo(Grupo) :-
    grupoEtareo(_, Grupo).

programaLogico(Programa) :-
    parque(Parque),
    not(juegosIguales(Programa)),
    forall(member(Atraccion, Programa), atraccion(Parque, Atraccion)).

juegosIguales(Programa) :-
    nth0(IndexUno, Programa, Juego),
    nth0(IndexDos, Programa, Juego),
    IndexUno \= IndexDos.

hastaAca(Persona, Programa, SubPrograma) :-
    persona(Persona),
    hastaDondePuede(Persona, Programa, Index),
    findall(Juego, enEstosPuede(Persona, Programa, Juego, Index), SubPrograma).

enEstosPuede(Persona, Programa, Juego, Index) :-
    nth0(Indice, Programa, Juego),
    Indice < Index.

hastDondePuede(Persona, Programa, Index) :-
    nth0(Index, Programa, Juego),
    not(puedeSubir(Persona, Juego)).

%tipoDeJuego(nombre, tipo).
tipoDeJuego(trenFantasma, comun(100)).
tipoDeJuego(maquinaTiquetera, comun(50)).
tipoDeJuego(corrienteSerpenteante, comun(25)).
tipoDeJuego(montaniaRusa, premium).
tipoDeJuego(laOlaAzul, premium).
tipoDeJuego(maremoto, premium).

%pasaporte(persona, pasaporte).
pasaporte(nina, premium).
pasaporte(marcos, basico(90)).
pasaporte(osvaldo, flex(100, montaniaRusa)).

puedeSubir2(Persona, Atraccion) :-
    persona(Persona),
    atraccion(Atraccion),
    pasaporte(Persona, premium),
    cumpleRequisitos(Persona, Atraccion).

puedeSubir2(Persona, Atraccion) :-
    persona(Persona),
    atraccion(Atraccion),
    pasaporte(Persona, flex(_, Atraccion)),
    cumpleRequisitos(Persona, Atraccion).

puedeSubir2(Persona, Atraccion) :-
    persona(Persona),
    atraccion(Atraccion),
    tieneTiquets(Persona, Atraccion),
    cumpleRequisitos(Persona, Atraccion).

tieneTiquets(Persona, Juego) :-
    pasaporte(Persona, basico(TiquetsPersona)),
    tipoDeJuego(Juego, comun(TiquetsJuego)),
    TiquetsPersona >= TiquetsJuego.

tieneTiquets(Persona, Juego) :-
    pasaporte(Persona, flex(TiquetsPersona, _)),
    tipoDeJuego(Juego, comun(TiquetsJuego)),
    TiquetsPersona >= TiquetsJuego.