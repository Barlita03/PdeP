object jarl {
    method puedeSubirAExpedicion(vikingo) {
        if( vikingo.cantidadDeArmas() == 0 ) {
            return true
        } else {
            throw new Exception ( message = "Este vikingo no puede participar de la expedicion" )
        }
    }

    method escalar(vikingo) {
        vikingo.ascenderAKarl()
    }
}

object karl {
    method puedeSubirAExpedicion(vikingo) = true

    method escalar(vikingo) { vikingo.ascenderAThrall() }
}

object thrall {
    method puedeSubirAExpedicion(vikingo) = true

    method escalar(vikingo) {}
}