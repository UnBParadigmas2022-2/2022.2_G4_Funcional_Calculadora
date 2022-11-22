module Operation(calculate) where

import Data.Char()
import Parser(toList, strToNumber, getNumber)

operation :: (Int, [Char]) -> Int
operation (num, []) = num
operation (num, str) 
    | h == '+'  = calculate(t) + num
    | h == '-'  = calculate(t) - num
    | otherwise = operation(num, t)
    where h = head str
          t = tail str

calculate :: [Char] -> Int
calculate str = result(str)

result :: ([Char]) -> Int
result ([]) = 0
result (str) = operation(strToNumber(reverse(getNumber(h, t))), t)
    where h = head str
          t = tail str