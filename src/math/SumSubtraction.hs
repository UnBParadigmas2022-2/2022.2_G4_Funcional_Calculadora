module SumSubtraction(sumSubtraction) where

import Parser(getOperation, getAfterNumber)

-- Wrap simple operations handling in one function
sumSubtraction :: [Char] -> Int
sumSubtraction str = sumSubtractionOperation(getOperation('r', str))

-- Recursive function call to handle valid expression cases
sumSubtractionOperation :: (Int, [Char]) -> Int 
sumSubtractionOperation (num, []) = num
sumSubtractionOperation (num, str)
    | head(getAfterNumber(str)) == '-' && tail(getAfterNumber(str)) == []         = negate(num)
    | head(getAfterNumber(str)) == '+' && tail(getAfterNumber(str)) == []         = num
    | h == '+'                                                                    = sumSubtraction(t) + num
    | h == '-'                                                                    = sumSubtraction(t) - num
    | otherwise                                                                   = sumSubtractionOperation(num, t)
    where h = head str
          t = tail str