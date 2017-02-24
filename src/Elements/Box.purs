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
import CSS.VerticalAlign as CV
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
    { boxes : boxesStyleBoxes { className : "boxes"
                              , verticalMargin : 36.0
                              , horizontalMarginScreen : 36.0
                              , horizontalMarginPrintInPct : 3.0
                              }
    , box   : boxesStyleBox { className : "boxes__item"
                            , verticalMargin : 36.0
                            , widthScreen : 480.0
                            , horizontalMarginScreen : 36.0
                            , horizontalMarginPrintInPct : 3.0
                            }
    }

boxesStyleSmallSpacing :: BoxesStyle
boxesStyleSmallSpacing = BoxesStyle
    { boxes : boxesStyleBoxes { className : "boxes-small-spacing"
                              , verticalMargin : 9.0
                              , horizontalMarginScreen : 36.0
                              , horizontalMarginPrintInPct : 3.0
                              }
    , box   : boxesStyleBox { className : "boxes-small-spacing__item"
                            , verticalMargin : 9.0
                            , widthScreen : 480.0
                            , horizontalMarginScreen : 36.0
                            , horizontalMarginPrintInPct : 3.0
                            }
    }

boxesStyleNoSpacing :: BoxesStyle
boxesStyleNoSpacing = BoxesStyle
    { boxes : boxesStyleBoxes { className : "boxes-no-spacing"
                              , verticalMargin : 0.0
                              , horizontalMarginScreen : 0.0
                              , horizontalMarginPrintInPct : 0.0
                              }
    , box   : boxesStyleBox { className : "boxes-no-spacing__item"
                            , verticalMargin : 0.0
                            , widthScreen : 480.0
                            , horizontalMarginScreen : 0.0
                            , horizontalMarginPrintInPct : 0.0
                            }
    }

boxesStyleBoxes :: { className                  :: String
                   , verticalMargin             :: Number
                   , horizontalMarginScreen     :: Number
                   , horizontalMarginPrintInPct :: Number
                   }
                -> Style
boxesStyleBoxes params = defaultStyle
    { className = params.className
    , cssCommon = Just do
        C.marginTop $ C.px (- params.verticalMargin)
        C.marginBottom $ C.px (- params.verticalMargin)
    , cssLarge  = Just do
        C.marginLeft $ C.px (- params.horizontalMarginScreen)
        C.marginRight $ C.px (- params.horizontalMarginScreen)
    , cssPrint  = Just do
        C.marginLeft $ C.pct (- params.horizontalMarginPrintInPct)
        C.marginRight $ C.pct (- params.horizontalMarginPrintInPct)
    }

boxesStyleBox :: { className                  :: String
                 , verticalMargin             :: Number
                 , widthScreen                :: Number
                 , horizontalMarginScreen     :: Number
                 , horizontalMarginPrintInPct :: Number
                 }
              -> Style
boxesStyleBox params = defaultStyle
    { className = params.className
    , cssCommon = Just do
        C.marginTop $ C.px params.verticalMargin
        C.marginBottom $ C.px params.verticalMargin
    , cssLarge  = Just do
        C.display C.inlineBlock
        CV.verticalAlign CV.Top
        C.width $ C.px $ params.widthScreen - params.horizontalMarginScreen
        C.marginLeft $ C.px params.horizontalMarginScreen
        C.marginRight $ C.px params.horizontalMarginScreen
    , cssPrint = Just do
        C.display C.inlineBlock
        CV.verticalAlign CV.Top
        C.width $ C.pct $ 50.0 - 2.0 * params.horizontalMarginPrintInPct
        C.marginLeft $ C.pct params.horizontalMarginPrintInPct
        C.marginRight $ C.pct params.horizontalMarginPrintInPct
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
    , cssPrint  = Just $
        C.paddingLeft   $ C.pct  8.0
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

