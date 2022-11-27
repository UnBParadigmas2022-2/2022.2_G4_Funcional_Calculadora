module SquareRoot(squareRoot) where

import Data.Char()
import Parser(toList, getAfterNumber, getNumber)

-- Recursive implementation to calculate square root
calculateSquareRoot :: Int -> Int
calculateSquareRoot n = try n where
   try i | i * i > n = try (i - 1) 
         | i * i <= n = i

-- Wrap square root handling in one function
squareRoot :: ([Char], [Char]) -> [Char]
squareRoot (support, []) = support
squareRoot (support, str)
    | h == 'V'              = support ++ show(calculateSquareRoot(getNumber('_', t))) ++ squareRoot("", getAfterNumber(t))
    | otherwise             = squareRoot(support ++ toList(h), t)
    where h = head str
          t = tail str