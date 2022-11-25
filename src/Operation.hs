module Operation(calculate) where

import Data.Char()
import Parser(toList, getNumber, getBeforeNumber)


-- Adiciona tudo o que está dentro dos parenteses
getContent :: ([Char], [Char]) -> [Char]
getContent (support, str)
    | h == ')'  = support
    | otherwise = getContent(support ++ toList(h), t)
    where h = head str
          t = tail str

-- Realiza a operação de dentro do parenteses
getParanthesesContent :: [Char] -> [Char]
getParanthesesContent str = show(basicOperation(getContent("", str)))
    
-- Pega o que está depois do parênteses
getAfterParentheses :: [Char] -> [Char]
getAfterParentheses str
    | h == ')' = t
    | otherwise = getAfterParentheses(t)
    where h = head str
          t = tail str

parentheses :: ([Char], [Char]) -> [Char]
parentheses (support, str)
    | h == '(' = support ++ getParanthesesContent(t) ++ getAfterParentheses(t)
    | otherwise = parentheses(support ++ toList(h), t)
    where h = head str
          t = tail str

exponential :: (Int, [Char]) -> [Char]
exponential (num, []) = reverse(show(num))
exponential (num, str)
    | h == '+' || h == '-' || h == '*' || h == '/' = reverse(show(num)) ++ toList(h) ++ exponential(getNumber(t), t)
    | h == 'ˆ' || h == '^'                         = exponential(getNumber(t) ^ num, t)
    | otherwise                                    = exponential(num, t)
    where h = head str
          t = tail str

calculateSquareRoot :: Int -> Int
calculateSquareRoot n = try n where
   try i | i * i > n = try (i - 1) 
         | i * i <= n = i

squareRoot :: ([Char], [Char]) -> [Char]
squareRoot (support, []) = support
squareRoot (support, str)
    | h == 'V'              = support ++ show(calculateSquareRoot(strToNumber(getNumber(head t, tail t)))) ++ getBeforeNumber("", t)
    | otherwise             = squareRoot(support ++ toList(h), t)
    where h = head str
          t = tail str

multiplication :: (Int, [Char]) -> [Char]
multiplication (num, []) = reverse(show(num))
multiplication (num, str)
    | h == '+' || h == '-'  = reverse(show(num)) ++ toList(h) ++ multiplication(getNumber(t), t)
    | h == '*'              = multiplication(getNumber(t) * num, t)
    | h == '/'              = multiplication(getNumber(t) `div` num, t)
    | otherwise             = multiplication(num, t)
    where h = head str
          t = tail str

operation :: (Int, [Char]) -> Int
operation (num, []) = num
operation (num, str) 
    | h == '+'  = basicOperation(t) + num
    | h == '-'  = basicOperation(t) - num
    | otherwise = operation(num, t)
    where h = head str
          t = tail str

getOperation :: ([Char]) -> (Int, [Char])
getOperation str = (getNumber(str), t)
    where t = tail str 

calculate :: [Char] -> Int
calculate str = result(reverse str)

basicOperation :: ([Char]) -> Int
basicOperation ([])  = 0
basicOperation str = operation(getOperation(multiplication(getOperation(exponential(getNumber(str),t)))))
    where t  = tail str

result :: ([Char]) -> Int
result ([])  = 0
result (str) = basicOperation(parentheses("", str))
