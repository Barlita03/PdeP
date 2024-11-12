class Capital {
    var cantidadDeDefensores
    const factorDeRiqueza

    method cantidadDeDefensores() = cantidadDeDefensores

    method botin(grupo) = self.defensoresDerrotados(grupo) * factorDeRiqueza

    method valeLaPena(grupo) = self.botin(grupo) >= grupo.size() * 3

    method serInvadida(grupo) {
        self.entregarOroVikingos(grupo)
        self.asesinarDefensores(grupo)
    }

    method entregarOroVikingos(grupo) {
        grupo.forEach { vikingo => vikingo.adquirirOro( self.botin(grupo) / grupo.size() ) }
    }

    method asesinarDefensores(grupo) { 
        cantidadDeDefensores -= grupo.size()
        grupo.forEach { vikingo => vikingo.tomarVida() }
    }

    method defensoresDerrotados(grupo) = cantidadDeDefensores.min(grupo.size())
}

class Aldea {
    var cantidadDeCrucifijos

    method cantidadDeCrucifijos() = cantidadDeCrucifijos

    method valeLaPena(grupo) = cantidadDeCrucifijos >= 15

    method serInvadida(grupo) {
        self.entregarOroVikingos(grupo)
        self.robarCrucifijos()
    }

    method robarCrucifijos() { cantidadDeCrucifijos = 0 }

    method entregarOroVikingos(grupo) {
        grupo.forEach { vikingo => vikingo.adquirirOro( cantidadDeCrucifijos / grupo.size() ) }
    }
}

class AldeaAmurallada inherits Aldea {
    const cantidadMinimaDeVikingos

    override method valeLaPena(grupo) = super(grupo) && cantidadMinimaDeVikingos >= grupo.size()
}