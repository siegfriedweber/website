module Page
    ( Query
    , ui
    ) where

import Prelude

import Unsafe.Coerce (unsafeCoerce)

import CSS as C
import CSS.ListStyle.Type as CL
import CSS.Common as CC
import CSS.TextAlign as CT
import CSS.VerticalAlign as CV
import Halogen as H
import Halogen.HTML.CSS as HS
import Halogen.HTML.CSS.Indexed as HC
import Halogen.HTML.Indexed as HH
import Halogen.HTML.Properties.Indexed as HP

import Fonts (Font(SourceSansProLight, SourceSansProSemibold), styleFont, styleFontFaces)

header :: forall p i. HH.HTML p i
header =
    HH.header [ HC.style styleHeader ]
      [ HH.div [ HC.style styleHeaderContent ]
          [ HH.img [ HP.src "images/siegfried_weber.jpg"
                   , HP.alt "Siegfried Weber"
                   , HC.style styleImage ]
          , HH.div [ HC.style styleIntro ]
              [ HH.h1 [ HC.style styleName ] [ HH.text "Siegfried Weber" ]
              , HH.p  [ HC.style styleDesc ]
                  [ HH.text "Freiberuflicher Softwareentwickler und \
                            \Experte für funktionale Programmierung"
                  ]
              ]
          ]
      ]
  where
    styleHeader :: C.CSS
    styleHeader = do
        C.paddingTop $ C.px 150.0

        C.backgroundColor $ C.fromInt 0x002b36
        C.backgroundImage $ C.url "images/header_background.jpg"
        C.backgroundRepeat C.noRepeat

    styleHeaderContent :: C.CSS
    styleHeaderContent = do
        C.width $ C.px 960.0
        C.marginLeft CC.auto
        C.marginRight CC.auto

        C.backgroundColor $ C.fromInt 0xf1f1f1

    styleImage :: C.CSS
    styleImage = do
        C.display C.inlineBlock
        CV.verticalAlign CV.Top

    styleIntro :: C.CSS
    styleIntro = do
        C.display C.inlineBlock
        C.width $ C.px 372.0
        C.height $ C.px 372.0
        C.paddingLeft $ C.px 36.0
        C.paddingRight $ C.px 72.0
        C.paddingTop $ C.px 72.0
        C.paddingBottom $ C.px 36.0

    styleName :: C.CSS
    styleName = do
        C.marginTop C.nil
        C.marginBottom $ C.px 6.0

        styleFont SourceSansProSemibold

    styleDesc :: C.CSS
    styleDesc =
        styleFont SourceSansProLight

links :: forall p i. HH.HTML p i
links =
    HH.div
        [ HC.style $ C.backgroundColor $ C.fromInt 0xf1f1f1 ]
        [ HH.div
            [ HC.style do
                 C.width $ C.px 960.0
                 C.marginLeft CC.auto
                 C.marginRight CC.auto
                 C.backgroundColor $ C.fromInt 0x002b36
                 C.paddingTop $ C.px 24.0
                 C.paddingBottom $ C.px 24.0
            ]
            [ inlineList
                [ link "Gulp" "gulp.png" "https://www.gulp.de/gulp2/home/profil/siegfriedweber"
                , link "Xing" "xing.png" "https://www.xing.com/profile/Siegfried_Weber18"
                , link "Linked in" "linkedin.png" "https://de.linkedin.com/in/siegfriedweber"
                , link "GitHub" "github.png" "https://github.com/siegfriedweber"
                , link "Stack Overflow" "stackoverflow.png" "https://stackoverflow.com/users/7312398/siegfried-weber"
                ]
            ]
        ]
  where
    inlineList :: forall p' i'. Array (HH.HTML p' i') -> HH.HTML p' i'
    inlineList = HH.ul
        [ HC.style do
            CT.textAlign CT.center
            CL.listStyleType CC.none
            C.marginTop C.nil
            C.marginBottom C.nil
            C.paddingLeft C.nil
        ]

    link :: forall p' i'. String -> String -> String -> HH.HTML p' i'
    link name icon url =
        HH.li [ HC.style $ C.display C.inlineBlock ]
            [ HH.a
                [ HP.href url
                , HC.style do
                    C.paddingLeft $ C.px 12.0
                    C.paddingRight $ C.px 12.0
                ]
                [ HH.img [ HP.src $ "images/" <> icon, HP.alt name ] ]
            ]

website :: forall p i. HH.HTML p i
website = HH.div_
    [ unsafeCoerce $ HS.stylesheet $ styleBody *> styleFontFaces
    , header
    , links
    ]

styleBody :: C.CSS
styleBody = C.select C.body $ C.margin C.nil C.nil C.nil C.nil

type State = Unit
data Query a = Query a

ui :: forall g. H.Component State Query g
ui = H.component { render, eval }
  where
    render :: State -> H.ComponentHTML Query
    render = const $ website

    eval :: Query ~> H.ComponentDSL State Query g
    eval (Query next) = pure next

