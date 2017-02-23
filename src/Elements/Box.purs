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
import Data.Maybe (Maybe(Just))

import CSS as C
import Halogen.HTML as HH
import Halogen.HTML.Properties as HP

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
    { boxes : boxesStyleBoxes "boxes" 36.0 36.0
    , box   : boxesStyleBox "boxes__item" 480.0 36.0 36.0
    }

boxesStyleSmallSpacing :: BoxesStyle
boxesStyleSmallSpacing = BoxesStyle
    { boxes : boxesStyleBoxes "boxes-small-spacing" 36.0 9.0
    , box   : boxesStyleBox "boxes-small-spacing__item" 480.0 36.0 9.0
    }

boxesStyleNoSpacing :: BoxesStyle
boxesStyleNoSpacing = BoxesStyle
    { boxes : boxesStyleBoxes "boxes-no-spacing" 0.0 0.0
    , box   : boxesStyleBox "boxes-no-spacing__item" 480.0 0.0 0.0
    }

boxesStyleBoxes :: String -> Number -> Number -> Style
boxesStyleBoxes className horizontalMargin verticalMargin = defaultStyle
    { className = className
    , cssCommon = Just do
        C.marginTop $ C.px (- verticalMargin)
        C.marginBottom $ C.px (- verticalMargin)
    , cssLarge  = Just do
        C.display C.flex
        C.flexWrap C.wrap
        C.marginLeft $ C.px (- horizontalMargin)
        C.marginRight $ C.px (- horizontalMargin)
    }

boxesStyleBox :: String -> Number -> Number -> Number -> Style
boxesStyleBox className width horizontalMargin verticalMargin = defaultStyle
    { className = className
    , cssCommon = Just do
        C.marginTop $ C.px verticalMargin
        C.marginBottom $ C.px verticalMargin
    , cssLarge  = Just do
        C.width $ C.px $ width - horizontalMargin
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
    , cssSmall  = Just do
        C.paddingLeft   $ C.pct 5.0
        C.paddingRight  $ C.pct 5.0
        C.paddingTop    $ C.px 36.0
        C.paddingBottom $ C.px 36.0
    , cssMedium = Just do
        C.paddingLeft   $ C.px 72.0
        C.paddingRight  $ C.px 72.0
        C.paddingTop    $ C.px 72.0
        C.paddingBottom $ C.px 72.0
    , cssLarge  = Just do
        C.paddingLeft   $ C.px 72.0
        C.paddingRight  $ C.px 96.0
        C.paddingTop    $ C.px 88.0
        C.paddingBottom $ C.px 72.0
    }

box_ :: forall p i. Array (HH.HTML p i) -> Box p i
box_ = box boxStyleDefault

box :: forall p i. BoxStyle -> Array (HH.HTML p i) -> Box p i
box = Box

boxes_ :: forall p i. Array (Box p i) -> HH.HTML p i
boxes_ = boxes boxesStyleDefault

boxes :: forall p i. BoxesStyle -> Array (Box p i) -> HH.HTML p i
boxes (BoxesStyle boxesStyles) = map createBox >>>
    HH.div [ HP.class_ $ HH.ClassName boxesStyles.boxes.className ]
  where
    createBox :: Box p i -> HH.HTML p i
    createBox (Box (BoxStyle boxStyle) content) =
        HH.div
            [ HP.class_ $ HH.ClassName boxesStyles.box.className ]
            [ HH.div
                [ HP.class_ $ HH.ClassName boxStyle.className ]
                content
            ]
