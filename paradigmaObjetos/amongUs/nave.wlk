object nave {
    const jugadores = []
    const tareas = []
    var nivelDeOxigeno = 100

    //jugadores
    method agregarJugador(jugador) { jugadores.add(jugador) }

    method quitarJugador(jugador) {
        jugadores.remove(jugador)
        jugador.morir()    
    }

    method unTripulante() = jugadores.find { jugador => jugador.rol() == "tripulante" }

    method jugadorNoSospechoso() = jugadores.find { jugador => !jugador.esSospechoso() }

    method jugadorMasSospechoso() = jugadores.max { jugador => jugador.nivelDeSospecha() }

    method jugadorHumilde() = jugadores.find { jugador => jugador.mochilaVacia() }

    method jugadorMasVotado() = jugadores.max { jugador => jugador.votos() }

    method cantidadDeTripulantes() = jugadores.ocurrencesOf { jugador => jugador.rol() == "tripulante" }
    
    method cantidadDeImpostores() = jugadores.ocurrencesOf { jugador => jugador.rol() == "impostores" }

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

    //reunionDeEmergencia
    method reunionDeEmergencia() {
        self.jugadoresVivos().map { jugador => jugador.votar() }
        self.expulsarJugador()
        self.verificarSiNoHayMasImpostores()
        self.verificarhayTantosImpostoresComoTripulantes()
        self.reiniciarVotos()
    }

    method expulsarJugador() {
        self.quitarJugador(self.jugadorMasVotado())
    }

    method reiniciarVotos() {
        jugadores.anyOne { jugador => jugador.votos(0) }
    }
}

//!hice distinto el impugnado