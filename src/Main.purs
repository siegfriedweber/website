module Main where

import Prelude
import Control.Monad.Eff (Eff)
import Halogen as H
import Halogen.HTML.Indexed as HH
import Halogen.Util (awaitBody, runHalogenAff)

type State = Unit
data Query a = Query a

ui :: forall g. H.Component State Query g
ui = H.component { render, eval }
  where
    render :: State -> H.ComponentHTML Query
    render = const $ HH.p_ [ HH.text "Hallo!" ]

    eval :: Query ~> H.ComponentDSL State Query g
    eval (Query next) = pure next

main :: Eff (H.HalogenEffects ()) Unit
main = runHalogenAff $ awaitBody >>= H.runUI ui unit

