module Operation(basicOperation) where

import Data.Char()
import Parser(getOperation)

import Exponential(exponential)
import SquareRoot(squareRoot)
import Multiplication(multiplication)
import SumSubtraction(sumSubtraction)

basicOperation :: ([Char]) -> Int
basicOperation ([])  = 0
basicOperation str = sumSubtraction(reverse(
                        multiplication(reverse(
                            exponential(reverse(str))
                        ))
                    ))
