% BASE DE CONOCIMIENTO

% juego(Nombre, Precio, Tipo).
% juego(Nombre, Precio, accion).
% juego(Nombre, Precio, rol(CantidadUsuarios)).
% juego(Nombre, Precio, puzzle(CantidadNiveles, Dificultad)).

% estaEnOferta(Juego, PorcentajeDescuento).

% usuarioPosee(Nombre, Juego).
% usuarioPlaneaAdquirir(Nombre, Juego, Tipo).
% usuarioPlaneaAdquirir(Nombre, Juego, propio).
% usuarioPlaneaAdquirir(Nombre, Juego, regalo(OtroUsuario)).

% PREDICADOS

% cuantoSale(Juego, Precio).
cuantoSale(Juego, Precio):-
  juego(Juego, PrecioSinDescuento, _),
  estaEnOferta(Juego, PorcentajeDescuento),
  Precio is PrecioSinDescuento * (100 - PorcentajeDescuento).

cuantoSale(Juego, Precio):-
  juego(Juego, Precio, _),
  not(estaEnOferta(Juego, _)).

% tieneUnBuenDescuento(Juego).
tieneUnBuenDescuento(Juego):-
  estaEnOferta(Juego, PorcentajeDescuento),
  PorcentajeDescuento => 50.

% esPopular(Juego).
esPopular(minecraft).
esPopular(counterStrike).

esPopular(Juego):-
  juego(Juego, _, Tipo)
  popularidadSegunTipo(Tipo).

% popularidadSegunTipo(Tipo).
popularidadSegunTipo(accion).

popularidadSegunTipo(rol(CantidadUsuarios)):-
  CantidadUsuarios > 1000000.

popularidadSegunTipo(puzzle(25, _)).

popularidadSegunTipo(puzzle(_, facil)).

% esAdictoALosDescuentos(Usuario).
esAdictoALosDescuentos(Usuario):-
  usuario(Usuario),
  forall(usuarioPlaneaAdquirir(Usuario, Juego, _), tieneUnBuenDescuento(Juego)).

usuario(Usuario):-
  usuarioPlaneaAdquirir(Usuario, _, _).
usuario(Usuario):-
  usuarioPosee(Usuario, _).

% esFanaticoDeUnGenero(Usuario, Genero).
esFanaticoDeUnGenero(Usuario, Genero):-
  usuarioConJuegoDeUnGenero(Usuario, UnJuego, Genero)
  usuarioConJuegoDeUnGenero(Usuario, OtroJuego, Genero)
  UnJuego /= OtroJuego.

usuarioConJuegoDeUnGenero(Usuario, Juego, Genero):-
  usuarioPosee(Usuario, Juego),
  juegoEsDeEseGenero(Juego, Genero).

juegoEsDeEseGenero(Juego, accion):-
  juego(Juego, _, accion).

juegoEsDeEseGenero(Juego, rol):-
  juego(Juego, _, rol(_)).

juegoEsDeEseGenero(Juego, puzzle):-
  juego(Juego, _, puzzle(_, _)).

% esMonotematico(Usuario, Genero).
esMonotematico(Usuario, Genero):-
  usuario(Usuario),
  forall(usuarioPosee(Usuario, Juego), juegoEsDeEseGenero(Juego, Genero)).

% sonBuenosAmigos(UnUsuario, OtroUsuario).
sonBuenosAmigos(UnUsuario, OtroUsuario):-
  leRegalaJuegoPopular(UnUsuario, OtroUsuario),
  leRegalaJuegoPopular(OtroUsuario, UnUsuario).

leRegalaJuegoPopular(UnUsuario, OtroUsuario):-
  usuarioPlaneaAdquirir(UnUsuario, Juego, regalo(OtroUsuario)),
  esPopular(Juego).

% cuantoGastara(Usuario, TipoDeCompra, Gasto).
cuantoGastara(Usuario, futurasCompras, Gasto):-
  cuantoGastaraParaFuturasCompras(Usuario, Gasto).

cuantoGastara(Usuario, regalo, Gasto):-
  cuantoGastaraParaRegalos(Usuario, Gasto).

cuantoGastara(Usuario, ambas, Gasto):-
  cuantoGastaraParaFuturasCompras(Usuario, GastoCompras),
  cuantoGastaraParaRegalos(Usuario, GastoRegalos),
  Gasto is GastoCompras + GastoRegalos.

cuantoGastaraParaFuturasCompras(Usuario, Gasto):-
  usuario(Usuario),
  findall(CostoJuego, (usuarioPlaneaAdquirir(Usuario, Juego, propio)), cuantoSale(Juego, CostoJuego), Costos),
  sumlist(Costos, Gasto).

cuantoGastaraParaRegalos(Usuario, Gasto):-
  usuario(Usuario),
  findall(CostoJuego, (usuarioPlaneaAdquirir(Usuario, Juego, regalo(_))), cuantoSale(Juego, CostoJuego), Costos),
  sumlist(Costos, Gasto).