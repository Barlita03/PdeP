% persona(Nombre, GrupoEtario, Edad, Altura).
persona(nina, joven, 22, 160).
persona(juan, joven, 22, 136).
persona(marcos, ninio, 8, 132).
persona(osvaldo, adolescente, 13, 129).

persona(Persona):-
  persona(Persona, _, _, _).

% atraccion(Parque, Atraccion, Tipo).
atraccion(parqueDeLaCosta, trenFantasma, premium).
atraccion(parqueDeLaCosta, montaniaRusa, comun(40)).
atraccion(parqueDeLaCosta, maquinaTiquetera, comun(10)).

atraccion(parqueAcuatico, toboganGiganteLaOlaAzul, premium).
atraccion(parqueAcuatico, rioLentoCorrienteSerpenteante, premium).
atraccion(parqueAcuatico, piscinaDeOlasMaremoto, comun(30)).

% puedeSubir(Persona, Atraccion).
puedeSubir(Persona, Atraccion):-
  persona(Persona),
  atraccion(_, Atraccion),
  cumpleRequisitosDePasaporte(Persona, Atraccion),
  cumpleRequisitosDeAtraccion(Persona, Atraccion).

cumpleRequisitosDeAtraccion(Persona, trenFantasma):-
  cumpleEdadMinima(Persona, 12).

cumpleRequisitosDeAtraccion(Persona, montaniaRusa):-
  cumpleAlturaMinima(Persona, 131).

cumpleRequisitosDeAtraccion(_, maquinaTiquetera).

cumpleRequisitosDeAtraccion(Persona, toboganGiganteLaOlaAzul):-
  cumpleAlturaMinima(Persona, 150).

cumpleRequisitosDeAtraccion(_, rioLentoCorrienteSerpenteante).

cumpleRequisitosDeAtraccion(Persona, piscinaDeOlasMaremoto):-
  cumpleEdadMinima(Persona, 5).

cumpleAlturaMinima(Persona, AlturaMinima):-
  persona(Persona, _, _, Altura),
  Altura >= AlturaMinima.

cumpleEdadMinima(Persona, EdadMinima):-
persona(Persona, _, Edad, _),
  Edad >= EdadMinima.

% esParaElle(Persona, Parque).
esParaElle(Persona, Parque):-
  atraccion(Parque, _),
  persona(Persona),
  forall(atraccion(Parque, Atraccion), puedeSubir(Persona, Atraccion)).

% malaIdea(GrupoEtario, Parque).
malaIdea(GrupoEtario, Parque):-
  persona(Persona, GrupoEtario, _, _),
  findall(Persona, persona(Persona, GrupoEtario, _, _), Personas),
  atraccion(Parque, _),
  noHayJuegoParaTodos(Parque, Personas).

noHayJuegoParaTodos(Parque, Personas):-
  atraccion(Parque, Atraccion),
  alguienNoPuedeSubir(Personas, Atraccion).

alguienNoPuedeSubir(Personas, Atraccion):-
  member(Persona, Personas),
  not(puedeSubir(Persona, Atraccion)).

% programaLogico(Programa).
programaLogico(Programa):-
  todosDelMismoParque(Programa),
  not(hayJuegosRepetidos(Programa)).

todosDelMismoParque(Programa):-
  atraccion(Parque, _),
  forall(member(Juego, Programa), atraccion(Parque, Juego)).

hayJuegosRepetidos([J|Js]):-
  member(J, Js).

hayJuegosRepetidos([_|Js]):-
  hayJuegosRepetidos(Js).

% hastaAca(Persona, Programa, Subprograma).
hastaAca(_, [], []).

hastaAca(P, [Q|Qs], [Q|S]):-
  puedeSubir(P, Q),
  hastaAca(P, Qs, S).

hastaAca(P, [Q|_], []):-
  not(puedeSubir(P, Q)).

% pasaporte(Persona, basico(Credito)).
% pasaporte(Persona, flex(Credito, JuegoPremium)).
% pasaporte(Persona, premium).

cumpleRequisitosDePasaporte(Persona, Atraccion):-
  pasaporte(Persona, Pasaporte),
  criterioSegunTipoDePasaporte(Pasaporte, Atraccion).

criterioSegunTipoDePasaporte(basico(Credito), Atraccion):-
  atraccion(Atraccion, _, comun(CreditoNecesario)),
  CreditoNecesario <= Credito.

criterioSegunTipoDePasaporte(flex(Credito, _), Atraccion):-
  criterioSegunTipoDePasaporte(basico(Credito), Atraccion).

criterioSegunTipoDePasaporte(flex(_, Atraccion), Atraccion).

criterioSegunTipoDePasaporte(premium, _).
