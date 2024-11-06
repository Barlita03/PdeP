import nave.*

object troll {
    method votar() { nave.jugadorNoSospechoso().sumarVoto() }
}

object detective {
    method votar() { nave.jugadorMasSospechoso().sumarVoto() }
}

object materialista {
    method votar() { nave.jugadorHumilde().sumarVoto() }
}