module Page
    ( Query
    , ui
    ) where

import Prelude

import Unsafe.Coerce (unsafeCoerce)

import CSS as C
import CSS.Media as CM
import Data.NonEmpty (singleton)
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
        , shadow = true
        }
        [ E.inlineImage "Siegfried Weber" "images/siegfried_weber.jpg"
        , HH.div [ HC.style styleIntro ]
            [ E.heading { marginBottom : 24.0 } "Siegfried Weber"
            , E.paragraph { marginBottom : 36.0 }
                "Freiberuflicher Softwareentwickler und \n\
                \Experte für funktionale Programmierung"
            , E.skillSet
                [ { name : "Haskell, PureScript", desc : "Experte", percentage : 90.0 }
                , { name : "Java, Spring Boot", desc : "Experte", percentage : 100.0 }
                , { name : "HTML, CSS, JavaScript", desc : "Pro", percentage : 70.0 }
                , { name : "Microservices", desc : "2 Jahre Erfahrung", percentage : 80.0 }
                ]
            ]
        ]
  where
    styleIntro :: C.CSS
    styleIntro = do
        C.display C.inlineBlock
        C.width $ C.px 312.0
        C.height $ C.px 372.0
        C.paddingLeft $ C.px 72.0
        C.paddingRight $ C.px 96.0
        C.paddingTop $ C.px 72.0
        C.paddingBottom $ C.px 36.0

links :: forall p i. HH.HTML p i
links =
    E.section E.defaultSectionStyle
        { paddingTop = C.px 24.0
        , paddingBottom = C.px 24.0
        , marginBottom = C.px 36.0
        , innerBackground = E.styleDarkBackground
        }
        [ E.inlineList
            [ E.linkedIcon "Gulp" "images/gulp.png" "https://www.gulp.de/gulp2/home/profil/siegfriedweber"
            , E.linkedIcon "Xing" "images/xing.png" "https://www.xing.com/profile/Siegfried_Weber18"
            , E.linkedIcon "Linked in" "images/linkedin.png" "https://de.linkedin.com/in/siegfriedweber"
            , E.linkedIcon "GitHub" "images/github.png" "https://github.com/siegfriedweber"
            , E.linkedIcon "Stack Overflow" "images/stackoverflow.png" "https://stackoverflow.com/users/7312398/siegfried-weber"
            , E.linkedIcon "E-Mail" "images/mail.png" "mailto:mail@siegfriedweber.net"
            ]
        ]

about :: forall p i. HH.HTML p i
about = E.section_
    [ E.heading_ "Hallo, ich bin Siegfried!"
    , E.paragraphs
        [ E.paragraph_ "Ich bin freiberuflicher Softwareentwickler und immer auf der Suche nach interessanten Projekten sowohl im Rhein-Main-Gebiet als auch \"remote\". Meine Software genügt höchsten Ansprüchen und diese stelle ich auch an die Projekte. Wenn Sie also etwas Großartiges schaffen wollen, dann lassen Sie uns das gemeinsam tun!"
        ]
    ]

