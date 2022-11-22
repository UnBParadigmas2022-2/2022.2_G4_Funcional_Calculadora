module Operation(calculate) where

import Data.Char()
import Parser(toList, strToNumber, getNumber)

multiplication :: (Int, [Char]) -> [Char]
multiplication (num, []) = reverse(show(num))
multiplication (num, str)
    | h == '+' || h == '-'  = reverse(show(num)) ++ toList(h) ++ multiplication(strToNumber(reverse(getNumber(head t, tail t))), t)
    | h == '*'              = multiplication(strToNumber(reverse(getNumber(head t, tail t))) * num, t)
    | h == '/'              = multiplication(strToNumber(reverse(getNumber(head t, tail t))) `div` num, t)
    | otherwise             = multiplication(num, t)
    where h = head str
          t = tail str

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
result (str) = operation(strToNumber(reverse(getNumber(h, t))), multiplication(strToNumber(reverse(getNumber(h, t))), t))
    where h = head str
          t = tail str