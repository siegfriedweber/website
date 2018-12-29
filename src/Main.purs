module Main where

import Prelude
import Control.Monad.Error.Class (throwError)
import Data.Const (Const)
import Data.Maybe (Maybe(Nothing), maybe)
import Data.Newtype (unwrap)
import Effect (Effect)
import Effect.Aff (Aff)
import Effect.Exception (error)

import Halogen (Component, component)
import Halogen.Aff (awaitLoad, runHalogenAff, selectElement)
import Halogen.HTML (HTML, PlainHTML, fromPlainHTML)
import Halogen.VDom.Driver (runUI)
import Web.DOM.ParentNode (QuerySelector(QuerySelector))
import Web.HTML.HTMLElement (HTMLElement)

import Language (getDisplayLanguage)
import LinkedData (linkedData)
import Page (content)
import Styles (styles)

main :: Effect Unit
main = do
    language <- getDisplayLanguage
    runHalogenAff do
        awaitLoad
        staticUi (linkedData language) "head"
        staticUi styles "head"
        staticUi (content language) "body"
  where
    staticUi :: PlainHTML
             -> String
             -> Aff Unit
    staticUi content = getHtmlElement
                   >=> runUI (staticComponent content) unit
                   >=> const (pure unit)

    getHtmlElement :: String
                   -> Aff HTMLElement
    getHtmlElement = selectElement <<< QuerySelector
                 >=> maybe (throwError $ error "Could not find element")
                        pure

    staticComponent :: forall m
                     . PlainHTML
                    -> Component HTML (Const Void) Unit Void m
    staticComponent content = component
        { initialState : const unit
        , render       : const $ fromPlainHTML content
        , eval         : absurd <<< unwrap
        , receiver     : const Nothing
        }

