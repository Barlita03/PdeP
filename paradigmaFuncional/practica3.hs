--Ejercicio1
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use uncurry" #-}
{-# HLINT ignore "Use bimap" #-}
fst3 :: (a, b, c) -> a
fst3 (a, _, _) = a

snd3 :: (a, b, c) -> b
snd3 (_, b, _) = b

trd3 :: (a, b, c) -> c
trd3 (_, _, c) = c

--Ejercicio2
aplicar :: (Int -> a, Int -> b) -> Int -> (a, b)
aplicar tupla entero = (fst tupla entero, snd tupla entero)

--Ejercicio3
cuentaBizarra :: (Ord a, Num a) => (a, a) -> a
cuentaBizarra tupla
    | fst tupla >= snd tupla = fst tupla + snd tupla
    | (snd tupla - fst tupla) > 10 = snd tupla - fst tupla
    | otherwise = fst tupla * snd tupla

--Ejercicio4, a
esNotaBochazo :: (Ord a, Num a) => a -> Bool
esNotaBochazo = (6 <=)

--Ejercicio4, b
aprobo :: (Ord a, Num a) => (a, a) -> Bool
aprobo tupla = esNotaBochazo (fst tupla) && esNotaBochazo (snd tupla)

--Ejercicio4, c
promociono :: (Ord a, Num a) => (a, a) -> Bool
promociono tupla = ((fst tupla >= 7) && (snd tupla >= 7)) && (fst tupla + snd tupla) >= 15

--Ejercicio4, d
aproboPrimerParcial :: (Ord a, Num a) => (a, a) -> Bool
aproboPrimerParcial = esNotaBochazo . fst

aproboSegundoParcial :: (Ord a, Num a) => (a, a) -> Bool
aproboSegundoParcial = esNotaBochazo . snd

--Ejercicio5, a
notasFinales :: (Ord a, Num a) => ((a, a), (a, a)) -> (a, a)
notasFinales tupla = (max ((fst . fst) tupla) ((fst . snd) tupla), max ((snd . fst) tupla) ((snd . snd) tupla))

--Ejercicio5, b
recursa :: (Ord a, Num a) => ((a, a), (a, a)) -> Bool
recursa = not . aprobo . notasFinales

--Ejercicio5, c
recuperoPrimerParcial :: (Ord a, Num a) => ((a, a), (a, a)) -> Bool
recuperoPrimerParcial = (> -1) . fst . snd

recuperoSegundoParcial :: (Ord a, Num a) => ((a, a), (a, a)) -> Bool
recuperoSegundoParcial = (> -1) . snd . snd

--Ejercicio5, d
recuperoDeGusto :: (Ord a, Num a) => ((a, a), (a, a)) -> Bool
recuperoDeGusto tupla = promociono (fst tupla) && (recuperoPrimerParcial tupla || recuperoSegundoParcial tupla)

--Ejercicio6
esMayorDeEdad :: (Ord a, Num a) => ([Char], a) -> Bool
esMayorDeEdad (_, edad) = edad >= 21

--Ejercicio7
calcular :: (Int, Int) -> (Int, Int)
calcular (primero, segundo)
    | even primero && odd segundo = (primero * 2, segundo + 1)
    | even primero = (primero * 2, segundo)
    | odd segundo = (primero, segundo + 1)
    | otherwise = (primero, segundo)