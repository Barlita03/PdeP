--Ejercicio1
siguiente :: Num a => a -> a
siguiente numero = numero + 1

--Ejercicio2
mitad :: Fractional a => a -> a
mitad numero = numero / 2

--Ejercicio3
inversa :: Fractional a => a -> a
inversa numero = 1 / numero

--Ejercicio4
triple :: Num a => a -> a
triple numero = numero * 3

--Ejercicio5
esNumeroPositivo :: (Ord a, Num a) => a -> Bool
esNumeroPositivo numero = numero > 5

--Ejercicio6
esMultiploDe :: Integral a => a -> a -> Bool
esMultiploDe numero1 numero2 = ( ( == 0 ) . mod numero1 ) numero2

--Ejercicio7
esBisiesto :: Integral b => b -> Bool
esBisiesto anio = (flip esMultiploDe 400) anio || ( ( ( ( flip esMultiploDe 4 ) anio ) && ) . not . flip esMultiploDe 100 ) anio

--Ejercicio8
inversaRaizCuadrado :: Floating c => c -> c
inversaRaizCuadrado numero = ( inversa . sqrt ) numero

--Ejercicio9
incrementMCuadradoN :: Num c => c -> c -> c
incrementMCuadradoN numero1 numero2 = ( ( numero2 + ) . ( ^ 2 ) ) numero1

--Ejercicio10
esResultadoPar :: (Integral b, Integral a) => b -> a -> Bool
esResultadoPar numero1 numero2 = ( even . ( numero1 ^ ) ) numero2