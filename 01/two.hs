import qualified Data.Set as Set

-- | Parse a frequency shift such as "+12" or "-15". 'read' chokes on a
-- leading plus sign, so strip it off first.
parseShift :: String -> Int
parseShift ('+' : digits) = read digits
parseShift shift = read shift

parseShifts :: String -> [Int]
parseShifts = map parseShift . filter (not . null) . lines

-- | Find the first frequency that is reached twice. The shifts are cycled
-- endlessly and 'scanl' gives us the lazy list of running totals, so we just
-- walk it until we hit a total we have already seen.
calc :: [Int] -> Int
calc shifts = go (scanl (+) 0 (cycle shifts)) Set.empty
  where
    go (total : remaining) seen
      | total `Set.member` seen = total
      | otherwise = go remaining (Set.insert total seen)
    go [] _ = error "unreachable: the list of shifts is cycled endlessly"

main :: IO ()
main = do
  input <- readFile "input.txt"
  putStrLn ("FOUND: " ++ show (calc (parseShifts input)))
