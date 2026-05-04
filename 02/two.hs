diffCount :: String -> String -> Int
diffCount a b = length (filter id (zipWith (/=) a b))

commonChars :: String -> String -> String
commonChars a b = [x | (x, y) <- zip a b, x == y]

findMatch :: [String] -> String
findMatch [] = error "no match found"
findMatch (x:xs) =
    case filter (\y -> diffCount x y == 1) xs of
        (y:_) -> commonChars x y
        []    -> findMatch xs

main :: IO ()
main = do
    input <- readFile "input.txt"
    let ids = lines input
    putStrLn (findMatch ids)
