import nave.*

class Sabotaje {
    method sabotear(jugador) { jugador.aumentarNivelDeSospecha(5) }
}

class ReducirOxigeno inherits Sabotaje {
    override method sabotear(jugador) { 
        super(jugador)
        if( !nave.alguienTiene( "tuboDeOxigeno" ) )
            nave.disminuirNivelDeOxigeno(10)
    }
}

class ImpugnarJugador inherits Sabotaje {
    override method sabotear(jugador) {
        super(jugador)
        nave.unTripulante().impugnar()
    }
}