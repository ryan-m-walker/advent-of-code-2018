import Data.List (group, sort)

hasCount :: Int -> String -> Bool
hasCount n = any ((== n) . length) . group . sort

checksum :: [String] -> Int
checksum ids = count 2 * count 3
  where count n = length $ filter (hasCount n) ids

main :: IO ()
main = do
    input <- lines <$> readFile "input.txt"
    print $ checksum input
