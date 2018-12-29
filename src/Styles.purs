module Styles
    ( styles
    ) where

import Prelude

import CSS as C
import Halogen.HTML.CSS as HS
import Halogen.HTML (PlainHTML)

import Elements (styleElements)
import Fonts (styleFontFaces)

styles :: PlainHTML
styles = HS.stylesheet do
    styleBody
    styleFontFaces
    styleElements
  where
    styleBody = C.select C.body $ C.margin C.nil C.nil C.nil C.nil

