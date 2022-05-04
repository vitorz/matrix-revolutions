module Main where

import qualified Matrix
import Web.Scotty
import Network.HTTP.Types (status422)
import Data.Text.Lazy
import Data.Aeson
import qualified Data.Text.Lazy.Encoding as T

main :: IO ()
main = do
  
  -- Run the scotty web app on port 8080
  scotty 8080 $ do
    -- Listen for POST requests on the "/transpose" endpoint
    post "/transpose" $
      do
        transposeMatrixReq <- jsonData :: ActionM Matrix.Matrix
        let result = Matrix.transpose transposeMatrixReq in
          case result of
            Right matrixTransposed -> Web.Scotty.json matrixTransposed
            Left errmsg -> Web.Scotty.raiseStatus status422 (T.decodeUtf8 . encode $ errmsg)
            

