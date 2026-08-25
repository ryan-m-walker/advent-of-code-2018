-- | Parse a frequency shift such as "+12" or "-15". 'read' chokes on a
-- leading plus sign, so strip it off first.
parseShift :: String -> Int
parseShift ('+' : digits) = read digits
parseShift shift = read shift

parseShifts :: String -> [Int]
parseShifts = map parseShift . filter (not . null) . lines

-- | Sum every frequency shift to get the resulting frequency.
calc :: [Int] -> Int
calc = sum

main :: IO ()
main = do
  input <- readFile "input.txt"
  print (calc (parseShifts input))
