module Operation(calcula) where

import Data.Char()
import Parser(toList, strToNumber, getNumber)

operacao :: (Int, [Char]) -> Int
operacao (num, []) = num
operacao (num, str) 
    | h == '+'  = calcula(t) + num
    | h == '-'  = calcula(t) - num
    | otherwise = operacao(num, t)
    where h = head str
          t = tail str

calcula :: [Char] -> Int
calcula str = resultado(str)

resultado :: ([Char]) -> Int
resultado ([]) = 0
resultado (str) = operacao(strToNumber(reverse(getNumber(h, t))), t)
    where h = head str
          t = tail str