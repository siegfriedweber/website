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
                    "Siegfried Weber" "images/siegfried_weber-2.jpg"
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
                    [ { name      : "Haskell, PureScript"
                      , expertise : E.choose language
                                    { de : "Experte"
                                    , en : "Expert"
                                    }
                      , rating    : 9
                      }
                    , { name      : "Java, Spring Boot"
                      , expertise : E.choose language
                                    { de : "Experte"
                                    , en : "Expert"
                                    }
                      , rating    : 10
                      }
                    , { name      : "HTML, CSS, JavaScript"
                      , expertise : E.choose language
                                    { de : "Profi"
                                    , en : "Proficient"
                                    }
                      , rating    : 8
                      }
                    , { name      : "Microservices"
                      , expertise : E.choose language
                                    { de : "2 Jahre Erfahrung"
                                    , en : "2 years of experience"
                                    }
                      , rating    : 8
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
                            "images/gulp-1.png"
                            "https://www.gulp.de/gulp2/home/profil/siegfriedweber"
            , E.linkedIcon_ "Xing"
                            "images/xing-1.png"
                            "https://www.xing.com/profile/Siegfried_Weber18"
            , E.linkedIcon_ "Linked in"
                            "images/linkedin-1.png"
                            "https://de.linkedin.com/in/siegfriedweber"
            , E.linkedIcon_ "GitHub"
                            "images/github-1.png"
                            "https://github.com/siegfriedweber"
            , E.linkedIcon_ "Stack Overflow"
                            "images/stackoverflow-1.png"
                            "https://stackoverflow.com/users/7312398/siegfried-weber"
            , E.linkedIcon_ "E-Mail"
                            "images/mail-1.png"
                            "mailto:mail@siegfriedweber.net"
            ]
        ]

about :: forall p i. Language -> HH.HTML p i
about language = E.section_
    [ E.heading_ $ E.choose language
        { de : "Hallo, ich bin Siegfried Weber!"
        , en : "Hello, I am Siegfried Weber!"
        }
    , E.paragraph E.paragraphStyleNoMargin $ E.text $ E.choose language
        { de : "Ich bin freiberuflicher Softwareentwickler und immer an \
               \spannenden Projekten interessiert, vorzugsweise \"remote\" \
               \oder im Rhein-Main-Gebiet. \
               \Komplexen fachlichen Anforderungen stelle ich mich sehr \
               \gerne. Meine Umsetzung genügt dabei höchsten Ansprüchen. \
               \Andererseits stelle ich auch hohe Ansprüche an die \
               \Projekte. Wenn Sie also etwas Großartiges schaffen \
               \wollen, dann lassen Sie uns das gemeinsam tun!"
        , en : "I am a freelance software developer and always interested \
               \in exciting projects near Frankfurt/Main as well as \
               \remote. \
               \Complex requirements do not pose a problem for me. My \
               \implementation of them fulfills the highest demands. \
               \On the other side I also make high demands on the \
               \projects. So if you intend to create something great \
               \then let us do it together!"
        }
    ]

