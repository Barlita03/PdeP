class Elemento {
    const debilidad

    method plusDelElemento(elemento) {
        if( self.esElMismoElemento(elemento) ) {
            return 0
        } else if( self.esDebilidad(elemento) ){
            return 2
        } else {
            return 1
        }
    }

    method esDebilidad(elemento) = elemento == debilidad

    method esElMismoElemento(elemento) = elemento == self
}

object fuego inherits Elemento ( debilidad = hielo ) {}
object hielo inherits Elemento ( debilidad = fuego ) {}
object luz inherits Elemento ( debilidad = oscuridad ) {}
object oscuridad inherits Elemento ( debilidad = luz ) {}