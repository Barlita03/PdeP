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

    method recibirDosis(dosis) = enfermedades.forEach { enfermedad => enfermedad.atenuar(dosis * 15, self) }

    method curarse(enfermedad) = enfermedades.remove(enfermedad)

    method contraerEnfermedad(enfermedad) = enfermedades.add(enfermedad)
}

class Medico inherits Persona{
    method atender(persona, dosis) = persona.recibirDosis(dosis)

    method atenderse(dosis) = self.recibirDosis(dosis)
}

//------------------------------
//Enfermedades
//------------------------------

class Enfermedad {
    var celulasAmenazadas

    method esAgresiva(persona){}

    method atenuar(cantidadDeCelulas, persona) {
        celulasAmenazadas = (celulasAmenazadas - cantidadDeCelulas).max(0)

        if(celulasAmenazadas == 0) persona.curarse(self)
    }
}

class Infecciosa inherits Enfermedad {
    method aumentarTemperatura(persona) {
        persona.aumentarTemperatura(celulasAmenazadas / 1000)
        
    }
    
    method reproducirse() {
        celulasAmenazadas *= 2
    }

    override method esAgresiva(persona) = celulasAmenazadas > persona.cantidadDeCelulas() * 0.10
}

class Autoinmune inherits Enfermedad {
    var diasAmenazando

    method destruirCelulas(persona) {
        persona.disminuirCelulas(celulasAmenazadas)
        diasAmenazando += 1
    }

    override method esAgresiva(persona) = diasAmenazando > 30
}