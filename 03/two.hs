import qualified Data.Map.Strict as Map

data Claim = Claim
  { claimId :: Int
  , claimX  :: Int
  , claimY  :: Int
  , claimW  :: Int
  , claimH  :: Int
  } deriving (Show)

parseClaim :: String -> Claim
parseClaim s =
  let ws = words (map (\c -> if c `elem` "#@,:x" then ' ' else c) s)
      [cid, x, y, w, h] = map read ws
  in Claim cid x y w h

claimCoords :: Claim -> [(Int, Int)]
claimCoords c =
  [ (x, y)
  | x <- [claimX c .. claimX c + claimW c - 1]
  , y <- [claimY c .. claimY c + claimH c - 1]
  ]

solve :: [Claim] -> Int
solve claims =
  let fabric = foldl addClaim Map.empty claims
      noOverlap c = all (\coord -> Map.findWithDefault 0 coord fabric == 1) (claimCoords c)
  in claimId (head (filter noOverlap claims))
  where
    addClaim m c = foldl (\acc coord -> Map.insertWith (+) coord (1 :: Int) acc) m (claimCoords c)

main :: IO ()
main = do
  input <- readFile "input.txt"
  let claims = map parseClaim (filter (not . null) (lines input))
  print (solve claims)
