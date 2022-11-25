module SumSubtraction(sumSubtraction) where

import Parser(getOperation)

sumSubtraction :: [Char] -> Int
sumSubtraction str = sumSubtractionOperation(getOperation('r', str))

sumSubtractionOperation :: (Int, [Char]) -> Int 
sumSubtractionOperation (num, []) = num
sumSubtractionOperation (num, str) 
    | h == '+'  = sumSubtraction(t) + num
    | h == '-'  = sumSubtraction(t) - num
    | otherwise = sumSubtractionOperation(num, t)
    where h = head str
          t = tail str