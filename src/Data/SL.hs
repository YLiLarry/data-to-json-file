module Data.SL (module X, SL(..)) where

import GHC.Generics as X (Generic(..))
import Data.ByteString.Lazy as B (writeFile, readFile)
import Data.Aeson as X (FromJSON(..), ToJSON(..), encode, eitherDecode)
import Text.Printf (printf)
import Control.Monad.Trans

class (FromJSON a, ToJSON a) => SL a where

   save :: (MonadIO m) => a -> FilePath -> m ()
   save a path = liftIO $ B.writeFile path (encode a)

   load :: (MonadIO m) => FilePath -> m a
   load path = liftIO $ do
      result <- eitherDecode <$> B.readFile path
      case result of
         Left msg -> error $ printf "Error when reading the file \"%s\":\n%s" path msg
         Right vl -> return vl

