module Main (main) where

import Operation(calculate)

main :: IO ()
main = print(calculate(reverse "200 - 2 + 4"))