module Operation(calculate) where

import Data.Char()
import Parser(toList, getNumber)


exponential :: (Int, [Char]) -> [Char]
exponential (num, []) = reverse(show(num))
exponential (num, str)
    | h == '+' || h == '-' || h == '*' || h == '/' = reverse(show(num)) ++ toList(h) ++ exponential(getNumber(head t, tail t), t)
    | h == '^'                                     = exponential(getNumber(head t, tail t) ^ num, t)
    | otherwise                                    = exponential(num, t)
    where h = head str
          t = tail str

multiplication :: (Int, [Char]) -> [Char]
multiplication (num, []) = reverse(show(num))
multiplication (num, str)
    | h == '+' || h == '-'  = reverse(show(num)) ++ toList(h) ++ multiplication(getNumber(head t, tail t), t)
    | h == '*'              = multiplication(getNumber(head t, tail t) * num, t)
    | h == '/'              = multiplication(getNumber(head t, tail t) `div` num, t)
    | otherwise             = multiplication(num, t)
    where h = head str
          t = tail str

operation :: (Int, [Char]) -> Int
operation (num, []) = num
operation (num, str) 
    | h == '+'  = result(t) + num
    | h == '-'  = result(t) - num
    | otherwise = operation(num, t)
    where h = head str
          t = tail str

getOperation :: ([Char]) -> (Int, [Char])
getOperation str = (getNumber(h,t), t)
    where h = head str
          t = tail str 

calculate :: [Char] -> Int
calculate str = result(reverse str)

result :: ([Char]) -> Int
result ([])  = 0
result (str) = operation(getOperation(multiplication(getNumber(h, t), exponential(getNumber(h, t),t))))
    where h  = head str
          t  = tail str