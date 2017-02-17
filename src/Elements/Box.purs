module Elements.Box
    ( Box
    , BoxesStyle
    , BoxStyle
    , box
    , box_
    , boxes
    , boxes_
    , boxesStyleDefault
    , boxesStyleNoSpacing
    , boxesStyleSmallSpacing
    , boxStyleDefault
    , boxStyleRightSidePaddings
    , boxStyles
    ) where

import Prelude
import Data.Maybe(Maybe(Just))

import CSS as C
import Halogen.HTML.Indexed as HH
import Halogen.HTML.Properties.Indexed as HP

import Elements.Types (Style, defaultStyle)

boxStyles :: Array Style
boxStyles = getBoxesStyles boxesStyleDefault
         <> getBoxesStyles boxesStyleNoSpacing
         <> getBoxesStyles boxesStyleSmallSpacing
         <> getBoxStyles boxStyleDefault
         <> getBoxStyles boxStyleRightSidePaddings

newtype BoxesStyle = BoxesStyle
    { boxes :: Style
    , box   :: Style
    }

getBoxesStyles :: BoxesStyle -> Array Style
getBoxesStyles (BoxesStyle styles) =
    [ styles.boxes
    , styles.box
    ]

boxesStyleDefault :: BoxesStyle
boxesStyleDefault = BoxesStyle
    { boxes : boxesStyleFrame "boxes" 36.0 36.0
    , box   : boxesStyleBox "boxes__item" 480.0 36.0 36.0
    }

boxesStyleSmallSpacing :: BoxesStyle
boxesStyleSmallSpacing = BoxesStyle
    { boxes : boxesStyleFrame "boxes-small-spacing" 36.0 9.0
    , box   : boxesStyleBox "boxes-small-spacing__item" 480.0 36.0 9.0
    }

boxesStyleNoSpacing :: BoxesStyle
boxesStyleNoSpacing = BoxesStyle
    { boxes : boxesStyleFrame "boxes-no-spacing" 0.0 0.0
    , box   : boxesStyleBox "boxes-no-spacing__item" 480.0 0.0 0.0
    }

boxesStyleFrame :: String -> Number -> Number -> Style
boxesStyleFrame className horizontalMargin verticalMargin = defaultStyle
    { className = className
    , cssCommon = Just do
        C.display C.flex
        C.flexWrap C.wrap
        C.marginTop $ C.px (- verticalMargin)
        C.marginBottom $ C.px (- verticalMargin)
        C.marginLeft $ C.px (- horizontalMargin)
        C.marginRight $ C.px (- horizontalMargin)
    }

boxesStyleBox :: String -> Number -> Number -> Number -> Style
boxesStyleBox className width horizontalMargin verticalMargin = defaultStyle
    { className = className
    , cssCommon = Just do
        C.width $ C.px $ width - horizontalMargin
        C.marginTop $ C.px verticalMargin
        C.marginBottom $ C.px verticalMargin
        C.marginLeft $ C.px horizontalMargin
        C.marginRight $ C.px horizontalMargin
    }

newtype BoxStyle = BoxStyle Style

data Box p i = Box BoxStyle (Array (HH.HTML p i))

getBoxStyles :: BoxStyle -> Array Style
getBoxStyles (BoxStyle style) = [ style ]

boxStyleDefault :: BoxStyle
boxStyleDefault = BoxStyle defaultStyle
    { className = "boxes__item-inner"
    }

boxStyleRightSidePaddings :: BoxStyle
boxStyleRightSidePaddings = BoxStyle defaultStyle
    { className = "boxes__item-inner-right-side-paddings"
    , cssCommon = Just do
        C.paddingLeft $ C.px 72.0
        C.paddingRight $ C.px 96.0
        C.paddingTop $ C.px 72.0
        C.paddingBottom C.nil
    }

box_ :: forall p i. Array (HH.HTML p i) -> Box p i
box_ = box boxStyleDefault

box :: forall p i. BoxStyle -> Array (HH.HTML p i) -> Box p i
box = Box

boxes_ :: forall p i. Array (Box p i) -> HH.HTML p i
boxes_ = boxes boxesStyleDefault

boxes :: forall p i. BoxesStyle -> Array (Box p i) -> HH.HTML p i
boxes (BoxesStyle boxesStyles) = map createBox >>>
    HH.div [ HP.class_ $ HH.className boxesStyles.boxes.className ]
  where
    createBox :: Box p i -> HH.HTML p i
    createBox (Box (BoxStyle boxStyle) content) =
        HH.div
            [ HP.class_ $ HH.className boxesStyles.box.className ]
            [ HH.div
                [ HP.class_ $ HH.className boxStyle.className ]
                content
            ]

