module Main where

import Prelude
import Control.Monad.Eff (Eff)

import Halogen as H
import Halogen.Util (awaitBody, runHalogenAff)

import Page (ui)

main :: Eff (H.HalogenEffects ()) Unit
main = runHalogenAff $ awaitBody >>= H.runUI ui unit

