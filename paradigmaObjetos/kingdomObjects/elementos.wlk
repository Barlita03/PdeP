class Elemento {
    const elementoRival

    method plusDeElemento(elemento) {
        if( self.esElMismoElemento(elemento) ) {
            return 0
        } else if( self.esElementoRival(elemento) ){
            return 2
        } else {
            return 1
        }
    }

    method esElementoRival(elemento) = elemento == elementoRival

    method esElMismoElemento(elemento) = elemento == self
}

const fuego = new Elemento ( elementoRival = hielo )
const hielo = new Elemento ( elementoRival = fuego )
const luz = new Elemento ( elementoRival = oscuridad )
const oscuridad = new Elemento ( elementoRival = luz )