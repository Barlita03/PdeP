% BASE DE CONOCIMIENTO %

% jockey(Nombre, Altura, Peso).

jockey(valdivieso, 155, 52).
jockey(leguisamo, 161, 49).
jockey(lezcano, 149, 50).
jockey(baratucci, 153, 55).
jockey(falero, 157, 52).

jockey(Jockey):-
  jockey(Jockey, _, _).

% caballo(Nombre).

caballo(botafogo).
caballo(oldMan).
caballo(energica).
caballo(matBoy).
caballo(yatasto).

% preferencia(Caballo, Jockey).

preferencia(botafogo, baratucci).
preferencia(botafogo, Jockey):-
  jockey(Jockey, _, Peso),
  Peso < 52.

preferencia(oldMan, Jockey):-
  jockey(Jockey),
  atom_length(Jockey, Letras),
  Letras > 7.

preferencia(energica, Jockey):-
  jockey(Jockey),
  not(preferencia(botafogo, Jockey)).

preferencia(matBoy, Jockey):-
  jockey(Jockey, Altura, _),
  Altura > 170.

% caballeriza(Jockey, caballeriza).

caballeriza(valdivieso, elTute).
caballeriza(falero, elTute).
caballeriza(lezcano, lasHormigas).
caballeriza(baratucci, elCharabon).
caballeriza(leguisamo, elCharabon).

% premio(Ganador, Premio).

premio(botafogo, granPremioNacional).
premio(botafogo, granPremioRepublica).
premio(oldMan, granPremioRepublica).
premio(oldMan, campeonatoPalermoDeOro).
premio(matBoy, granPremioCriadores).

% color(Caballo, Crin).

color(botafogo, tordo).
color(oldMan, alazan).
color(energica, ratonero).
color(matBoy, palomino).
color(yatasto, pinto).

% crin(Crin, Color).

crin(tordo, negro).
crin(alazan, marron).
crin(ratonero, gris).
crin(ratonero, negro).
crin(palomino, marron).
crin(palomino, blanco).
crin(pinto, marron).
crin(pinto, blanco).

% PUNTO 2 %

prefierenAMasDeUnJockey(Caballo):-
  caballo(Caballo),
  preferencia(Caballo, UnJockey),
  preferencia(Caballo, OtroJockey),
  UnJockey \= OtroJockey.

% PUNTO 3 %

aborrece(Caballo, Caballeriza):-
  caballo(Caballo),
  caballeriza(_, Caballeriza),
  forall((preferencia(Caballo, Jockey)), not(caballeriza(Jockey, Caballeriza))).

% PUNTO 4 %

piolines(Jockey):-
  jockey(Jockey),
  caballosImportantes(CaballosImportantes),
  forall(member(UnCaballo, CaballosImportantes), preferencia(UnCaballo, Jockey)).

caballosImportantes(CaballosImportantes):-
  findall(Caballo, ganoPremioImportante(Caballo), CaballosImportantes). 

ganoPremioImportante(Caballo):-
  premio(Caballo, granPremioNacional).

ganoPremioImportante(Caballo):-
  premio(Caballo, granPremioRepublica).

% PUNTO 5 %

apuestaGanadora(ganador(Caballo), Resultado):-
  salioPrimero(Caballo, Resultado).

apuestaGanadora(segundo(Caballo), Resultado):-
  salioPrimero(Caballo, Resultado).

apuestaGanadora(segundo(Caballo), Resultado):-
  salioSegundo(Caballo, Resultado).

apuestaGanadora(exacta(Caballo1, Caballo2), Resultado):-
  podio(Caballo1, Caballo2, Resultado).

apuestaGanadora(imperfecta(Caballo1, Caballo2), Resultado):-
  podio(Caballo1, Caballo2, Resultado).

apuestaGanadora(imperfecta(Caballo1, Caballo2), Resultado):-
  podio(Caballo2, Caballo1, Resultado).

podio(Caballo1, Caballo2, Resultado):-
  salioPrimero(Caballo1, Resultado),
  salioSegundo(Caballo2, Resultado).

salioPrimero(Caballo, [Caballo|_]).

salioSegundo(Caballo, [_,Caballo|_]).

% PUNTO 6 %

preferenciaPorColor(Color, Caballos):-
  findall(Caballo, (color(Caballo, Crin), crin(Crin, Color)), TodosLosCaballos),
  combinacionesPosibles(Caballos, TodosLosCaballos),
  Caballos \= [].

combinacionesPosibles([], []).

combinacionesPosibles([Caballo|Caballos], [Caballo|TodosLosCaballos]) :-
    combinacionesPosibles(Caballos, TodosLosCaballos).

combinacionesPosibles(Caballos, [_|TodosLosCaballos]) :-
    combinacionesPosibles(Caballos, TodosLosCaballos).
  