module File.EnvWriter where

import qualified Data.ByteString        as B
import           Data.ByteString.Base64
import qualified Data.ByteString.Char8  as C
import           System.Environment

writeBase64EnvToFile :: String -> FilePath -> IO ()
writeBase64EnvToFile envName path = do
  maybeEnv <- lookupEnv envName
  maybe (return ()) write maybeEnv
  where
    write env = either (const $ return ()) (B.writeFile path) (decode (C.pack env))
