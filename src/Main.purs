module Main where

import Prelude
import Control.Monad.Eff (Eff)
import Data.Maybe (Maybe(Nothing))

import Halogen (component)
import Halogen.Aff (HalogenEffects, awaitBody, runHalogenAff)
import Halogen.HTML (div_)
import Halogen.Query.HalogenM (halt)
import Halogen.VDom.Driver (runUI)

import Page (content)
import Styles (styles)

main :: Eff (HalogenEffects ()) Unit
main = runHalogenAff $ awaitBody >>= runUI ui unit
  where
    ui = component { initialState : const unit
                   , render       : const $ div_ [ styles, content ]
                   , eval         : const $ halt "no query"
                   , receiver     : const Nothing
                   }

