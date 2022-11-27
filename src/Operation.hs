module Operation(basicOperation) where

import Data.Char()
import Parser(getArrayWithoutSequenceOfPlusLess)

import Exponential(exponential)
import SquareRoot(squareRoot)
import Multiplication(multiplication)
import SumSubtraction(sumSubtraction)

-- Core function to the system. Used to wrap all mathematical recursive calls in one function.
basicOperation :: ([Char]) -> Int
basicOperation ([])  = 0
basicOperation str = sumSubtraction(getArrayWithoutSequenceOfPlusLess("", reverse(
                        multiplication(
                            squareRoot("", reverse(
                                exponential(reverse(str))
                            ))
                        )
                    )))
