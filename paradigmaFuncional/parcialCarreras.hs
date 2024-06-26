import Data.ByteString (find)
------------EJERCICIO1------------

data Auto = UnAuto {
    color :: String,
    velocidad :: Int,
    distanciaRecorrida :: Int
}

type Carrera = [Auto]

sonDistintos :: Auto -> Auto -> Bool
sonDistintos auto1 auto2 = color auto1 /= color auto2

distanciaEntreAutos :: Auto -> Auto -> Int
distanciaEntreAutos auto1 auto2 = abs (distanciaRecorrida auto1 - distanciaRecorrida auto2)

estaCerca :: Auto -> Auto -> Bool
estaCerca auto1 auto2 = sonDistintos auto1 auto2 && distanciaEntreAutos auto1 auto2 > 10

leGana :: Auto -> Auto -> Bool
leGana auto1 auto2 = distanciaRecorrida auto1 > distanciaRecorrida auto2

vaGanando :: Auto -> Carrera -> Bool
vaGanando auto = all (leGana auto)

vaTranquilo :: Auto -> Carrera -> Bool
vaTranquilo auto carrera = not (all (estaCerca auto) carrera) && vaGanando auto carrera

puesto :: Auto -> Carrera -> Int
puesto auto carrera = (+1) . length . filter (leGana auto) $ carrera

------------EJERCICIO2------------

modificarDistancia :: Int -> Auto -> Auto
modificarDistancia distancia auto = auto { distanciaRecorrida = distanciaRecorrida auto + distancia }

correr :: Int -> Auto -> Auto
correr tiempo auto = modificarDistancia (velocidad auto * tiempo) auto

alterarVelocidad :: (Int -> Int) -> Auto -> Auto
alterarVelocidad modificador auto = auto { velocidad = modificador (velocidad auto) }

modificadorBajar :: Int -> Int -> Int
modificadorBajar cuanto velocidad = max 0 (velocidad - cuanto)

bajarVelocidad :: Int -> Auto -> Auto
bajarVelocidad cuanto = alterarVelocidad (modificadorBajar cuanto)

------------EJERCICIO3------------

afectarALosQueCumplen :: (a -> Bool) -> (a -> a) -> [a] -> [a]
afectarALosQueCumplen criterio efecto lista = (map efecto . filter criterio) lista ++ filter (not.criterio) lista

terremoto :: Auto -> Carrera -> Carrera
terremoto auto = afectarALosQueCumplen (estaCerca auto) (bajarVelocidad 50)

miguelitos :: Int -> Auto -> Carrera -> Carrera
miguelitos velocidad auto = afectarALosQueCumplen (leGana auto) (bajarVelocidad velocidad)

esElMismo :: Auto -> Auto -> Bool
esElMismo auto = (color auto  ==) . color

modificadorMultiplicar :: Int -> Int -> Int
modificadorMultiplicar cuanto velocidad = velocidad * cuanto

multiplicarVelocidad :: Int -> Auto -> Auto
multiplicarVelocidad cuanto = alterarVelocidad (modificadorMultiplicar cuanto)

jetPack :: Int -> Auto -> Carrera -> Carrera
jetPack tiempo auto carrera = afectarALosQueCumplen (esElMismo auto) (correr tiempo) . map (multiplicarVelocidad 2) $ carrera

------------EJERCICIO4------------

type Color = String

type PowerUp = (Auto -> Carrera -> Carrera)

simularCarrera :: Carrera -> [Carrera -> Carrera] -> [(Int, Color)]
simularCarrera carrera powerUps = armarTablaDePosiciones carreraFinal carreraFinal 
    where carreraFinal = foldl (\x y -> y x) carrera powerUps

armarTablaDePosiciones :: Carrera -> Carrera -> [(Int, Color)]
armarTablaDePosiciones  (x:xs) carrera
    | null xs = [tupla]
    | otherwise = tupla : armarTablaDePosiciones carrera xs
    where tupla = (puesto x carrera, color x)

correnTodos :: Int -> Carrera -> Carrera
correnTodos cuanto = map (correr cuanto)

esElColor :: Color -> Auto -> Bool
esElColor unColor = (unColor ==) . color

buscarPorColor :: Color -> Carrera -> Auto
buscarPorColor color carrera = head (filter (esElColor color) carrera)

usarPowerUp :: PowerUp -> Color -> Carrera -> Carrera
usarPowerUp powerUp color carrera = powerUp (buscarPorColor color carrera) carrera

rojo :: Auto
rojo = UnAuto {
    color = "rojo",
    velocidad = 120,
    distanciaRecorrida = 0
}

blanco :: Auto
blanco = UnAuto {
    color = "blanco",
    velocidad = 120,
    distanciaRecorrida = 0
}

azul :: Auto
azul = UnAuto {
    color = "azul",
    velocidad = 120,
    distanciaRecorrida = 0
}

negro :: Auto
negro = UnAuto {
    color = "negro",
    velocidad = 120,
    distanciaRecorrida = 0
}

eventos :: [Carrera -> Carrera]
eventos = [correnTodos 30, jetPack 3 azul, terremoto blanco, correnTodos 40, miguelitos 20 blanco, jetPack 6 negro, correnTodos 10]

competidores :: Carrera
competidores = [rojo, blanco, azul, negro]