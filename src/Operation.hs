module Operation(basicOperation) where

import Data.Char()
import Parser(getOperation, getArrayWithoutSequenceOfPlusLess)

import Exponential(exponential)
import SquareRoot(squareRoot)
import Multiplication(multiplication)
import SumSubtraction(sumSubtraction)

basicOperation :: ([Char]) -> Int
basicOperation ([])  = 0
basicOperation str = sumSubtraction(getArrayWithoutSequenceOfPlusLess("", reverse(
                        multiplication(
                            squareRoot("", reverse(
                                exponential(reverse(str))
                            ))
                        )
                    )))
