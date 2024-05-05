{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use sum" #-}
{-# HLINT ignore "Use product" #-}
{-# HLINT ignore "Use maximum" #-}
{-# HLINT ignore "Use minimum" #-}
import Data.Array (listArray)
fst3 :: (a, b, c) -> a
fst3 (a, _, _) = a

snd3 :: (a, b, c) -> b
snd3 (_, b, _) = b

trd3 :: (a, b, c) -> c
trd3 (_, _, c) = c

esMultiploDe :: Integral a => a -> a -> Bool
esMultiploDe numero1 numero2 = ( ( == 0 ) . mod numero1 ) numero2


data Jugadores = Jugadores{
    habilidad :: [Int],
    goles :: Int
} deriving (Show)

jugador :: Jugadores
jugador = Jugadores {
    habilidad = [1,3,5,7,9,11],
    goles = 0
}

----------------LISTAS----------------

--Ejercicio1
sumaLista :: Num a => [a] -> a
sumaLista = sum

--Ejercicio2
--A)
promedioFrecuenciaCardiaca :: (Fractional a) => [a] -> a
promedioFrecuenciaCardiaca lista = sum lista / fromInteger (toInteger (length lista))

--B)
frecuenciaCardiacaMinuto :: [a] -> Int -> a
frecuenciaCardiacaMinuto lista = ((lista !!) . flip div 10)

--C)
frecuenciasHastaMomento :: [a] -> Int -> [a]
frecuenciasHastaMomento lista = (flip take lista . (+ 1) . flip div 10)

--Ejercicio3
esCapicua :: Eq a => [[a]] -> Bool
esCapicua lista = ((concat lista ==) . concat . reverse. map reverse) lista

--Ejercicio4(POR AHORA SALTEADO)
duracionLlamadas :: ((String, [Integer]), (String, [Integer]))
duracionLlamadas = (("horarioReducido",[20,10,25,15]),("horarioNormal",[10,5,8,2,9,10]))

--sumaMinutos :: (Eq a1, Num a1, Num c, Foldable t1, Foldable t2) => ((a2, t1 c), (a3, t2 c)) -> a1 -> c
sumaMinutos :: (Num a, Eq a) => ((String, [a]), (String, [a])) -> a -> a
sumaMinutos duracionLlamadas horario
    | horario == 1 = (sum . snd . fst) duracionLlamadas
    | horario == 2 = (sum . snd . snd) duracionLlamadas

cuandoHabloMas :: (Num a, Ord a) => ((String, [a]), (String, [a])) -> String
cuandoHabloMas duracionLlamadas
    | sumaMinutos duracionLlamadas 1 > sumaMinutos duracionLlamadas 2 = (fst . fst) duracionLlamadas
    | otherwise = (fst . snd) duracionLlamadas

----------------ORDEN SUPERIOR----------------

--Ejercicio1
existAny :: (a -> Bool) -> (a, a, a) -> Bool
existAny funcion tupla = funcion (fst3 tupla) || funcion (snd3 tupla) || funcion (trd3 tupla)

--Ejercicio2
mejor :: Ord a => (a -> a) -> (a-> a) -> a -> a
mejor funcion1 funcion2 elemento = max (funcion1 elemento) (funcion2 elemento)

--Ejercicio3
aplicarPar :: (a -> b) -> (a, a) -> (b, b)
aplicarPar funcion tupla = (funcion (fst tupla), funcion (snd tupla))

--Ejercicio4
parDeFns :: (a -> b) -> (a -> c) -> a -> (b, c)
parDeFns funcion1 funcion2 elemento = (funcion1 elemento, funcion2 elemento)

----------------ORDEN SUPERIOR + LISTAS----------------

--Ejercicio1
esMultiploDeAlguno :: Int -> [Int] -> Bool
esMultiploDeAlguno numero = any (esMultiploDe numero)

--Ejercicio2
promedios :: Fractional a => [[a]] -> [a]
promedios = map promedioFrecuenciaCardiaca

--Ejercicio3
promedioSinAplazos :: (Fractional a, Ord a) => [[a]] -> [a]
promedioSinAplazos = filter (> 4) . map promedioFrecuenciaCardiaca

--Ejercicio4
mejoresNotas :: (Fractional a, Ord a) => [[a]] -> [a]
mejoresNotas = map maximum

--Ejercicio5(Mi resolucion)
aproboMio :: (Fractional a, Ord a) => [a] -> Bool
aproboMio = not . any (<6)

--Ejercicio5(Resolucion propuesta)
aprobo :: (Fractional a, Ord a) => [a] -> Bool
aprobo = (>= 6) . minimum

--Ejercicio6
aprobaron :: (Fractional a, Ord a) => [[a]] -> [[a]]
aprobaron = filter aprobo

--Ejercicio7
divisores :: Int -> [Int]
divisores numero = filter ((== 0). mod numero) [1..numero]

--Ejercicio8
exists :: (a -> Bool) -> [a] -> Bool
exists = any

--Ejercicio9
hayAlgunNegativo :: (Num a, Ord a) => [a] -> b -> Bool
hayAlgunNegativo lista algo = any (< 0) lista

--Ejercicio10
aplicarFunciones :: [(a -> b)] -> a -> [b]
aplicarFunciones lista elemento = map ($ elemento) lista

--Ejercicio11
sumaF :: Num a => [(a -> a)] -> a -> a
sumaF lista elemento = sum (aplicarFunciones lista elemento)

--Ejercicio12
subirHabilidad :: Int -> [Int] -> [Int]
subirHabilidad numero = map (\x -> min (x + numero) 12)

--Ejercicio13, intro
flimitada :: (Num a, Ord a) => (a -> a) -> a -> a
flimitada funcion numero
    |  aplico > 12 = 12
    |  aplico < 0 = 0
    |  otherwise = aplico
    where aplico = funcion $ numero

--Ejercicio13, a
cambiarHabilidad :: (Num a, Ord a) => (a -> a) -> [a] -> [a]
cambiarHabilidad funcion = map (\x -> flimitada funcion x)

--Ejercicio13, b
llevarA4 :: (Num a, Ord a) => [a] -> [a]
llevarA4 = map (\x -> max x 4)

--Ejercicio14
{-
takeWhile toma todos los elementos de una lista hasta que alguno haga la condicion falsa.
Por ejemplo: Si la condicion es (>3) y la lista es [1,2,3,2,1,4], va a devolver todos los elementos que esten por delante del 3 ya que este
incumple con la condicion.

takeWhile (>3) [1,2,3,2,1,4] devuelve [1,2]
-}

--Ejercicio15, a
primerosPares :: [Int] -> [Int]
primerosPares = takeWhile even

--Ejercicio15, b
primerosDivisores :: Int -> [Int] -> [Int]
primerosDivisores numero = takeWhile (\x -> mod numero x == 0)

--Ejercicio15, c
primerosNoDivisores :: Int -> [Int] -> [Int]
primerosNoDivisores numero = takeWhile (\x -> not (mod numero x == 0))

--Ejercicio16
huboMesMejor :: [Int] -> [Int] -> Int -> Bool
huboMesMejor listaIngresos listaEgresos numero = any (>= numero) (zipWith (-) listaIngresos listaEgresos)

--Ejercicio17, a
crecimientoAnual :: Int -> Int
crecimientoAnual edad
    | edad < 10 = 24 - (edad * 2)
    | comparo 15 = 4
    | comparo 17 = 2
    | comparo 19 = 1
    | otherwise = 0
    where comparo = (edad <=)

--Ejercicio17, b
crecimientoEntreEdades :: Int -> Int -> Int
crecimientoEntreEdades edad1 edad2 = sum (map crecimientoAnual [edad1..edad2])

--Ejercicio17, c
alturasEnUnAnio :: Int -> [Int] -> [Int]
alturasEnUnAnio edad = map (\x -> x + crecimientoAnual edad)

--Ejercicio17, d
alturaEnEdades :: Int -> Int -> [Int] -> [Int]
alturaEnEdades altura edad = map (\x -> altura + crecimientoEntreEdades edad x)

--Ejercicio18, a
lluviasDeEnero :: [Int]
lluviasDeEnero = [0,2,5,1,34,2,0,21,0,0,0,5,9,18,4,0]

acumulador :: [[Int]]
acumulador = []

rachasLLuvia :: [Int] -> [[Int]]
rachasLLuvia lista
    | null lista = acumulador
    | head lista == 0 = recursivo
    | dropWhile (/= 0) lista /= [] = (takeWhile (/=0) lista : acumulador) ++ recursivo
    | otherwise = lista : acumulador
    where recursivo = (rachasLLuvia . tail . dropWhile (/= 0)) lista

--Ejercicio18, b
mayorRachaDeLLuvias :: [Int] -> Int
mayorRachaDeLLuvias = maximum . map length . rachasLLuvia

--Ejercicio19
sumarConFold :: [Int] -> Int
sumarConFold = foldl (+) 0

--Ejercicio20
productoria :: [Int] -> Int
productoria = foldl1 (*)

--Ejercicio21
dispersionMayor :: [Int] -> Int
dispersionMayor = foldr1 max

dispersionMenor :: [Int] -> Int
dispersionMenor = foldr1 min