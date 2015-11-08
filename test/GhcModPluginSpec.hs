{-# LANGUAGE OverloadedStrings #-}
module GhcModPluginSpec where

-- import           Data.Aeson
import           Haskell.Ide.Engine.Monad
import           Haskell.Ide.Engine.PluginDescriptor
import           Haskell.Ide.GhcModPlugin

import qualified Data.Map as Map

import           Test.Hspec

-- ---------------------------------------------------------------------

main :: IO ()
main = hspec spec

spec :: Spec
spec = do
  describe "ghc-mod plugin" ghcmodSpec

-- -- |Used when running from ghci, and it sets the current directory to ./tests
-- tt :: IO ()
-- tt = do
--   cd ".."
--   hspec spec

-- ---------------------------------------------------------------------

ghcmodSpec :: Spec
ghcmodSpec = do
  describe "ghc-mod plugin commands" $ do
    it "runs the check command" $ do
      let req = IdeRequest "check" (Map.fromList [("file", ParamFile "./test/testdata/FileWithWarning.hs")])
      r <- runIdeM (IdeState Map.empty) (checkCmd req)
      (show r) `shouldBe` "IdeResponseOk (String \"test/testdata/FileWithWarning.hs:4:7:Not in scope: \\8216x\\8217\\n\")"
