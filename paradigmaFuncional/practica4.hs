import Control.Monad (ap)
fst3 :: (a, b, c) -> a
fst3 (a, _, _) = a

snd3 :: (a, b, c) -> b
snd3 (_, b, _) = b

trd3 :: (a, b, c) -> c
trd3 (_, _, c) = c

esMultiploDe :: Integral a => a -> a -> Bool
esMultiploDe numero1 numero2 = ( ( == 0 ) . mod numero1 ) numero2

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