skills :: forall p i. HH.HTML p i
skills = E.section E.defaultSectionStyle
    { paddingBottom = C.px 72.0
    }
    [ E.heading_ "Meine Fertigkeiten"
    , E.boxes E.defaultBoxStyle
        [ E.Box
            [ E.subHeading "Programmiersprachen"
            , E.skillSet
                [ { name : "Haskell",    desc : "Experte",             percentage : 90.0  }
                , { name : "PureScript", desc : "Experte",             percentage : 90.0  }
                , { name : "Java",       desc : "Experte",             percentage : 100.0 }
                , { name : "Javascript", desc : "Pro",                 percentage : 80.0  }
                , { name : "C++",        desc : "lange nicht benutzt", percentage : 60.0  }
                ]
            ]
        , E.Box
            [ E.subHeading "Datenbankmanagementsysteme"
            , E.skillSet
                [ { name : "MongoDB",                desc : "Experte",   percentage : 100.0 }
                , { name : "MySQL",                  desc : "Pro",       percentage : 70.0  }
                , { name : "Google Cloud Datastore", desc : "am Lernen", percentage : 40.0  }
                ]
            ]
        , E.Box
            [ E.subHeading "Werkzeuge"
            , E.skillSet
                [ { name : "Git",           desc : "Guru", percentage : 100.0 }
                , { name : "Vim",           desc : "Guru", percentage : 100.0 }
                , { name : "IntelliJ IDEA", desc : "Pro",  percentage : 70.0  }
                ]
            ]
        , E.Box
            [ E.subHeading "Betriebssysteme"
            , E.skillSet
                [ { name : "Microsoft Windows", desc : "Experte",                  percentage : 90.0  }
                , { name : "Debian GNU/Linux",  desc : "Experte",                  percentage : 100.0 }
                , { name : "NixOS",             desc : "auf dem Weg zum Experten", percentage : 30.0  }
                ]
            ]
        , E.Box
            [ E.subHeading "Branchen"
            , E.skillSet
                [ { name : "Finanzen",       desc : "Pro",  percentage : 70.0  }
                , { name : "Versicherungen", desc : "Pro",  percentage : 80.0  }
                , { name : "Computerspiele", desc : "Guru", percentage : 100.0 }
                ]
            ]
        , E.Box
            [ E.subHeading "Sprachen"
            , E.skillSet
                [ { name : "Deutsch",     desc : "Muttersprache",      percentage : 100.0 }
                , { name : "Englisch",    desc : "verhandlungssicher", percentage : 85.0  }
                , { name : "Französisch", desc : "am Lernen",          percentage : 20.0  }
                ]
            ]
        ]
    ]

footer :: forall p i. HH.HTML p i
footer =
    E.section E.defaultSectionStyle
        { outerBackground = E.styleDarkBackground
        , innerBackground = E.styleDarkBackground
        , textColor       = E.lightTextColor
        }
        [ E.boxes E.defaultBoxStyle
            { verticalSpace = 18.0
            }
            [ E.Box
                [ E.paragraphs
                    [ E.paragraph_ "Siegfried Weber\n\
                                   \Rheinallee 16-22\n\
                                   \65439 Flörsheim am Main\n\
                                   \Deutschland"
                    ]
                ]
            , E.Box
                [ E.paragraphs
                    [ E.paragraph'_
                        [ E.Text "Telefon: +49 151 55855451\n\
                                 \E-Mail: "
                        , E.Email "mail@siegfriedweber.net"
                        ]
                    ]
                ]
            ]
        ]

website :: forall p i. HH.HTML p i
website = HH.div_
    [ unsafeCoerce $ HS.stylesheet (do
        styleBody
        styleFontFaces
        styleSections)
    , header
    , links
    , about
    , skills
    , footer
    ]
  where
    styleBody :: C.CSS
    styleBody = C.select C.body $ C.margin C.nil C.nil C.nil C.nil

    styleSections :: C.CSS
    styleSections = do
        C.query CM.screen (singleton smallScreen) $ C.select classSection (C.width $ C.px 480.0)
        C.query CM.screen (singleton largeScreen) $ C.select classSection (C.width $ C.px 960.0)

    classSection :: C.Selector
    classSection = C.Selector (C.Refinement [C.Class "section"]) C.Star

    smallScreen :: C.Feature
    smallScreen = C.Feature "max-width" $ pure $ C.value $ C.px 999.0

    largeScreen :: C.Feature
    largeScreen = C.Feature "min-width" $ pure $ C.value $ C.px 1000.0

type State = Unit
data Query a = Query a

ui :: forall g. H.Component State Query g
ui = H.component { render, eval }
  where
    render :: State -> H.ComponentHTML Query
    render = const $ website

    eval :: Query ~> H.ComponentDSL State Query g
    eval (Query next) = pure next

