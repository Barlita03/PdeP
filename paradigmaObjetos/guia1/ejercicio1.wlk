object pepita {
    var posicion = 0
    var energia = 100

    method volar(kilometros){
        energia -= 10 + kilometros
    }

    method comer(gramos){
        energia += 4 * gramos
    }

    method ir(lugar){
        if(self.puedeIr(lugar) == "si"){
            self.volar(self.distancia(lugar))
            posicion = lugar.kilometro()
        }
    }

    method puedeIr(lugar){
        if(energia >= self.distancia(lugar) + 10){
            return "si"
        } else{
            return "no"
        }
    }

    method distancia(lugar){
        return (lugar.kilometro() - posicion).abs()
    }
}

object casaDeMati {
    method kilometro() = 100
}

object casaDeJuli {
    method kilometro() = 50
}

object casaDeBarla {
    method kilometro() = 10
}