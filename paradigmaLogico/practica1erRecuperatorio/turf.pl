%%%%%%%%%%%%%
%%%Punto 1%%%
%%%%%%%%%%%%%

%jockey(Nombre, Altura, Peso)
jockey(valdivieso, 155, 52).
jockey(leguisamo, 161, 49).
jockey(lezcano, 149, 50).
jockey(baratucci, 153, 55).
jockey(falero, 157, 52).

%caballo(Nombre)
caballo(botafogo).
caballo(oldMan).
caballo(energica).
caballo(matBoy).
caballo(yatasto).

%prefiere(caballo, jockey)
prefiere(botafogo, baratucci).

prefiere(botafogo, Jockey) :-
    jockey(Jockey, _, Peso),
    Peso < 52.

prefiere(oldMan, Jockey) :-
    jockey(Jockey, _, _),
    atom_length(Jockey, CantidadDeLetras),
    CantidadDeLetras > 7.

prefiere(energica, Jockey) :-
    jockey(Jockey, _, _),
    not(prefiere(botafogo, Jockey)).

prefiere(matBoy, Jockey) :-
    jockey(Jockey, Altura, _),
    Altura > 170.

%stud(Jockey, Caballeriza)
stud(valdivieso, elTute).
stud(falero, elTute).
stud(lezcano, lasHormigas).
stud(baratucci, elCharabon).
stud(leguisamo, elCharabon).

%premio(Caballo, Premio)
premio(botafogo, granPremioNacional).
premio(botafogo, granPremioRepublica).
premio(oldMan, granPremioRepublica).
premio(oldMan, campeonatoPalermoDeOro).
premio(yatasto, granPremioCriadores).

%%%%%%%%%%%%%
%%%Punto 2%%%
%%%%%%%%%%%%%

%prefiereAMasDeUnJockey(Caballo)
prefiereAMasDeUnJockey(Caballo) :-
    prefiere(Caballo, UnJockey),
    prefiere(Caballo, OtroJockey),
    UnJockey \= OtroJockey.

%%%%%%%%%%%%%
%%%Punto 3%%%
%%%%%%%%%%%%%

%aborrece(Caballo, Stud)
aborrece(Caballo, Stud) :-
    caballo(Caballo),
    stud(_, Stud),
    forall(stud(Jockey, Stud), not(prefiere(Caballo, Jockey))).

%%%%%%%%%%%%%
%%%Punto 4%%%
%%%%%%%%%%%%%

premioImportante(granPremioNacional).
premioImportante(granPremioRepublica).

piolin(Jockey) :-
    jockey(Jockey, _, _),
    forall(caballoConPremioImportante(Caballo), prefiere(Caballo, Jockey)).

caballoConPremioImportante(Caballo) :-
    premio(Caballo, Premio),
    premioImportante(Premio).

%%%%%%%%%%%%%
%%%Punto 5%%%
%%%%%%%%%%%%%

%!Esto tendria que haber sido una unica relacion y los diferentes tipos de apuestas functores
%!Asi deberia haberlo hecho:

%! ganadora(ganador(Caballo), Resultado):-salioPrimero(Caballo, Resultado).
%! ganadora(segundo(Caballo), Resultado):-salioPrimero(Caballo, Resultado).
%! ganadora(segundo(Caballo), Resultado):-salioSegundo(Caballo, Resultado).
%! ganadora(exacta(Caballo1, Caballo2),Resultado):-salioPrimero(Caballo1, Resultado), salioSegundo(Caballo2, Resultado).
%! ganadora(imperfecta(Caballo1, Caballo2),Resultado):-salioPrimero(Caballo1, Resultado), salioSegundo(Caballo2, Resultado).
%! ganadora(imperfecta(Caballo1, Caballo2),Resultado):-salioPrimero(Caballo2, Resultado), salioSegundo(Caballo1, Resultado).

%! salioPrimero(Caballo, [Caballo|_]).
%! salioSegundo(Caballo, [_|[Caballo|_]]).

%aGanadorPorUnCaballo(Caballo, ResultadoDeLaCarrera)
aGanadorPorUnCaballo(Caballo, [ Caballo | _ ]).

%aSegundaPorUnCaballo(Caballo, ResultadoDeLaCarrera)
aSegundaPorUnCaballo(Caballo, [ Caballo | _ ]).

aSegundaPorUnCaballo(Caballo, [ _ | [ Caballo | _ ] ]).

%exacta(Caballos, ResultadoDeLaCarrera)
exacta([PrimerCaballo, SegundoCaballo], [ PrimerCaballo | [ SegundoCaballo | _ ] ]).

%exacta(Caballos, ResultadoDeLaCarrera)
imperfecta([PrimerCaballo, SegundoCaballo], [ PrimerCaballo | [ SegundoCaballo | _ ] ]).

imperfecta([PrimerCaballo, SegundoCaballo], [ SegundoCaballo | [ PrimerCaballo | _ ] ]).

%%%%%%%%%%%%%
%%%Punto 6%%%
%%%%%%%%%%%%%

%color(Caballo, Color)
color(botafogo, negro).
color(oldMan, marron).
color(energica, gris).
color(energica, negro).
color(matBoy, marron).
color(matBoy, blanco).
color(yatasto, blanco).
color(yatasto, marron).

%podriaComprar(Color, Caballo)
podriaComprar(Color, Caballos) :-
    color(_, Color),
    findall(Caballo, color(Caballo, Color), PosiblesCompras),
    diferentesCombinaciones(PosiblesCompras, Caballos),
    Caballos \= [].

diferentesCombinaciones([], []).

diferentesCombinaciones([ Caballo | CaballosPosibles ], [ Caballo | Caballos ]) :-
    diferentesCombinaciones(CaballosPosibles, Caballos).

diferentesCombinaciones([ _ | CaballosPosibles ], Caballos) :-
    diferentesCombinaciones(CaballosPosibles, Caballos).