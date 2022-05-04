module Matrix
  ( Matrix,
    transpose
  )
where


type Matrix = [[Int]]

data Success = Success

type Validator = Matrix -> Either String Success
type MatrixOperator = Matrix -> Matrix

transposeMatrix :: MatrixOperator
transposeMatrix ([]:_) = []
transposeMatrix x = (map head x) : transposeMatrix (map tail x)

validateMatrix :: Validator
validateMatrix (x:t) = case (any (< -109) x) || (any (>109) x) of
  True -> Left "wrong data"
  False -> validateMatrix t
validateMatrix [] = Right Success

validateSize :: Validator
validateSize x | (length x) > 0 = do
                  let m = length x
                      h:t = x in 
                      let n = length h
                          k = m*n in
                            if k>0 && k <= 105 && m <= 1000 
                                && n <= 1000 && n > 0  &&
                                all (==n) (map length t) then
                                  Right Success
                                else
                                  Left "wrong size"
                | (length x) == 0 = Left "wrong size"


reduce :: Either String Success -> Either String Success -> Either String Success
reduce (Right _) (Right _) = Right Success
reduce (Right _) (Left a) = Left a
reduce (Left a) (Right _) = Left a
reduce (Left a) (Left b) = Left (a ++ " and " ++ b)

genericMatrixOperator :: [Validator] -> MatrixOperator -> Matrix -> Either String Matrix
genericMatrixOperator val mo  m =  
  let validated = foldr (reduce) (Right Success) (map (\v -> v m) val) in
    case validated of
      Right Success -> Right (mo m)
      Left errmsg -> Left errmsg

transpose :: Matrix -> Either String Matrix
transpose = genericMatrixOperator [validateMatrix, validateSize] transposeMatrix
