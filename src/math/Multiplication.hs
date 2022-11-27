module Multiplication(multiplication) where

import Data.Char()
import Parser(toList, getNumber, getOperation, )

-- Wrap multiplication handling in one function
multiplication :: [Char] -> [Char]
multiplication str
    | h == '+' || h == '-' = toList(h) ++ multiplicationOperation(getOperation('_', t))
    | otherwise            = multiplicationOperation(getOperation('_', str))
    where h = head str
          t = tail str

-- Recursive function call to handle valid expression cases
multiplicationOperation :: (Int, [Char]) -> [Char]
multiplicationOperation (num, []) = show(num)
multiplicationOperation (num, str)
    | h == '+' || h == '-'              = show(num) ++ toList(h) ++ multiplicationOperation(getOperation('_', t))
    | h == '*' && head t == '-'         = multiplicationOperation(negate(num *     getNumber('_', tail t)), tail t)
    | h == '*' && head t == '+'         = multiplicationOperation(       num *     getNumber('_', tail t), tail t)
    | h == '*'                          = multiplicationOperation(       num *     getNumber('_', t), t)
    | h == '/'                          = multiplicationOperation(       num `div` getNumber('_', t), t)
    | otherwise                         = multiplicationOperation(num, t)
    where h = head str
          t = tail str