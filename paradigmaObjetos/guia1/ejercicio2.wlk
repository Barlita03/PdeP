object tom {
    var energia = 100
    
    method velocidad() = 5 + energia / 10

    method comer(unRaton){
        energia += 12 + unRaton.peso()
    }

    method correr(metros){ //Los metros corridos me los dan en segundos
        energia -= 0.5 * metros
    }

    method distanciaConTiempo(segundos) = self.velocidad() * segundos

    /*
    method meConvieneComerUnRatonA(unRaton, unaDistancia){
        if()
    }
    */
}

object jerry {
    method peso() = 500
}