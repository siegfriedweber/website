module Main where

import Prelude
import Control.Monad.Eff (Eff)
import Control.Monad.Free (liftF)

import Halogen (HalogenEffects, HalogenFP(HaltHF), component, runUI)
import Halogen.HTML.Indexed (div_)
import Halogen.Util (awaitBody, runHalogenAff)

import Page (content)
import Styles (styles)

main :: Eff (HalogenEffects ()) Unit
main = runHalogenAff $ awaitBody >>= runUI ui unit
  where
    ui = component { render : const $ div_ [ styles, content ]
                   , eval   : const $ liftF $ HaltHF "no query"
                   }

