module Data.SL (module X, SL(..)) where

import GHC.Generics as X (Generic(..))
import Data.ByteString.Lazy as B (writeFile, readFile)
import Data.Aeson as X (FromJSON(..), ToJSON(..), encode, eitherDecode)
import Text.Printf (printf)

class (FromJSON a, ToJSON a) => SL a where

   save :: a -> FilePath -> IO ()
   save a path = B.writeFile path (encode a)

   load :: FilePath -> IO a
   load path = do
      result <- eitherDecode <$> B.readFile path
      case result of
         Left msg -> error $ printf "Error when reading the file \"%s\":\n%s" path msg
         Right vl -> return vl

