import Distribution.Simple.Utils (xargs)
take2 :: Int -> [a] -> [a]
take2 numero (x:xs)
    |numero == 0 = []
    |otherwise = x : take2 (numero - 1) xs

drop2 :: Int -> [a] -> [a]
drop2 numero lista
    |numero == 0 = []
    |otherwise = last lista : take2 (numero - 1) xss