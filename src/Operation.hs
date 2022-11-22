module Operation(calcula) where

import Data.Char()
import Parser(toList, strToNumber, getNumber)

operacao :: (Int, [Char]) -> Int
operacao (_, []) = 0
operacao (num, str) 
    | h == '+'  = num + calcula t
    | h == '-'  = num - calcula t
    | otherwise = operacao(num, t)
    where h = head str
          t = tail str

calcula :: [Char] -> Int
calcula str = resultado(str)

resultado :: ([Char]) -> Int
resultado ([]) = 0
resultado (str) = operacao(strToNumber(getNumber(h, t)), str)
    where h = head str
          t = tail str