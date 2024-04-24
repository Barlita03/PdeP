--Ejercicio1
fst3 :: (a, b, c) -> a
fst3 (a, _, _) = a

snd3 :: (a, b, c) -> b
snd3 (_, b, _) = b

trd3 :: (a, b, c) -> c
trd3 (_, _, c) = c

--Ejercicio2
aplicar :: (Int -> a, Int -> b) -> Int -> (a, b)
aplicar tupla entero = (fst tupla entero, snd tupla entero)

