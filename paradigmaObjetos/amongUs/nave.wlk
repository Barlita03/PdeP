object nave {
    const jugadores = []
    const tareas = []
    var votosEnBlanco = 0
    var nivelDeOxigeno = 100

    //jugadores
    method agregarJugador(jugador) { jugadores.add(jugador) }

    method quitarJugador(jugador) { jugadores.remove(jugador) }

    method unTripulante() = jugadores.find { jugador => jugador.rol() == "tripulante" }

    method jugadorNoSospechoso() = jugadores.find { jugador => jugador.estaVivo() && !jugador.esSospechoso() }

    method jugadorMasSospechoso() = jugadores.max { jugador => jugador.estaVivo() && jugador.nivelDeSospecha() }

    method jugadorHumilde() = jugadores.find { jugador => jugador.estaVivo() && jugador.mochilaVacia() }

    method jugadorMasVotado() = jugadores.max { jugador => jugador.votos() }

    method cantidadDeTripulantes() = jugadores.ocurrencesOf { jugador => jugador.estaVivo() && jugador.rol() == "tripulante" }
    
    method cantidadDeImpostores() = jugadores.ocurrencesOf { jugador => jugador.estaVivo() && jugador.rol() == "impostores" }

    method noHayMasImpostores() = self.cantidadDeImpostores() == 0

    method hayTantosImpostoresComoTripulantes() = self.cantidadDeTripulantes() == self.cantidadDeImpostores()

    method verificarSiNoHayMasImpostores() {
        if( self.noHayMasImpostores() )
            throw new Exception ( message = "Ganaron los tripulantes" )
    }

    method verificarhayTantosImpostoresComoTripulantes() {
        if( self.hayTantosImpostoresComoTripulantes() )
            throw new Exception ( message = "Ganaron los impostores" )
    }

    method unJugadorVivo() = jugadores.find { jugador => jugador.estaVivo() }

    method jugadoresVivos() = jugadores.filter { jugador => jugador.estaVivo() }

    //tareas
    method agregarTarea(tarea) { tareas.add(tarea) }

    method quitarTarea(tarea) { tareas.remove(tarea) }

    method tareaRealizada(tarea) {
        self.quitarTarea(tarea)
        self.verificarSiTodasLasTareasEstanRealizadas()
    }

    method todasLasTareasRealizadas() = tareas.isEmpty()

    method verificarSiTodasLasTareasEstanRealizadas() {
        if ( self.todasLasTareasRealizadas() )
            throw new Exception ( message = "Ganaron los tripulantes" )
    }

    //oxigeno
    method aumentarNivelDeOxigeno(cuanto) { nivelDeOxigeno += cuanto }

    method disminuirNivelDeOxigeno(cuanto) {
        nivelDeOxigeno -= cuanto
        self.verificarSiHayOxigeno()
    }

    method hayOxigeno() = nivelDeOxigeno > 0

    method verificarSiHayOxigeno() {
        if( !self.hayOxigeno() )
            throw new Exception ( message = "Ganaron los impostores" )
    }

    //items
    method alguienTiene(objeto) = jugadores.any { jugador => jugador.tiene(objeto) }

    //!reunionDeEmergencia (modificar)
    method reunionDeEmergencia() {
        self.jugadoresVivos().map { jugador => jugador.votar() }
        self.expulsarJugador()
        self.verificarSiNoHayMasImpostores()
        self.verificarhayTantosImpostoresComoTripulantes()
        self.reiniciarVotos()
    }

    method expulsarJugador() {
        const jugador = self.jugadorMasVotado()
        self.quitarJugador(jugador)
        jugador.morir()
    }

    method reiniciarVotos() {
        jugadores.anyOne { jugador => jugador.votos(0) }
        votosEnBlanco = 0
    }

    method sumarVoto() { votosEnBlanco += 1 }
}

//!hice distinto el impugnado
//!tiene sentido que los votos sean una lista en la nave con los jugadores, el mismo puede estar repetido tantas veces como sea necesario