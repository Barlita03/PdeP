padreDe(abe, abbie).
padreDe(abe, homero).
padreDe(abe, herbert).
padreDe(clancy, marge).
padreDe(clancy, patty).
padreDe(clancy, selma).
padreDe(homero, bart).
padreDe(homero, hugo).
padreDe(homero, lisa).
padreDe(homero, maggie).

madreDe(edwina, abbie).
madreDe(mona, homero).
madreDe(gaby, herbert).
madreDe(jacqueline, marge).
madreDe(jacqueline, patty).
madreDe(jacqueline, selma).
madreDe(marge, bart).
madreDe(marge, hugo).
madreDe(marge, lisa).
madreDe(marge, maggie).
madreDe(selma, ling).

%-------------EJERCICIO1-------------

tieneHijo(Alguien):-padreDe(Alguien, _).

tieneHijo(Alguien):-madreDe(Alguien, _).

hermanos(UnaPersona, OtraPersona):-
    padreDe(UnPadre, UnaPersona),
    padreDe(UnPadre, OtraPersona),
    madreDe(UnaMadre, UnaPersona),
    madreDe(UnaMadre, OtraPersona).

mediosHermanos(UnaPersona, OtraPersona):-
    padreDe(UnPadre, UnaPersona),
    padreDe(UnPadre, OtraPersona).

mediosHermanos(UnaPersona, OtraPersona):-
    madreDe(UnaMadre, UnaPersona),
    madreDe(UnaMadre, OtraPersona).

%-------------EJERCICIO2-------------

esHijo(Hijo, Padre):-
    padreDe(Padre, Hijo).

descendiente(Descendiente, Persona):-
    padreDe(Persona, Descendiente).

descendiente(Descendiente, Persona):-
    padreDe(Persona, Alguien),
    descendiente(Descendiente, Alguien).

descendiente(Descendiente, Persona):-
    madreDe(Persona, Descendiente).

descendiente(Descendiente, Persona):-
    madreDe(Persona, Alguien),
    descendiente(Descendiente, Alguien).