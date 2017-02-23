module Main where

import Prelude
import Control.Monad.Eff (Eff)
import Data.Maybe (Maybe(Nothing))

import Halogen (component)
import Halogen.Aff (HalogenEffects, awaitBody, runHalogenAff)
import Halogen.HTML (div_)
import Halogen.Query.HalogenM (halt)
import Halogen.VDom.Driver (runUI)

import Language (LANGUAGE, getUserLanguage, selectSupportedLanguage)
import Page (content)
import Styles (styles)

main :: Eff (HalogenEffects (language :: LANGUAGE)) Unit
main = do
    language <- selectSupportedLanguage <$> getUserLanguage
    runHalogenAff $ awaitBody >>= runUI (ui { language }) unit
  where
    ui state = component
        { initialState : const state
        , render       : \state' -> div_ [ styles
                                         , content state'.language
                                         ]
        , eval         : const $ halt "no query"
        , receiver     : const Nothing
        }

