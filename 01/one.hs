module Main where

import System.IO (readFile)

parse :: String -> [Int]
parse = map read . lines

main :: IO ()
main = do
  input <- readFile "input.txt"
  print $ sum (parse input)
