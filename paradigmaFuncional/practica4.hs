{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Redundant bracket" #-}
sumaLista :: Num a => [a] -> a
sumaLista = sum

promedioFrecuenciaCardiaca :: (Fractional a, Foldable t) => t a -> a
promedioFrecuenciaCardiaca lista = sum lista / fromInteger (toInteger (length lista))

frecuenciaCardiacaMinuto :: [a] -> Int -> a
frecuenciaCardiacaMinuto lista = ((lista !!) . flip div 10)

frecuenciasHastaMomento :: [a] -> Int -> [a]
frecuenciasHastaMomento lista = (flip take lista . (+ 1) . flip div 10)

