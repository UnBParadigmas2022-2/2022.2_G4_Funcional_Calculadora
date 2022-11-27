module Exponential(exponential) where

import Data.Char()
import Parser(getOperation, getNumber, toList)
import Handler(isNextEmpty)

-- Wrap exponential handling in one function
exponential :: [Char] -> [Char]
exponential str = exponentialOperation(getOperation('r', str))

-- Recursive function call to handle valid expression cases
exponentialOperation :: (Int, [Char]) -> [Char]
exponentialOperation (num, []) = reverse(show num)
exponentialOperation (num, str)
    | (h == '-' || h == '+') && t == []            = rNum ++ toList(h)
    | h == '-' && head t == '*'                    = rNum ++ toList(h) ++ toList(head t) ++ exponential(tail t)
    | h == '+' && head t == '*'                    = rNum ++ toList(h) ++ toList(head t) ++ exponential(tail t)
    | h == '+' || h == '-' || h == '*' || h == '/' = rNum ++ toList(h) ++ exponential(t)
    | h == 'V' && isNextEmpty(t)                   = rNum ++ toList(h)
    | h == 'V'                                     = rNum ++ toList(h) ++ toList(head t) ++ exponential(tail t)
    | h == 'ˆ' || h == '^'                         = exponentialOperation(getNumber('r', t) ^ num, t)
    | otherwise                                    = exponentialOperation(num, t)
    where h = head str
          t = tail str
          rNum = reverse(show num)