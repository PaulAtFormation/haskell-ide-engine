{-# LANGUAGE OverloadedStrings #-}
module HaRePluginSpec where

-- import           Control.Logging
-- import           Data.Aeson
import           Haskell.Ide.Engine.Monad
import           Haskell.Ide.Engine.PluginDescriptor
import           Haskell.Ide.HaRePlugin

import qualified Data.Map as Map

import           Test.Hspec

-- ---------------------------------------------------------------------

main :: IO ()
main = hspec spec

spec :: Spec
spec = do
  describe "hare plugin" hareSpec

-- -- |Used when running from ghci, and it sets the current directory to ./tests
-- tt :: IO ()
-- tt = do
--   cd ".."
--   hspec spec

-- ---------------------------------------------------------------------

hareSpec :: Spec
hareSpec = do
  describe "hare plugin commands" $ do
    it "renames" $ do
      let req = IdeRequest "rename" (Map.fromList [("file",ParamFile "./test/testdata/HaReRename.hs"),("start_pos",ParamPos (5,1)),("name",ParamText "foolong")])
      r <- runIdeM (IdeState Map.empty) (renameCmd req)
      (show r) `shouldBe` "IdeResponseOk (Array [String \"test/testdata/HaReRename.hs\"])"

    it "returns an error for invalid rename" $ do
      let req = IdeRequest "rename" (Map.fromList [("file",ParamFile "./test/testdata/HaReRename.hs"),("start_pos",ParamPos (15,1)),("name",ParamText "foolong")])
      r <- runIdeM (IdeState Map.empty) (renameCmd req)
      (show r) `shouldBe` "IdeResponseFail (String \"Invalid cursor position!\")"