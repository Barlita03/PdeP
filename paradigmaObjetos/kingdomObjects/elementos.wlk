object fuego {
    method plusDeElemento(elemento) {
        if( elemento == self ) {
            return 0
        } else if( elemento == hielo ){
            return 2
        } else {
            return 1
        }
    }
}

object hielo {
    method plusDeElemento(elemento) {
        if( elemento == self ) {
            return 0
        } else if( elemento == fuego ){
            return 2
        } else {
            return 1
        }
    }
}

object luz {
    method plusDeElemento(elemento) {
        if( elemento == self ) {
            return 0
        } else if( elemento == oscuridad ){
            return 2
        } else {
            return 1
        }
    }
}

object oscuridad {
    method plusDeElemento(elemento) {
        if( elemento == self ) {
            return 0
        } else if( elemento == luz ){
            return 2
        } else {
            return 1
        }
    }
}