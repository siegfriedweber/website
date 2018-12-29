module Page
    ( content
    ) where

import Prelude

import Elements.Box
    ( box
    , box_
    , boxes
    , boxes_
    , boxesStyleNoSpacing
    , boxesStyleSmallSpacing
    , boxStyleRightSidePaddings
    )
import Elements.Language
    ( choose
    , multilingualContent
    )
import Elements.List
    ( list
    , listStyleInline
    )
import Elements.Icon
    ( linkedIcon_
    )
import Elements.Image
    ( image
    , imageStyleFill
    )
import Elements.Section
    ( section
    , section_
    , sectionStyleFooter
    , sectionStyleHeader
    , sectionStyleLinks
    )
import Elements.Skills
    ( skillSet_
    )
import Elements.Text
    ( email_
    , heading
    , heading_
    , headingStyleSmallMargin
    , link_
    , paragraph
    , paragraph_
    , paragraphStyleNoMargin
    , phone_
    , subheading_
    , text
    )
import Halogen.HTML
    ( PlainHTML
    )
import Language
    ( Language
    )

content :: Language -> PlainHTML
content language = multilingualContent language sections
  where
    sections = (#) language <$>
        [ header
        , links
        , about
        , availability
        , skills
        , coverage
        , footer
        ]

header :: Language -> PlainHTML
header language =
    section sectionStyleHeader
        [ boxes boxesStyleNoSpacing
            [ box_
                [ image imageStyleFill
                    "Siegfried Weber" "images/siegfried_weber-2.jpg"
                ]
            , box boxStyleRightSidePaddings
                [ heading headingStyleSmallMargin "Siegfried Weber"
                , paragraph_ $ text $ choose language
                    { de : "Freiberuflicher Softwareentwickler und\n\
                           \Experte für funktionale Programmierung"
                    , en : "Freelance software developer and\n\
                           \expert for functional programming"
                    }
                , skillSet_
                    [ { name      : "Haskell, PureScript"
                      , expertise : choose language
                                    { de : "Experte"
                                    , en : "Expert"
                                    }
                      , rating    : 9
                      }
                    , { name      : "Java, Spring Boot"
                      , expertise : choose language
                                    { de : "Experte"
                                    , en : "Expert"
                                    }
                      , rating    : 10
                      }
                    , { name      : "HTML, CSS, JavaScript"
                      , expertise : choose language
                                    { de : "Profi"
                                    , en : "Proficient"
                                    }
                      , rating    : 8
                      }
                    , { name      : "Microservices"
                      , expertise : choose language
                                    { de : "3 Jahre Erfahrung"
                                    , en : "3 years of experience"
                                    }
                      , rating    : 8
                      }
                    ]
                ]
            ]
        ]

links :: Language -> PlainHTML
links language =
    section sectionStyleLinks
        [ list listStyleInline
            [ linkedIcon_ "Gulp"
                          "images/gulp-1.png"
                          "https://www.gulp.de/gulp2/home/profil/siegfriedweber"
            , linkedIcon_ "Xing"
                          "images/xing-1.png"
                          "https://www.xing.com/profile/Siegfried_Weber18"
            , linkedIcon_ "Linked in"
                          "images/linkedin-1.png"
                          "https://de.linkedin.com/in/siegfriedweber"
            , linkedIcon_ "GitHub"
                          "images/github-1.png"
                          "https://github.com/siegfriedweber"
            , linkedIcon_ "E-Mail"
                          "images/mail-1.png"
                          "mailto:mail@siegfriedweber.net"
            , linkedIcon_ "Feed"
                          "images/feed-1.png"
                          $ choose language
                              { de: "feed-de"
                              , en: "feed-en"
                              }
            ]
        ]

about :: Language -> PlainHTML
about language = section_
    [ heading_ $ choose language
        { de : "Hallo, ich bin Siegfried Weber!"
        , en : "Hello, I am Siegfried Weber!"
        }
    , paragraph_ $ text $ choose language
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
    , paragraph paragraphStyleNoMargin $ choose language
        { de : text "Änderungen an meiner Verfügbarkeit und meinen \
               \Kompetenzen verfolgen Sie, indem Sie meinen "
            <> link_ "feed-de" (text "Web-Feed")
            <> text "abonnieren."
        , en : text "For getting notified about changes on my availability \
               \and skills please subscribe to my "
            <> link_ "feed-en" (text "web feed")
            <> text "."
        }
    ]

availability :: Language -> PlainHTML
availability language = section_
    [ heading_ $ choose language
        { de : "Verfügbarkeit"
        , en : "Availability"
        }
    , paragraph paragraphStyleNoMargin $ text $ choose language
        { de : "Für Vollzeitprojekte werde ich erst wieder ab Juli 2019 verfügbar sein."
        , en : "I will be available for fulltime projects from July 2019."
        }
    ]

skills :: Language -> PlainHTML
skills language = section_
    [ heading_ $ choose language
        { de : "Meine Kompetenzen"
        , en : "My skills"
        }
    , boxes_
        [ box_
            [ subheading_ $ choose language
                { de : "Programmier­sprachen"
                , en : "Programming languages"
                }
            , skillSet_
                [ { name      : "Haskell (Servant, ...)"
                  , expertise : choose language
                                { de : "Experte"
                                , en : "Expert"
                                }
                  , rating    : 9
                  }
                , { name      : "PureScript (Halogen)"
                  , expertise : choose language
                                { de : "Experte"
                                , en : "Expert"
                                }
                  , rating    : 9
                  }
                , { name      : "Java (Spring Boot)"
                  , expertise : choose language
                                { de : "Experte"
                                , en : "Expert"
                                }
                  , rating    : 10
                  }
                , { name      : "JavaScript (AngularJS)"
                  , expertise : choose language
                                { de : "Profi"
                                , en : "Proficient"
                                }
                  , rating    : 8
                  }
                , { name      : "C++ (STL)"
                  , expertise : choose language
                                { de : "Länger nicht verwendet"
                                , en : "Haven't used it for a while"
                                }
                  , rating    : 7
                  }
                , { name      : "Scala"
                  , expertise : choose language
                                { de : "Länger nicht verwendet"
                                , en : "Haven't used it for a while"
                                }
                  , rating    : 6
                  }
                ]
            ]
        , box_
            [ subheading_ $ choose language
                { de : "Werkzeuge"
                , en : "Tools"
                }
            , skillSet_
                [ { name      : "Vim"
                  , expertise : choose language
                                { de : "Experte"
                                , en : "Expert"
                                }
                  , rating    : 10
                  }
                , { name      : "IntelliJ IDEA"
                  , expertise : choose language
                                { de : "Profi"
                                , en : "Proficient"
                                }
                  , rating    : 9
                  }
                , { name      : "Eclipse"
                  , expertise : choose language
                                { de : "Profi"
                                , en : "Proficient"
                                }
                  , rating    : 8
                  }
                , { name      : "Git"
                  , expertise : choose language
                                { de : "Experte"
                                , en : "Expert"
                                }
                  , rating    : 10
                  }
                , { name      : "Jenkins"
                  , expertise : choose language
                                { de : "Profi"
                                , en : "Proficient"
                                }
                  , rating    : 8
                  }
                ]
            ]
        , box_
            [ subheading_ $ choose language
                { de : "Methoden"
                , en : "Methods"
                }
            , skillSet_
                [ { name      : "Scrum/Kanban"
                  , expertise : choose language
                                { de : "Experte"
                                , en : "Expert"
                                }
                  , rating    : 8
                  }
                , { name      : "Microservices"
                  , expertise : choose language
                                { de : "3 Jahre Erfahrung"
                                , en : "3 years of experience"
                                }
                  , rating    : 9
                  }
                , { name      : "REST"
                  , expertise : choose language
                                { de : "Experte"
                                , en : "Expert"
                                }
                  , rating    : 10
                  }
                ]
            ]
        , box_
            [ subheading_ $ choose language
                { de : "Datenbank­management­systeme"
                , en : "Database management systems"
                }
            , skillSet_
                [ { name      : "MongoDB"
                  , expertise : choose language
                                { de : "Experte"
                                , en : "Expert"
                                }
                  , rating    : 9
                  }
                , { name      : "MySQL"
                  , expertise : choose language
                                { de : "Profi"
                                , en : "Proficient"
                                }
                  , rating    : 7
                  }
                , { name      : "SQLite"
                  , expertise : choose language
                                { de : "Fortgeschritten"
                                , en : "Advanced"
                                }
                  , rating    : 5
                  }
                ]
            ]
        , box_
            [ subheading_ $ choose language
                { de : "Betriebssysteme"
                , en : "Operating systems"
                }
            , skillSet_
                [ { name      : "Microsoft Windows"
                  , expertise : choose language
                                { de : "Experte"
                                , en : "Expert"
                                }
                  , rating    : 9
                  }
                , { name      : "Debian GNU/Linux"
                  , expertise : choose language
                                { de : "Experte"
                                , en : "Expert"
                                }
                  , rating    : 10
                  }
                , { name      : "NixOS"
                  , expertise : choose language
                                { de : "Fortgeschritten"
                                , en : "Advanced"
                                }
                  , rating    : 9
                  }
                ]
            ]
        , box_
            [ subheading_ $ choose language
                { de : "Branchen"
                , en : "Sectors"
                }
            , skillSet_
                [ { name      : choose language
                                { de : "Transport & Verkehr"
                                , en : "Transportation"
                                }
                  , expertise : choose language
                                { de : "Profi"
                                , en : "Proficient"
                                }
                  , rating    : 7
                  }
                , { name      : choose language
                                { de : "Finanzen"
                                , en : "Financial sector"
                                }
                  , expertise : choose language
                                { de : "Profi"
                                , en : "Proficient"
                                }
                  , rating    : 7
                  }
                , { name      : choose language
                                { de : "Versicherungen"
                                , en : "Insurance business"
                                }
                  , expertise : choose language
                                { de : "Profi"
                                , en : "Proficient"
                                }
                  , rating    : 8
                  }
                , { name      : choose language
                                { de : "Computerspiele"
                                , en : "Gaming industry"
                                }
                  , expertise : choose language
                                { de : "Experte"
                                , en : "Expert"
                                }
                  , rating    : 10
                  }
                ]
            ]
        , box_
            [ subheading_ $ choose language
                { de : "Sprachen"
                , en : "Languages"
                }
            , skillSet_
                [ { name      : choose language
                                { de : "Deutsch"
                                , en : "German"
                                }
                  , expertise : choose language
                                { de : "Muttersprache"
                                , en : "Native language"
                                }
                  , rating    : 10
                  }
                , { name      : choose language
                                { de : "Englisch"
                                , en : "English"
                                }
                  , expertise : choose language
                                { de : "Verhandlungssicher"
                                , en : "Business fluent"
                                }
                  , rating    : 8
                  }
                , { name      : choose language
                                { de : "Französisch"
                                , en : "French"
                                }
                  , expertise : choose language
                                { de : "Mittelstufe"
                                , en : "Intermediate"
                                }
                  , rating    : 5
                  }
                ]
            ]
        ]
    ]

coverage :: Language -> PlainHTML
coverage language = section_
    [ heading_ $ choose language
        { de : "Absicherung"
        , en : "Coverage"
        }
    , linkedIcon_ "Weiter zur IT-Haftpflicht von Siegfried Weber, Flörsheim am Main" "https://www.exali.de/siegel/Haftpflicht_Siegel_2_a42d2266a3bae930f0024c87da406fd5.png" "http://www.exali.de/siegel/Siegfried-Weber"
    ]

footer :: Language -> PlainHTML
footer language =
    section sectionStyleFooter
        [ boxes boxesStyleSmallSpacing
            [ box_
                [ paragraph paragraphStyleNoMargin $ text $
                    "Siegfried Weber\n\
                    \Bernhardstr. 16\n\
                    \63741 Aschaffenburg\n" <>
                    choose language
                        { de : "Deutschland"
                        , en : "Germany"
                        }
                ]
            , box_
                [ paragraph paragraphStyleNoMargin $
                    text (choose language
                                { de : "Telefon: "
                                , en : "Phone: "
                                }
                           ) <>
                    phone_ "+49 151 55855451" <>
                    text "\n" <>
                    text (choose language
                                { de : "E-Mail: "
                                , en : "E-mail: "
                                }
                           ) <>
                    email_ "mail@siegfriedweber.net"
                ]
            ]
        ]

