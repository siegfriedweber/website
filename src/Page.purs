module Page
    ( content
    ) where

import Prelude

import Halogen.HTML as HH

import Elements as E
import Language (Language)

content :: forall p i. Language -> HH.HTML p i
content language = E.multilingualContent language
    [ header language
    , links
    , about language
    , skills language
    , footer language
    ]

header :: forall p i. Language -> HH.HTML p i
header language =
    E.section E.sectionStyleHeader
        [ E.boxes E.boxesStyleNoSpacing
            [ E.box_
                [ E.image E.imageStyleFill
                    "Siegfried Weber" "images/siegfried_weber.jpg"
                ]
            , E.box E.boxStyleRightSidePaddings
                [ E.heading E.headingStyleSmallMargin "Siegfried Weber"
                , E.paragraph_ $ E.text $ E.choose language
                    { de : "Freiberuflicher Softwareentwickler und\n\
                           \Experte für funktionale Programmierung"
                    , en : "Freelance software developer and\n\
                           \expert for functional programming"
                    }
                , E.skillSet_
                    [ { name       : "Haskell, PureScript"
                      , expertise  : E.choose language
                                     { de : "Experte"
                                     , en : "Expert"
                                     }
                      , percentage : 90.0
                      }
                    , { name       : "Java, Spring Boot"
                      , expertise  : E.choose language
                                     { de : "Experte"
                                     , en : "Expert"
                                     }
                      , percentage : 100.0
                      }
                    , { name       : "HTML, CSS, JavaScript"
                      , expertise  : E.choose language
                                     { de : "Pro"
                                     , en : "Pro"
                                     }
                      , percentage : 70.0
                      }
                    , { name       : "Microservices"
                      , expertise  : E.choose language
                                     { de : "2 Jahre Erfahrung"
                                     , en : "2 years of experience"
                                     }
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

about :: forall p i. Language -> HH.HTML p i
about language = E.section_
    [ E.heading_ $ E.choose language
        { de : "Hallo, ich bin Siegfried!"
        , en : "Hello, I am Siegfried!"
        }
    , E.paragraph E.paragraphStyleNoMargin $ E.text $ E.choose language
        { de : "Ich bin freiberuflicher Softwareentwickler und immer auf \
               \der Suche nach interessanten Projekten sowohl im \
               \Rhein-Main-Gebiet als auch \"remote\". Meine Software \
               \genügt höchsten Ansprüchen und diese stelle ich auch an \
               \die Projekte. Wenn Sie also etwas Großartiges schaffen \
               \wollen, dann lassen Sie uns das gemeinsam tun!"
        , en : "I am a freelance software developer and always looking \
               \for interesting projects near Frankfurt/Main as well as \
               \remote. My software fulfills the highest demands and \
               \those I also have on the projects. So if you want to \
               \create something great then let us do it together!"
        }
    ]

skills :: forall p i. Language -> HH.HTML p i
skills language = E.section_
    [ E.heading_ $ E.choose language
        { de : "Meine Fertigkeiten"
        , en : "My skills"
        }
    , E.boxes_
        [ E.box_
            [ E.subheading_ $ E.choose language
                { de : "Programmier­sprachen"
                , en : "Programming languages"
                }
            , E.skillSet_
                [ { name       : "Haskell"
                  , expertise  : E.choose language
                                 { de : "Experte"
                                 , en : "Expert"
                                 }
                  , percentage : 90.0
                  }
                , { name       : "PureScript"
                  , expertise  : E.choose language
                                 { de : "Experte"
                                 , en : "Expert"
                                 }
                  , percentage : 90.0
                  }
                , { name       : "Java"
                  , expertise  : E.choose language
                                 { de : "Experte"
                                 , en : "Expert"
                                 }
                  , percentage : 100.0
                  }
                , { name       : "Javascript"
                  , expertise  : E.choose language
                                 { de : "Pro"
                                 , en : "Pro"
                                 }
                  , percentage : 80.0
                  }
                , { name       : "C++"
                  , expertise  : E.choose language
                                 { de : "lange nicht benutzt"
                                 , en : "Haven't used it for a while"
                                 }
                  , percentage : 60.0
                  }
                ]
            ]
        , E.box_
            [ E.subheading_ $ E.choose language
                { de : "Datenbank­management­systeme"
                , en : "Database management systems"
                }
            , E.skillSet_
                [ { name       : "MongoDB"
                  , expertise  : E.choose language
                                 { de : "Experte"
                                 , en : "Expert"
                                 }
                  , percentage : 100.0
                  }
                , { name       : "MySQL"
                  , expertise  : E.choose language
                                 { de : "Pro"
                                 , en : "Pro"
                                 }
                  , percentage : 70.0
                  }
                , { name       : "Google Cloud Datastore"
                  , expertise  : E.choose language
                                 { de : "am Lernen"
                                 , en : "Learning"
                                 }
                  , percentage : 40.0
                  }
                ]
            ]
        , E.box_
            [ E.subheading_ $ E.choose language
                { de : "Werkzeuge"
                , en : "Tools"
                }
            , E.skillSet_
                [ { name       : "Git"
                  , expertise  : E.choose language
                                 { de : "Guru"
                                 , en : "Guru"
                                 }
                  , percentage : 100.0
                  }
                , { name       : "Vim"
                  , expertise  : E.choose language
                                 { de : "Guru"
                                 , en : "Guru"
                                 }
                  , percentage : 100.0
                  }
                , { name       : "IntelliJ IDEA"
                  , expertise  : E.choose language
                                 { de : "Pro"
                                 , en : "Pro"
                                 }
                  , percentage : 70.0
                  }
                ]
            ]
        , E.box_
            [ E.subheading_ $ E.choose language
                { de : "Betriebssysteme"
                , en : "Operating systems"
                }
            , E.skillSet_
                [ { name       : "Microsoft Windows"
                  , expertise  : E.choose language
                                 { de : "Experte"
                                 , en : "Expert"
                                 }
                  , percentage : 90.0
                  }
                , { name       : "Debian GNU/Linux"
                  , expertise  : E.choose language
                                 { de : "Experte"
                                 , en : "Expert"
                                 }
                  , percentage : 100.0
                  }
                , { name       : "NixOS"
                  , expertise  : E.choose language
                                 { de : "auf dem Weg zum Experten"
                                 , en : "On the way to an expert"
                                 }
                  , percentage : 30.0
                  }
                ]
            ]
        , E.box_
            [ E.subheading_ $ E.choose language
                { de : "Branchen"
                , en : "Sectors"
                }
            , E.skillSet_
                [ { name       : E.choose language
                                 { de : "Finanzen"
                                 , en : "Financial sector"
                                 }
                  , expertise  : E.choose language
                                 { de : "Pro"
                                 , en : "Pro"
                                 }
                  , percentage : 70.0
                  }
                , { name       : E.choose language
                                 { de : "Versicherungen"
                                 , en : "Insurance business"
                                 }
                  , expertise  : E.choose language
                                 { de : "Pro"
                                 , en : "Pro"
                                 }
                  , percentage : 80.0
                  }
                , { name       : E.choose language
                                 { de : "Computerspiele"
                                 , en : "Gaming industry"
                                 }
                  , expertise  : E.choose language
                                 { de : "Guru"
                                 , en : "Guru"
                                 }
                  , percentage : 100.0
                  }
                ]
            ]
        , E.box_
            [ E.subheading_ $ E.choose language
                { de : "Sprachen"
                , en : "Languages"
                }
            , E.skillSet_
                [ { name       : E.choose language
                                 { de : "Deutsch"
                                 , en : "German"
                                 }
                  , expertise  : E.choose language
                                 { de : "Muttersprache"
                                 , en : "Native language"
                                 }
                  , percentage : 100.0
                  }
                , { name       : E.choose language
                                 { de : "Englisch"
                                 , en : "English"
                                 }
                  , expertise  : E.choose language
                                 { de : "verhandlungssicher"
                                 , en : "Business fluent"
                                 }
                  , percentage : 85.0
                  }
                , { name       : E.choose language
                                 { de : "Französisch"
                                 , en : "French"
                                 }
                  , expertise  : E.choose language
                                 { de : "am Lernen"
                                 , en : "Still learning"
                                 }
                  , percentage : 20.0
                  }
                ]
            ]
        ]
    ]

footer :: forall p i. Language -> HH.HTML p i
footer language =
    E.section E.sectionStyleFooter
        [ E.boxes E.boxesStyleSmallSpacing
            [ E.box_
                [ E.paragraph E.paragraphStyleNoMargin $ E.text $
                    "Siegfried Weber\n\
                    \Rheinallee 16-22\n\
                    \65439 Flörsheim am Main\n" <>
                    E.choose language
                        { de : "Deutschland"
                        , en : "Germany"
                        }
                ]
            , E.box_
                [ E.paragraph E.paragraphStyleNoMargin $
                    E.text (E.choose language
                                { de : "Telefon:"
                                , en : "Phone:"
                                } <>
                            " +49 151 55855451\n" <>
                            E.choose language
                                { de : "E-Mail:"
                                , en : "E-mail:"
                                } <>
                            " ") <>
                    E.email_ "mail@siegfriedweber.net"
                ]
            ]
        ]