skills :: forall p i. Language -> HH.HTML p i
skills language = E.section_
    [ E.heading_ $ E.choose language
        { de : "Meine Kompetenzen"
        , en : "My skills"
        }
    , E.boxes_
        [ E.box_
            [ E.subheading_ $ E.choose language
                { de : "Programmier­sprachen"
                , en : "Programming languages"
                }
            , E.skillSet_
                [ { name      : "Haskell (Servant, ...)"
                  , expertise : E.choose language
                                { de : "Experte"
                                , en : "Expert"
                                }
                  , rating    : 9
                  }
                , { name      : "PureScript (Halogen)"
                  , expertise : E.choose language
                                { de : "Experte"
                                , en : "Expert"
                                }
                  , rating    : 9
                  }
                , { name      : "Java (Spring Boot)"
                  , expertise : E.choose language
                                { de : "Experte"
                                , en : "Expert"
                                }
                  , rating    : 10
                  }
                , { name      : "JavaScript (AngularJS)"
                  , expertise : E.choose language
                                { de : "Profi"
                                , en : "Proficient"
                                }
                  , rating    : 8
                  }
                , { name      : "C++ (STL)"
                  , expertise : E.choose language
                                { de : "Länger nicht verwendet"
                                , en : "Haven't used it for a while"
                                }
                  , rating    : 7
                  }
                , { name      : "Scala"
                  , expertise : E.choose language
                                { de : "Länger nicht verwendet"
                                , en : "Haven't used it for a while"
                                }
                  , rating    : 6
                  }
                ]
            ]
        , E.box_
            [ E.subheading_ $ E.choose language
                { de : "Werkzeuge"
                , en : "Tools"
                }
            , E.skillSet_
                [ { name      : "Vim"
                  , expertise : E.choose language
                                { de : "Experte"
                                , en : "Expert"
                                }
                  , rating    : 9
                  }
                , { name      : "IntelliJ IDEA"
                  , expertise : E.choose language
                                { de : "Profi"
                                , en : "Proficient"
                                }
                  , rating    : 7
                  }
                , { name      : "Eclipse"
                  , expertise : E.choose language
                                { de : "Profi"
                                , en : "Proficient"
                                }
                  , rating    : 8
                  }
                , { name      : "Git"
                  , expertise : E.choose language
                                { de : "Experte"
                                , en : "Expert"
                                }
                  , rating    : 10
                  }
                , { name      : "Jenkins"
                  , expertise : E.choose language
                                { de : "Profi"
                                , en : "Proficient"
                                }
                  , rating    : 8
                  }
                ]
            ]
        , E.box_
            [ E.subheading_ $ E.choose language
                { de : "Methoden"
                , en : "Methods"
                }
            , E.skillSet_
                [ { name      : "Scrum/Kanban"
                  , expertise : E.choose language
                                { de : "Experte"
                                , en : "Expert"
                                }
                  , rating    : 8
                  }
                , { name      : "Microservices"
                  , expertise : E.choose language
                                { de : "2 Jahre Erfahrung"
                                , en : "2 years of experience"
                                }
                  , rating    : 9
                  }
                , { name      : "REST"
                  , expertise : E.choose language
                                { de : "Experte"
                                , en : "Expert"
                                }
                  , rating    : 10
                  }
                ]
            ]
        , E.box_
            [ E.subheading_ $ E.choose language
                { de : "Datenbank­management­systeme"
                , en : "Database management systems"
                }
            , E.skillSet_
                [ { name      : "MongoDB"
                  , expertise : E.choose language
                                { de : "Experte"
                                , en : "Expert"
                                }
                  , rating    : 9
                  }
                , { name      : "MySQL"
                  , expertise : E.choose language
                                { de : "Profi"
                                , en : "Proficient"
                                }
                  , rating    : 7
                  }
                , { name      : "Google Cloud Datastore"
                  , expertise : E.choose language
                                { de : "Fortgeschritten"
                                , en : "Advanced"
                                }
                  , rating    : 4
                  }
                ]
            ]
        , E.box_
            [ E.subheading_ $ E.choose language
                { de : "Betriebssysteme"
                , en : "Operating systems"
                }
            , E.skillSet_
                [ { name      : "Microsoft Windows"
                  , expertise : E.choose language
                                { de : "Experte"
                                , en : "Expert"
                                }
                  , rating    : 9
                  }
                , { name      : "Debian GNU/Linux"
                  , expertise : E.choose language
                                { de : "Experte"
                                , en : "Expert"
                                }
                  , rating    : 10
                  }
                , { name      : "NixOS"
                  , expertise : E.choose language
                                { de : "Fortgeschritten"
                                , en : "Advanced"
                                }
                  , rating    : 6
                  }
                ]
            ]
        , E.box_
            [ E.subheading_ $ E.choose language
                { de : "Branchen"
                , en : "Sectors"
                }
            , E.skillSet_
                [ { name      : E.choose language
                                { de : "Finanzen"
                                , en : "Financial sector"
                                }
                  , expertise : E.choose language
                                { de : "Profi"
                                , en : "Proficient"
                                }
                  , rating    : 7
                  }
                , { name      : E.choose language
                                { de : "Versicherungen"
                                , en : "Insurance business"
                                }
                  , expertise : E.choose language
                                { de : "Profi"
                                , en : "Proficient"
                                }
                  , rating    : 8
                  }
                , { name      : E.choose language
                                { de : "Computerspiele"
                                , en : "Gaming industry"
                                }
                  , expertise : E.choose language
                                { de : "Experte"
                                , en : "Expert"
                                }
                  , rating    : 10
                  }
                ]
            ]
        , E.box_
            [ E.subheading_ $ E.choose language
                { de : "Sprachen"
                , en : "Languages"
                }
            , E.skillSet_
                [ { name      : E.choose language
                                { de : "Deutsch"
                                , en : "German"
                                }
                  , expertise : E.choose language
                                { de : "Muttersprache"
                                , en : "Native language"
                                }
                  , rating    : 10
                  }
                , { name      : E.choose language
                                { de : "Englisch"
                                , en : "English"
                                }
                  , expertise : E.choose language
                                { de : "Verhandlungssicher"
                                , en : "Business fluent"
                                }
                  , rating    : 8
                  }
                , { name      : E.choose language
                                { de : "Französisch"
                                , en : "French"
                                }
                  , expertise : E.choose language
                                { de : "Mittelstufe"
                                , en : "Intermediate"
                                }
                  , rating    : 3
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
                                { de : "Telefon: "
                                , en : "Phone: "
                                }
                           ) <>
                    E.phone_ "+49 151 55855451" <>
                    E.text "\n" <>
                    E.text (E.choose language
                                { de : "E-Mail: "
                                , en : "E-mail: "
                                }
                           ) <>
                    E.email_ "mail@siegfriedweber.net"
                ]
            ]
        ]

