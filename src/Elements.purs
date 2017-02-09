module Elements
    ( SectionStyle
    , defaultSectionStyle
    , heading
    , inlineImage
    , inlineList
    , linkedIcon
    , paragraph
    , section
    , section_
    , styleDarkBackground
    , styleLightBackground
    ) where

import Prelude

import CSS as C
import CSS.Common as CC
import CSS.ListStyle.Type as CL
import CSS.TextAlign as CT
import CSS.VerticalAlign as CV
import Data.Array (singleton)
import Halogen.HTML.CSS.Indexed as HC
import Halogen.HTML.Indexed as HH
import Halogen.HTML.Properties.Indexed as HP

import Fonts (Font(SourceSansProLight, SourceSansProSemibold), styleFont)

styleLightBackground :: C.CSS
styleLightBackground = C.backgroundColor $ C.fromInt 0xf1f1f1

styleDarkBackground :: C.CSS
styleDarkBackground = C.backgroundColor $ C.fromInt 0x002b36

type SectionStyle =
    { marginTop       :: C.Size C.Abs
    , marginBottom    :: C.Size C.Abs
    , paddingTop      :: C.Size C.Abs
    , paddingBottom   :: C.Size C.Abs
    , outerBackground :: C.CSS
    , innerBackground :: C.CSS
    }

defaultSectionStyle :: SectionStyle
defaultSectionStyle =
    { marginTop       : C.nil
    , marginBottom    : C.nil
    , paddingTop      : C.px 72.0
    , paddingBottom   : C.px 72.0
    , outerBackground : styleLightBackground
    , innerBackground : styleLightBackground
    }

section_ :: forall p i. Array (HH.HTML p i) -> HH.HTML p i
section_ = section defaultSectionStyle

section :: forall p i. SectionStyle -> Array (HH.HTML p i) -> HH.HTML p i
section style content =
    HH.div
        [ HC.style do
            C.paddingTop style.marginTop
            C.paddingBottom style.marginBottom
            style.outerBackground
        ]
        [ HH.div
            [ HC.style do
                 C.width $ C.px 960.0
                 C.marginLeft CC.auto
                 C.marginRight CC.auto
                 C.paddingTop style.paddingTop
                 C.paddingBottom style.paddingBottom
                 style.innerBackground
            ]
            content
        ]

heading :: forall p i. String -> HH.HTML p i
heading text =
    HH.h1 [ HC.style do
              C.marginTop C.nil
              C.marginBottom $ C.px 6.0
              C.fontSize $ C.px 30.0
              styleFont SourceSansProSemibold
          ]
          [ HH.text text ]

paragraph :: forall p i. String -> HH.HTML p i
paragraph text =
    HH.p [ HC.style do
             C.fontSize $ C.px 18.0
             styleFont SourceSansProLight
         ]
         [ HH.text text ]

inlineImage :: forall p i. String -> String -> HH.HTML p i
inlineImage alt src =
    HH.img [ HP.src src
           , HP.alt alt
           , HC.style do
               C.display C.inlineBlock
               CV.verticalAlign CV.Top
           ]

inlineList :: forall p i. Array (HH.HTML p i) -> HH.HTML p i
inlineList = wrapItems >>> createList
  where
    wrapItems =
        map $ HH.li [ HC.style $ C.display C.inlineBlock ] <<< singleton

    createList =
        HH.ul [ HC.style do
                  CT.textAlign CT.center
                  CL.listStyleType CC.none
                  C.marginTop C.nil
                  C.marginBottom C.nil
                  C.paddingLeft C.nil
              ]

linkedIcon :: forall p i. String -> String -> String -> HH.HTML p i
linkedIcon name icon url =
    HH.a [ HP.href url
         , HC.style do
             C.paddingLeft $ C.px 12.0
             C.paddingRight $ C.px 12.0
         ]
         [ HH.img [ HP.src icon, HP.alt name ] ]

