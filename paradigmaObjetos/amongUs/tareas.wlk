import nave.*

class Tarea {
    const herramientasNecesarias = []

    method herramientasNecesarias() = herramientasNecesarias

    method puedeRealizarTarea(jugador) = herramientasNecesarias.all { herramienta => jugador.mochila().contains(herramienta) }

    method verificarSiPuedeRealizarTarea(jugador) {
        if ( !self.puedeRealizarTarea(jugador) )
            throw new Exception ( message = "Le faltan herramientas" )
    }

    method realizarTarea(jugador) { 
        self.verificarSiPuedeRealizarTarea(jugador)
    }
}

class ArreglarTableroElectrico inherits Tarea {
    override method realizarTarea(jugador) {
        super(jugador)
        jugador.aumentarNivelDeSospecha(10)
    }
}

class SacarLaBasura inherits Tarea {
    override method realizarTarea(jugador) {
        super(jugador)
        jugador.disminuirNivelDeSospecha(4)
    }
}

class VentilarLaNave inherits Tarea {
    override method realizarTarea(jugador) {
        super(jugador)
        nave.aumentarNivelDeOxigeno(5)
    }
}