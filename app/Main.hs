module Main (main) where

import Operation(calculate)

main :: IO ()
main = print(calculate(reverse "3 * 4 + 1"))