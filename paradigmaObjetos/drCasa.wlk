//------------------------------
//Personas
//------------------------------

class Persona {
    const enfermedades = []
    var temperatura
    var cantidadDeCelulas

    method cantidadDeCelulas() = cantidadDeCelulas

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