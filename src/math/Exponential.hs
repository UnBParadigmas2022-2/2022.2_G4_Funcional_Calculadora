module Exponential(exponential) where

import Data.Char()
import Parser(getOperation, getNumber, toList)

exponential :: [Char] -> [Char]
exponential str = exponentialOperation(getOperation('r', str))

isNextEmpty :: [Char] -> Bool
isNextEmpty [] = True
isNextEmpty _ = False

exponentialOperation :: (Int, [Char]) -> [Char]
exponentialOperation (num, []) = reverse(show(num))
exponentialOperation (num, str)
    | (h == '-' || h == '+') && t == []            = reverse(show(num)) ++ toList(h)
    | h == '-' && head t == '*'                    = reverse(show(num)) ++ toList(h) ++ toList(head t) ++ exponential(tail t)
    | h == '+' && head t == '*'                    = reverse(show(num)) ++ toList(h) ++ toList(head t) ++ exponential(tail t)
    | h == '+' || h == '-' || h == '*' || h == '/' = reverse(show(num)) ++ toList(h) ++ exponential(t)
    | h == 'V' && isNextEmpty(t)                   = reverse(show(num)) ++ toList(h)
    | h == 'V'                                     = reverse(show(num)) ++ toList(h) ++ toList(head t) ++ exponential(tail t)
    | h == 'ˆ' || h == '^'                         = exponentialOperation(getNumber('r', t) ^ num, t)
    | otherwise                                    = exponentialOperation(num, t)
    where h = head str
          t = tail str