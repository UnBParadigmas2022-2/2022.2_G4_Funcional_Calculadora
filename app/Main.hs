module Main (main) where

import Operation(calculate)

main :: IO ()
main = print(calculate("2 ^ 3 * 1 + 1"))
