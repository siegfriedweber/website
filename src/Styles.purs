module Styles
    ( styles
    ) where

import Prelude

import CSS as C
import Halogen.HTML.CSS as HS
import Halogen.HTML.Indexed as HH

import Elements (styleElements)
import Fonts (styleFontFaces)

styles :: forall p i. HH.HTML p i
styles = HS.stylesheet do
    styleBody
    styleFontFaces
    styleElements
  where
    styleBody = C.select C.body $ C.margin C.nil C.nil C.nil C.nil

