import elementos.*

class AtaqueFisico {
    const potencia

    method danioCausado(enemigo) = enemigo.raza().manejarDanioFisico(potencia)
}

class AtaqueMagico {
    const potencia
    const elemento

    method potencia() = potencia
    
    method elemento() = elemento

    method danioCausado(enemigo) = potencia * elemento.plusDelElemento( enemigo.elemento() )
}

const piro = new AtaqueMagico ( potencia = 5, elemento = fuego )
const chispa = new AtaqueMagico ( potencia = 1, elemento = luz )
const ragnarok = new AtaqueMagico ( potencia = 30, elemento = luz )