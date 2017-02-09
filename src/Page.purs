module Page
    ( Query
    , ui
    ) where

import Prelude

import Unsafe.Coerce (unsafeCoerce)

import CSS as C
import Halogen as H
import Halogen.HTML.CSS as HS
import Halogen.HTML.CSS.Indexed as HC
import Halogen.HTML.Indexed as HH

import Elements as E
import Fonts (styleFontFaces)

header :: forall p i. HH.HTML p i
header =
    E.section E.defaultSectionStyle
        { marginTop = C.px 150.0
        , paddingTop = C.nil
        , paddingBottom = C.nil
        , outerBackground = do
            E.styleDarkBackground
            C.backgroundImage $ C.url "images/header_background.jpg"
            C.backgroundRepeat C.noRepeat
        }
        [ E.inlineImage "Siegfried Weber" "images/siegfried_weber.jpg"
        , HH.div [ HC.style styleIntro ]
            [ E.heading "Siegfried Weber"
            , E.paragraph "Freiberuflicher Softwareentwickler und \
                        \Experte für funktionale Programmierung"
            ]
        ]
  where
    styleIntro :: C.CSS
    styleIntro = do
        C.display C.inlineBlock
        C.width $ C.px 372.0
        C.height $ C.px 372.0
        C.paddingLeft $ C.px 36.0
        C.paddingRight $ C.px 72.0
        C.paddingTop $ C.px 72.0
        C.paddingBottom $ C.px 36.0

links :: forall p i. HH.HTML p i
links =
    E.section E.defaultSectionStyle
        { paddingTop = C.px 24.0
        , paddingBottom = C.px 24.0
        , innerBackground = E.styleDarkBackground
        }
        [ E.inlineList
            [ E.linkedIcon "Gulp" "images/gulp.png" "https://www.gulp.de/gulp2/home/profil/siegfriedweber"
            , E.linkedIcon "Xing" "images/xing.png" "https://www.xing.com/profile/Siegfried_Weber18"
            , E.linkedIcon "Linked in" "images/linkedin.png" "https://de.linkedin.com/in/siegfriedweber"
            , E.linkedIcon "GitHub" "images/github.png" "https://github.com/siegfriedweber"
            , E.linkedIcon "Stack Overflow" "images/stackoverflow.png" "https://stackoverflow.com/users/7312398/siegfried-weber"
            ]
        ]

about :: forall p i. HH.HTML p i
about = E.section_
    [ E.heading "Hallo, ich bin Siegfried!"
    , E.paragraph "Ich bin freiberuflicher Softwareentwickler und habe mich auf funktionale Programmierung spezialisiert."
    ]

website :: forall p i. HH.HTML p i
website = HH.div_
    [ unsafeCoerce $ HS.stylesheet $ styleBody *> styleFontFaces
    , header
    , links
    , about
    ]
  where
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

