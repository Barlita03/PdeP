import elementos.*

class Criatura {
    var vida
    const raza
    const elemento

    method vida() = vida

    method raza() = raza

    method elemento() = elemento

    method reducirVida(cantidad) { vida = 0.max(vida - cantidad) }

    method recibirAtaque(ataque) { self.reducirVida( ataque.danioCausado(self) ) }
}

//Razas
class Incorporeo{
    const defensa

    method manejarDanioFisico(potencia) = 1.max(potencia - defensa)
}

class Sincorazon{
    method manejarDanioFisico(potencia) = 1.max( potencia * 0.9 )
}

//Creacion de criaturas
const umbrio = new Criatura ( vida = 50, elemento = hielo, raza = new Incorporeo ( defensa = 10 ) )
const nocturnoRojo = new Criatura ( vida = 80, elemento = fuego, raza = new Sincorazon () )
const rapsodiaAzul = new Criatura ( vida = 80, elemento = hielo, raza = new Sincorazon () )
