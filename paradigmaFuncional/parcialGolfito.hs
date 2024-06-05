--Modelo Inicial

data Jugador = UnJugador {
  nombre :: String,
  padre :: String,
  habilidad :: Habilidad
} deriving (Eq, Show)

data Habilidad = Habilidad {
  fuerzaJugador :: Int,
  precisionJugador :: Int
} deriving (Eq, Show)

-- Jugadores de ejemplo
bart = UnJugador "Bart" "Homero" (Habilidad 25 60)
todd = UnJugador "Todd" "Ned" (Habilidad 15 80)
rafa = UnJugador "Rafa" "Gorgory" (Habilidad 10 1)

data Tiro = UnTiro {
  velocidad :: Int,
  precision :: Int,
  altura :: Int
} deriving (Eq, Show)

type Puntos = Int

-- Funciones útiles
between n m x = elem x [n .. m]

maximoSegun f = foldl1 (mayorSegun f)

mayorSegun f a b
  | f a > f b = a
  | otherwise = b

----------------EJERCICIO1,a----------------

type Palo = Habilidad -> Tiro

putter :: Palo
putter habilidad = UnTiro {velocidad = 10, precision = ((*2) . precisionJugador) habilidad, altura = 0}

madera :: Palo
madera habilidad = UnTiro {velocidad = 100, precision = (flip div 2 . precisionJugador) habilidad, altura = 10}

hierro :: Int -> Palo
hierro n habilidad = UnTiro {velocidad = ((*n) . fuerzaJugador) habilidad, precision = (flip div n . precisionJugador) habilidad, altura = max (n-3) 0}

----------------EJERCICIO1,b----------------

palos :: [Palo]
palos = [putter, madera] ++ map hierro [1..10]

----------------EJERCICIO2----------------

golpe :: Palo -> Jugador -> Tiro
golpe unPalo = unPalo . habilidad

----------------EJERCICIO3----------------

tiroRetenido :: Tiro
tiroRetenido = UnTiro 0 0 0

--Tunel con rampita

precisionTunelConRampita :: Int
precisionTunelConRampita = 90

alturaTunelConRampita :: Int
alturaTunelConRampita = 0

--Laguna

velocidadLaguna :: Int
velocidadLaguna = 80

alturaMinLaguna :: Int
alturaMinLaguna = 1

alturaMaxLaguna :: Int
alturaMaxLaguna = 5

--Hoyo

velocidadMinHoyo :: Int
velocidadMinHoyo = 5

velocidadMaxHoyo :: Int
velocidadMaxHoyo = 20

alturaHoyo :: Int
alturaHoyo = 0

precisionHoyo :: Int
precisionHoyo = 95

--Funciones

data Obstaculo = UnObstaculo {
    puedeSuperar :: SuperaObstaculo,
    efectoTiro :: EfectoObstaculo
}

type SuperaObstaculo = Tiro -> Bool

superaTunelConRampita :: SuperaObstaculo
superaTunelConRampita unTiro = precision unTiro > precisionTunelConRampita && altura unTiro == alturaTunelConRampita

superaLaguna :: SuperaObstaculo
superaLaguna unTiro = velocidad unTiro > velocidadLaguna && altura unTiro > alturaMinLaguna && altura unTiro < alturaMaxLaguna

superaHoyo :: SuperaObstaculo
superaHoyo unTiro = precision unTiro > precisionHoyo && altura unTiro == alturaHoyo && velocidad unTiro > velocidadMinHoyo && velocidad unTiro < velocidadMaxHoyo

type EfectoObstaculo = Tiro -> Tiro

efectoTunelConRampita :: EfectoObstaculo
efectoTunelConRampita unTiro = unTiro { velocidad = velocidad unTiro * 2, precision = 100 }

efectoLaguna :: Int -> EfectoObstaculo
efectoLaguna largoLaguna unTiro = unTiro { altura = div (altura unTiro) largoLaguna }

efectoHoyo :: EfectoObstaculo
efectoHoyo unTiro = UnTiro 0 0 0

tunelConRampita :: Obstaculo
tunelConRampita = UnObstaculo { puedeSuperar = superaTunelConRampita, efectoTiro = efectoTunelConRampita }

laguna :: Int -> Obstaculo
laguna longitudLaguna = UnObstaculo { puedeSuperar = superaTunelConRampita, efectoTiro = efectoLaguna longitudLaguna }

hoyo :: Obstaculo
hoyo = UnObstaculo { puedeSuperar = superaTunelConRampita, efectoTiro = efectoHoyo }

realizarObstaculo :: Obstaculo -> Tiro -> Tiro
realizarObstaculo unObstaculo unTiro
    | puedeSuperar unObstaculo unTiro = efectoTiro unObstaculo unTiro
    | otherwise = tiroRetenido

----------------EJERCICIO4,a----------------

palosUtiles :: Jugador -> SuperaObstaculo -> [Palo]
palosUtiles unJugador unObstaculo = filter (unObstaculo . flip golpe unJugador) palos

elPaloSirve :: SuperaObstaculo -> Palo -> Jugador ->  Bool
elPaloSirve unObstaculo unPalo = unObstaculo . golpe unPalo

----------------EJERCICIO4,b----------------

obstaculosConsecutivos :: Tiro -> [Obstaculo] -> Int
obstaculosConsecutivos unTiro []  = 0
obstaculosConsecutivos unTiro (x:xs)
    | puedeSuperar x unTiro = 1 + obstaculosConsecutivos (efectoTiro x unTiro) xs 
    | otherwise =  0

----------------EJERCICIO4,c----------------

--golpe :: Palo -> Jugador -> Tiro
--filtrarConsecutivos :: [Obstaculo] -> Tiro -> Int

cuantosSupera :: Jugador -> [Obstaculo] -> Palo -> Int
cuantosSupera unJugador listaObstaculos unPalo = obstaculosConsecutivos (golpe unPalo unJugador) listaObstaculos

superaMas :: Jugador -> [Obstaculo] -> [Palo] -> Palo
superaMas unJugador listaObstaculos (x:xs)
    | cuantosSupera (head xs) > cuantosSupera x = head xs
    | otherwise = x

paloMasUtil :: Jugador -> [Obstaculo] -> Palo
paloMasUtil unJugador listaObstaculos = maximum (map (cuantosSupera unJugador listaObstaculos) palos)

--filtrarConsecutivos (golpe palo jugador) (head Obstaculo)
--(filtrarConsecutivos listaObstaculos . flip golpe jugador) palos

----------------EJERCICIO5----------------
