//------------------------------
//Personas
//------------------------------

class Persona {
    const enfermedades = []
    var temperatura
    var cantidadDeCelulas
    const grupoSanguineo
    const factorSanguineo

    method grupoSanguineo() = grupoSanguineo
    
    method factorSanguineo() = factorSanguineo

    method cantidadDeCelulas() = cantidadDeCelulas

    method aumentarCelulas(cuanto) { cantidadDeCelulas += cuanto }

    method aumentarTemperatura(cuanto) {
        temperatura = 45.min(temperatura + cuanto)
    }

    method disminuirCelulas(cuantas) {
        cantidadDeCelulas = 0.max(cantidadDeCelulas - cuantas)
    }

    method enComa() = temperatura == 45

    method recibirDosis(unaDosis) {
        enfermedades.forEach { enfermedad => enfermedad.atenuarse(unaDosis * 15) }
        self.removerEnfermedadesCuradas()
    }

    method removerEnfermedadesCuradas() = enfermedades.removeAllSuchThat { enfermedad => enfermedad.celulasAmenazadas() == 0 }

    method contraerEnfermedad(unaEnfermedad) { 
        enfermedades.add(unaEnfermedad) 
    }
    
    method curarse(enfermedad) = enfermedades.remove(enfermedad)

    method celulasSuficientes(cantidadADonar) = cantidadADonar.between(500, cantidadDeCelulas / 4)

    method esCompatible(persona) = grupoSanguineo.puedeDonar(persona)

    method puedeDonar(persona, cantidadADonar) {
        self.verificarCantidadDeCelulas(cantidadADonar)
        self.verificarCompatibilidad(persona)
    }

    method donarA(persona, cantidadADonar) {
        self.verificarCantidadDeCelulas(cantidadADonar)
        cantidadDeCelulas -= cantidadADonar
        persona.aumentarCelulas(cantidadADonar)
    }

    method verificarCantidadDeCelulas(cantidadADonar) {
        if(!self.celulasSuficientes(cantidadADonar))
            throw new Exception( message = "El donante no tiene celulas suficientes")
    }

    method verificarCompatibilidad(persona) {
        if(!self.esCompatible(persona))
            throw new Exception( message = "El donante no es compatible")
    }
}

object o {
    method puedeRecibir(grupo) = grupo == self
    
    method puedeDonar(persona) = persona.grupoSanguineo().puedeRecibir(self)
}

object a {
    method puedeRecibir(grupo) = grupo == o || grupo == self

    method puedeDonar(persona) = persona.grupoSanguineo().puedeRecibir(self)
}

object b {
    method puedeRecibir(grupo) = grupo == o || grupo == self

    method puedeDonar(persona) = persona.grupoSanguineo().puedeRecibir(self)
}

object ab {
    method puedeRecibir(grupo) = true

    method puedeDonar(persona) = persona.grupoSanguineo().puedeRecibir(self)
}

class Medico inherits Persona {
    const dosis

    method atenderA(unaPersona) = unaPersona.recibirDosis(dosis)

    override method contraerEnfermedad(unaEnfermedad) {
        super(unaEnfermedad)
        self.atenderA(self)
    }
}

class JefeDeDepartamento inherits Medico {
    const subordinados = []

    override method atenderA(unaPersona) = subordinados.anyone().atenderA(unaPersona)
}

//------------------------------
//Enfermedades
//------------------------------

class Enfermedad {
    var celulasAmenazadas

    method celulasAmenazadas() = celulasAmenazadas

    method esAgresiva(persona)

    method afectar(persona)

    method atenuarse(cantidadDeCelulas) {
        celulasAmenazadas = 0.max(celulasAmenazadas - cantidadDeCelulas)
    }
}

class Infecciosa inherits Enfermedad {
    override method afectar(persona) {
        persona.aumentarTemperatura(celulasAmenazadas / 1000)
    }
    
    override method esAgresiva(persona) = celulasAmenazadas > persona.cantidadDeCelulas() * 0.10
    
    method reproducirse() {
        celulasAmenazadas *= 2
    }
}

class Autoinmune inherits Enfermedad {
    var cantidadDeVecesQueAfecto

    override method afectar(persona) {
        persona.disminuirCelulas(celulasAmenazadas)
        cantidadDeVecesQueAfecto += 1
    }

    override method esAgresiva(persona) = cantidadDeVecesQueAfecto > 30
}