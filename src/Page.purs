module Page
    ( Query
    , ui
    ) where

import Prelude
import Unsafe.Coerce (unsafeCoerce)

import CSS as C
import Halogen as H
import Halogen.HTML.CSS as HS
import Halogen.HTML.Indexed as HH

import Elements as E
import Fonts (styleFontFaces)

header :: forall p i. HH.HTML p i
header =
    E.section E.sectionStyleHeader
        [ E.boxes E.boxesStyleNoSpacing
            [ E.box_
                [ E.image E.imageStyleFill
                    "Siegfried Weber" "images/siegfried_weber.jpg"
                ]
            , E.box E.boxStyleRightSidePaddings
                [ E.heading E.headingStyleSmallMargin "Siegfried Weber"
                , E.paragraph_ $
                    E.text "Freiberuflicher Softwareentwickler und \n\
                            \Experte für funktionale Programmierung"
                , E.skillSet_
                    [ { name       : "Haskell, PureScript"
                      , expertise  : "Experte"
                      , percentage : 90.0
                      }
                    , { name       : "Java, Spring Boot"
                      , expertise  : "Experte"
                      , percentage : 100.0
                      }
                    , { name       : "HTML, CSS, JavaScript"
                      , expertise  : "Pro"
                      , percentage : 70.0
                      }
                    , { name       : "Microservices"
                      , expertise  : "2 Jahre Erfahrung"
                      , percentage : 80.0
                      }
                    ]
                ]
            ]
        ]

links :: forall p i. HH.HTML p i
links =
    E.section E.sectionStyleLinks
        [ E.list E.listStyleInline
            [ E.linkedIcon_ "Gulp"
                            "images/gulp.png"
                            "https://www.gulp.de/gulp2/home/profil/siegfriedweber"
            , E.linkedIcon_ "Xing"
                            "images/xing.png"
                            "https://www.xing.com/profile/Siegfried_Weber18"
            , E.linkedIcon_ "Linked in"
                            "images/linkedin.png"
                            "https://de.linkedin.com/in/siegfriedweber"
            , E.linkedIcon_ "GitHub"
                            "images/github.png"
                            "https://github.com/siegfriedweber"
            , E.linkedIcon_ "Stack Overflow"
                            "images/stackoverflow.png"
                            "https://stackoverflow.com/users/7312398/siegfried-weber"
            , E.linkedIcon_ "E-Mail"
                            "images/mail.png"
                            "mailto:mail@siegfriedweber.net"
            ]
        ]

about :: forall p i. HH.HTML p i
about = E.section_
    [ E.heading_ "Hallo, ich bin Siegfried!"
    , E.paragraph E.paragraphStyleNoMargin $
        E.text "Ich bin freiberuflicher Softwareentwickler und immer auf \
               \der Suche nach interessanten Projekten sowohl im \
               \Rhein-Main-Gebiet als auch \"remote\". Meine Software \
               \genügt höchsten Ansprüchen und diese stelle ich auch an \
               \die Projekte. Wenn Sie also etwas Großartiges schaffen \
               \wollen, dann lassen Sie uns das gemeinsam tun!"
    ]

skills :: forall p i. HH.HTML p i
skills = E.section_
    [ E.heading_ "Meine Fertigkeiten"
    , E.boxes_
        [ E.box_
            [ E.subheading_ "Programmiersprachen"
            , E.skillSet_
                [ { name       : "Haskell"
                  , expertise  : "Experte"
                  , percentage : 90.0
                  }
                , { name       : "PureScript"
                  , expertise  : "Experte"
                  , percentage : 90.0
                  }
                , { name       : "Java"
                  , expertise  : "Experte"
                  , percentage : 100.0
                  }
                , { name       : "Javascript"
                  , expertise  : "Pro"
                  , percentage : 80.0
                  }
                , { name       : "C++"
                  , expertise  : "lange nicht benutzt"
                  , percentage : 60.0
                  }
                ]
            ]
        , E.box_
            [ E.subheading_ "Datenbankmanagementsysteme"
            , E.skillSet_
                [ { name       : "MongoDB"
                  , expertise  : "Experte"
                  , percentage : 100.0
                  }
                , { name       : "MySQL"
                  , expertise  : "Pro"
                  , percentage : 70.0
                  }
                , { name       : "Google Cloud Datastore"
                  , expertise  : "am Lernen"
                  , percentage : 40.0
                  }
                ]
            ]
        , E.box_
            [ E.subheading_ "Werkzeuge"
            , E.skillSet_
                [ { name       : "Git"
                  , expertise  : "Guru"
                  , percentage : 100.0
                  }
                , { name       : "Vim"
                  , expertise  : "Guru"
                  , percentage : 100.0
                  }
                , { name       : "IntelliJ IDEA"
                  , expertise  : "Pro"
                  , percentage : 70.0
                  }
                ]
            ]
        , E.box_
            [ E.subheading_ "Betriebssysteme"
            , E.skillSet_
                [ { name       : "Microsoft Windows"
                  , expertise  : "Experte"
                  , percentage : 90.0
                  }
                , { name       : "Debian GNU/Linux"
                  , expertise  : "Experte"
                  , percentage : 100.0
                  }
                , { name       : "NixOS"
                  , expertise  : "auf dem Weg zum Experten"
                  , percentage : 30.0
                  }
                ]
            ]
        , E.box_
            [ E.subheading_ "Branchen"
            , E.skillSet_
                [ { name       : "Finanzen"
                  , expertise  : "Pro"
                  , percentage : 70.0
                  }
                , { name       : "Versicherungen"
                  , expertise  : "Pro"
                  , percentage : 80.0
                  }
                , { name       : "Computerspiele"
                  , expertise  : "Guru"
                  , percentage : 100.0
                  }
                ]
            ]
        , E.box_
            [ E.subheading_ "Sprachen"
            , E.skillSet_
                [ { name       : "Deutsch"
                  , expertise  : "Muttersprache"
                  , percentage : 100.0
                  }
                , { name       : "Englisch"
                  , expertise  : "verhandlungssicher"
                  , percentage : 85.0
                  }
                , { name       : "Französisch"
                  , expertise  : "am Lernen"
                  , percentage : 20.0
                  }
                ]
            ]
        ]
    ]

footer :: forall p i. HH.HTML p i
footer =
    E.section E.sectionStyleFooter
        [ E.boxes E.boxesStyleSmallSpacing
            [ E.box_
                [ E.paragraph E.paragraphStyleNoMargin $
                    E.text "Siegfried Weber\n\
                           \Rheinallee 16-22\n\
                           \65439 Flörsheim am Main\n\
                           \Deutschland"
                ]
            , E.box_
                [ E.paragraph E.paragraphStyleNoMargin $
                    E.text "Telefon: +49 151 55855451\n\
                           \E-Mail: " <>
                    E.email_ "mail@siegfriedweber.net"
                ]
            ]
        ]

website :: forall p i. HH.HTML p i
website = HH.div_
    [ unsafeCoerce $ HS.stylesheet (do
        styleBody
        styleFontFaces
        E.styleElements)
    , header
    , links
    , about
    , skills
    , footer
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

