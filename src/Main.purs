module Main where

import Prelude
import Control.Monad.Aff (Aff)
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Exception (error)
import Control.Monad.Error.Class (throwError)
import Data.Const (Const)
import Data.Maybe (Maybe(Nothing), maybe)
import Data.Newtype (unwrap)

import DOM (DOM)
import DOM.HTML.Types (HTMLElement)
import DOM.Node.ParentNode (QuerySelector(QuerySelector))
import Halogen (Component, ComponentHTML, component)
import Halogen.Aff (HalogenEffects, awaitLoad, runHalogenAff, selectElement)
import Halogen.HTML (HTML)
import Halogen.VDom.Driver (runUI)

import Language (LANGUAGE, getDisplayLanguage)
import LinkedData (linkedData)
import Page (content)
import Styles (styles)

main :: Eff (HalogenEffects (language :: LANGUAGE)) Unit
main = do
    language <- getDisplayLanguage
    runHalogenAff do
        awaitLoad
        staticUi (linkedData language) "head"
        staticUi styles "head"
        staticUi (content language) "body"
  where
    staticUi :: forall eff
              . ComponentHTML (Const Void)
             -> String
             -> Aff (HalogenEffects eff) Unit
    staticUi content = getHtmlElement
                   >=> runUI (staticComponent content) unit
                   >=> const (pure unit)

    getHtmlElement :: forall eff
                    . String
                   -> Aff (dom :: DOM | eff) HTMLElement
    getHtmlElement = selectElement <<< QuerySelector
                 >=> maybe (throwError $ error "Could not find element")
                        pure

    staticComponent :: forall m
                     . ComponentHTML (Const Void)
                    -> Component HTML (Const Void) Unit Void m
    staticComponent content = component
        { initialState : const unit
        , render       : const content
        , eval         : absurd <<< unwrap
        , receiver     : const Nothing
        }

