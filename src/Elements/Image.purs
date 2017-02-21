module Elements.Image
    ( ImageStyle
    , image
    , imageStyleFill
    , imageStyles
    ) where

import Prelude
import Data.Maybe (Maybe(Just))

import CSS as C
import CSS.VerticalAlign as CV
import Halogen.HTML.Indexed as HH
import Halogen.HTML.Properties.Indexed as HP

import Elements.Types (Style, defaultStyle)

imageStyles :: Array Style
imageStyles = getImageStyles imageStyleFill

newtype ImageStyle = ImageStyle Style

getImageStyles :: ImageStyle -> Array Style
getImageStyles (ImageStyle style) = [ style ]

imageStyleFill :: ImageStyle
imageStyleFill = ImageStyle defaultStyle
    { className = "image-inline"
    , cssCommon = Just do
        C.width $ C.pct 100.0
        C.display C.inlineBlock
        CV.verticalAlign CV.Top
    }

image :: forall p i. ImageStyle -> String -> String -> HH.HTML p i
image (ImageStyle style) alt src =
    HH.img [ HP.src src
           , HP.alt alt
           , HP.class_ $ HH.className style.className
           ]

