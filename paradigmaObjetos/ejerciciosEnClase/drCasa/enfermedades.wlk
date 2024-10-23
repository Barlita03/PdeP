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
    var cantidadDeVecesQueAfecto = 0

    override method afectar(persona) {
        persona.disminuirCelulas(celulasAmenazadas)
        cantidadDeVecesQueAfecto += 1
    }

    override method esAgresiva(persona) = cantidadDeVecesQueAfecto > 30
}

object muerte inherits Enfermedad (celulasAmenazadas = 0) {
    override method celulasAmenazadas() = false
    
    override method esAgresiva(persona) = true

    override method afectar(persona) {
        persona.morir()
    }

    override method atenuarse(cantidadDeCelulas) {}
}