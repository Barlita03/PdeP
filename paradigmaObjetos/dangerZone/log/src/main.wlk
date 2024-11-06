class Empleado {
    var vida
    var puesto
    const habilidades = #{}

    method perderVida(cuanto) { vida.max(0, vida - cuanto) }

    method estaVivo() = vida > 0

    method incapacitado() = vida < puesto.vidaCritica()

    method tieneHabilidad(habilidad) = habilidades.contains(habilidad)

    method puedeUsarHabilidad(habilidad) = !self.incapacitado() && self.tieneHabilidad(habilidad)

    method adquirirHabilidad(habilidad) = habilidades.add(habilidad)

    method puedeHacerMision(mision) = mision.tieneTodasLasHabilidades(self)

    method cumplirMision(mision) {
        self.perderVida(mision.peligrosidad())
        if( self.estaVivo() )
            puesto.obtenerRecompensaDeMision(mision, self)
    }

    method cumplirMisionEnGrupo(mision) {
        self.perderVida(mision.peligrosidad() / 3)
        if( self.estaVivo() )
            puesto.obtenerRecompensaDeMision(mision, self)
    }

    method cambiarPuesto(puestoActual) { puesto = puestoActual }
}

object espia {
    method vidaCritica() = 15

    method obtenerRecompensaDeMision(mision, empleado) { mision.enseniarEmpleado(empleado) }
}

class Oficinista {
    var cantidadDeEstrellas

    method adquirirEstrella() { cantidadDeEstrellas += 1 }

    method vidaCritica() = 40 - 5 * cantidadDeEstrellas

    method obtenerRecompensaDeMision(mision, empleado) { 
        cantidadDeEstrellas += 1
        if( cantidadDeEstrellas == 3 )
            empleado.cambiarPuesto(espia)
    }
}

class Jefe inherits Empleado {
    const subordinados = []

    override method puedeUsarHabilidad(habilidad) = super(habilidad) || self.algunoDeSusSubordinadosPuedeUsarHabilidad(habilidad)

    method algunoDeSusSubordinadosPuedeUsarHabilidad(habilidad) = subordinados.any { subordinado => subordinado.tienerHabilidad(habilidad) }
}

class Equipo {
    const integrantes = []

    method puedeHacerMision(mision) = integrantes.any { empleado => empleado.puedeHacerMision(mision) }
}

class Mision {
    const habilidadesRequeridas = []
    const peligrosidad

    method peligrosidad() = peligrosidad

    method tieneTodasLasHabilidades(empleado) = habilidadesRequeridas.all { habilidad => empleado.puedeUsarHabilidad(habilidad) }

    method enseniarEmpleado(empleado) { habilidadesRequeridas.forEach { habilidad => empleado.adquirirHabilidad(habilidad) } }
}