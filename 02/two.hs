commonChars :: String -> String -> String
commonChars a b = [x | (x, y) <- zip a b, x == y]

diffByOne :: String -> String -> Bool
diffByOne a b = length a - length (commonChars a b) == 1

findMatch :: [String] -> String
findMatch [] = error "no match found"
findMatch (x:xs) = case filter (diffByOne x) xs of
    (y:_) -> commonChars x y
    []    -> findMatch xs

main :: IO ()
main = do
    input <- lines <$> readFile "input.txt"
    putStrLn $ findMatch input
