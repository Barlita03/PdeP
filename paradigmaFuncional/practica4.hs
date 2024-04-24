----------------LISTAS----------------

--Ejercicio1
sumaLista :: Num a => [a] -> a
sumaLista = sum

--Ejercicio2
--A)
promedioFrecuenciaCardiaca :: (Fractional a, Foldable t) => t a -> a
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
