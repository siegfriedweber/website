module Elements.Box
    ( Box
    , BoxStyle
    , box
    , boxes
    , boxStyleDefault
    , boxStyles
    , boxStyleSmallSpacing
    ) where

import Prelude
import Data.Maybe(Maybe(Just))

import CSS as C
import Halogen.HTML.Indexed as HH
import Halogen.HTML.Properties.Indexed as HP

import Elements.Types (Style, defaultStyle)

boxStyles :: Array Style
boxStyles = getStyles boxStyleDefault
         <> getStyles boxStyleSmallSpacing

newtype Box p i = Box (Array (HH.HTML p i))

box :: forall p i. Array (HH.HTML p i) -> Box p i
box = Box

newtype BoxStyle = BoxStyle
    { frame :: Style
    , box   :: Style
    }

getStyles :: BoxStyle -> Array Style
getStyles (BoxStyle style) = [ style.frame, style.box ]

boxStyleDefault :: BoxStyle
boxStyleDefault = BoxStyle
    { frame : boxStyleFrame 36.0 36.0
    , box   : boxStyleBox 444.0 36.0 36.0
    }

boxStyleSmallSpacing :: BoxStyle
boxStyleSmallSpacing = BoxStyle
    { frame : boxStyleFrame 36.0 9.0
    , box   : boxStyleBox 444.0 36.0 9.0
    }

boxStyleFrame :: Number -> Number -> Style
boxStyleFrame horizontalMargin verticalMargin = defaultStyle
    { className = "boxFrame"
    , cssCommon = Just do
        C.display C.flex
        C.flexWrap C.wrap
        C.marginTop $ C.px (- verticalMargin)
        C.marginBottom $ C.px (- verticalMargin)
        C.marginLeft $ C.px (- horizontalMargin)
        C.marginRight $ C.px (- horizontalMargin)
    }

boxStyleBox :: Number -> Number -> Number -> Style
boxStyleBox width horizontalMargin verticalMargin = defaultStyle
    { className = "boxBox"
    , cssCommon = Just do
        C.width $ C.px width
        C.marginTop $ C.px verticalMargin
        C.marginBottom $ C.px verticalMargin
        C.marginLeft $ C.px horizontalMargin
        C.marginRight $ C.px horizontalMargin
    }

boxes :: forall p i. BoxStyle -> Array (Box p i) -> HH.HTML p i
boxes (BoxStyle style) = map createBox >>>
    HH.div [ HP.class_ $ HH.className style.frame.className ]
  where
    createBox :: Box p i -> HH.HTML p i
    createBox (Box b) = HH.div
        [ HP.class_ $ HH.className style.box.className ]
        b

