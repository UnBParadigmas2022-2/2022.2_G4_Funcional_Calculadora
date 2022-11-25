module Multiplication(multiplication) where

import Data.Char()
import Parser(toList, getNumber, getOperation)

multiplication :: [Char] -> [Char]
multiplication str = multiplicationOperation(getOperation('_', str))

multiplicationOperation :: (Int, [Char]) -> [Char]
multiplicationOperation (num, []) = show(num)
multiplicationOperation (num, str)
    | h == '+' || h == '-' = show(num) ++ toList(h) ++ multiplicationOperation(getOperation('_', t))
    | h == '*'             = multiplicationOperation(getNumber('_', t) * num, t)
    | h == '/'             = multiplicationOperation(getNumber('_', t) `div` num, t)
    | otherwise            = multiplicationOperation(num, t)
    where h = head str
          t = tail str