class Criatura {
    var vida
    const elemento

    method elemento() = elemento

    method reducirVida(cantidad) { vida = 0.max(vida - cantidad) }
}

class Incorporeo inherits Criatura {
    const defensa

    method recibirAtaque(ataque) { self.reducirVida( 1.max(ataque.danioCausado(self) - defensa) ) }
}

class Sincorazon inherits Criatura {
    method recibirAtaque(ataque) { self.reducirVida( ataque.danioCausado(self) * 0.9 ) }
}