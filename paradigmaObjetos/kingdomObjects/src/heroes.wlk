import modos.*
import ataques.*
import llavesEspada.*

class Heroe {
    const fuerza
    var puntosDeMana
    var llaveEspada
    
    //ataques
    method atacarEnemigo(enemigo) { enemigo.recibirAtaque( new AtaqueFisico ( potencia = fuerza + llaveEspada.poderFisico() ) ) }

    method lanzarHechizo(hechizo, enemigo) {
        self.validarQueTieneSuficienteMana(hechizo)
        enemigo.recibirAtaque( new AtaqueMagico ( potencia = hechizo.potencia() * self.llaveEspada().poderMagico(), elemento = hechizo.elemento() ) ) //!Se tiene que poder mejorar
        self.gastarPuntosDeMana( hechizo.potencia() )
    }

    //llaveEspada
    method llaveEspada() = llaveEspada

    method equiparLlaveEspada(espadaNueva) { llaveEspada = espadaNueva }

    method esUtilEquipar(espadaNueva) = espadaNueva.poderFisico() > llaveEspada.poderFisico()

    method cuantoPotencialOfensivoLeAumenta(espadaNueva) = espadaNueva.poderFisico() - llaveEspada.poderFisico()

    //mana
    method puntosDeMana() = puntosDeMana

    method gastarPuntosDeMana(cuantos) { puntosDeMana = 0.max( puntosDeMana - cuantos ) }

    method tieneSuficienteMana(hechizo) = puntosDeMana >= hechizo.potencia()

    method validarQueTieneSuficienteMana(hechizo) {
        if( !self.tieneSuficienteMana(hechizo) )
            throw new Exception ( message = "No tiene suficiente mana para lanzar este hechizo" )
    }

    method estaAgotado() = puntosDeMana == 0

    //otros
    method descansar() { puntosDeMana = 30 }
}

//Creacion de heroes
const sora = new Heroe ( fuerza = 10, puntosDeMana = 8, llaveEspada = llaveDelReino )
const mickey = new Heroe ( fuerza = 5, puntosDeMana = 13, llaveEspada = explotadorEstelar )
const riku = new Heroe ( fuerza = 15, puntosDeMana = 4, llaveEspada = caminoAlAlba )

object ventus inherits Heroe ( fuerza = 8, puntosDeMana = 7, llaveEspada = brisaDescarada ) {
    override method atacarEnemigo(enemigo) { enemigo.recibirAtaque( new AtaqueFisico ( potencia = fuerza + llaveEspada.poderMagico() ) ) }

    override method lanzarHechizo(hechizo, enemigo) {
        self.validarQueTieneSuficienteMana(hechizo)
        enemigo.recibirAtaque( new AtaqueMagico ( potencia = hechizo.potencia() * self.llaveEspada().poderFisico(), elemento = hechizo.elemento() ) ) //!Se tiene que poder mejorar
        self.gastarPuntosDeMana( hechizo.potencia() )
    }
}

object roxas inherits Heroe ( fuerza = 5, puntosDeMana = 20, llaveEspada = llaveDelReino ) {
    var modo = tranquilo
    var contadorDeAtaquesFisicos = 0
    var contadorDeAtaquesMagicos = 0

    override method atacarEnemigo(enemigo) {
        enemigo.recibirAtaque( new AtaqueFisico ( potencia = (fuerza + llaveEspada.poderFisico()) * modo.multiplicadorFisico() ) )
        contadorDeAtaquesMagicos = 0
        contadorDeAtaquesFisicos += 1
        self.validarSiDebeCambiarDeModo()
    }

    override method lanzarHechizo(hechizo, enemigo) {
        self.validarQueTieneSuficienteMana(hechizo)
        enemigo.recibirAtaque( new AtaqueMagico ( potencia = hechizo.potencia() * self.llaveEspada().poderMagico() * modo.multiplicadorMagico(), elemento = hechizo.elemento() ) ) //!Se tiene que poder mejorar
        self.gastarPuntosDeMana( hechizo.potencia() )
        contadorDeAtaquesFisicos = 0
        contadorDeAtaquesMagicos += 1
        self.validarSiDebeCambiarDeModo()
    }

    //Cambios de modo
    method debeCambiarAModoValiente() = contadorDeAtaquesFisicos == 5

    method debeCambiarAModoSabio() = contadorDeAtaquesMagicos == 5

    method validarSiDebeCambiarDeModo() {
        if( self.debeCambiarAModoValiente() ){
            modo = valiente
        } else if ( self.debeCambiarAModoSabio() ) {
            modo = sabio
        }
    }
}