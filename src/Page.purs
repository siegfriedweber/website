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
    ( linkedIcon
    , linkedIcon_
    , linkedIconStyleOriginalSize
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
        , jobSites
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
                      , rating    : 7
                      }
                    , { name      : "Java, Spring Boot"
                      , rating    : 10
                      }
                    , { name      : "JavaScript, Vue.js"
                      , rating    : 7
                      }
                    , { name      : "Microservices"
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
                          "images/gulp-1.svg"
                          "https://www.gulp.de/gulp2/home/profil/siegfriedweber"
            , linkedIcon_ "Xing"
                          "images/xing-1.svg"
                          "https://www.xing.com/profile/Siegfried_Weber18"
            , linkedIcon_ "Linked in"
                          "images/linkedin-1.svg"
                          "https://de.linkedin.com/in/siegfriedweber"
            , linkedIcon_ "GitHub"
                          "images/github-1.svg"
                          "https://github.com/siegfriedweber"
            , linkedIcon_ "E-Mail"
                          "images/mail-1.svg"
                          "mailto:mail@siegfriedweber.net"
            , linkedIcon_ "Feed"
                          "images/feed-1.svg"
                          $ choose language
                              { de: "feed-de"
                              , en: "feed-en"
                              }
            ]
        ]

about :: Language -> PlainHTML
about language = section_
    [ heading_ $ choose language
        { de : "Willkommen!"
        , en : "Welcome!"
        }
    , paragraph_ $ choose language
        { de : text "Ich freue mich, dass Sie den Weg zu meinem \
               \Internetauftritt gefunden haben. \
               \Als potenzieller Auftraggeber oder direkt beauftragter \
               \Vermittler finden Sie auf dieser Seite Informationen zu \
               \meiner Verfügbarkeit, möglichen Einsatzorten und eine \
               \Selbsteinschätzung meiner Kompetenzen. Falls ich damit \
               \eine passende Besetzung für Ihr Projekt darstelle, freue \
               \ich mich über eine Anfrage mit einer aussagekräftigen \
               \Projektbeschreibung per "
            <> link_ "mailto:mail@siegfriedweber.net" (text "E-Mail")
            <> text ". Auf Wunsch sende ich Ihnen dann gerne mein Profil \
               \mit ausführlicher Projekthistorie zu."
        , en : text "Nice to see you on my web page. \
               \As a potential customer or directly charged agency \
               \you will find information about my availability, \
               \possible job sites, and a self-rating of my skills. \
               \If this matches with your project needs, I would be \
               \glad to receive an "
            <> link_ "mailto:mail@siegfriedweber.net" (text "e-mail")
            <> text " with a meaningful project description. Upon \
               \request I will send you a profile with a detailed \
               \project history."
        }
    , paragraph paragraphStyleNoMargin $ choose language
        { de : text "Änderungen an meiner Verfügbarkeit und meinen \
               \Kompetenzen verfolgen Sie, indem Sie meinen "
            <> link_ "feed-de" (text "Web-Feed")
            <> text " abonnieren."
        , en : text "For getting notified about changes on my availability \
               \and skills please subscribe to my "
            <> link_ "feed-en" (text "web feed")
            <> text "."
        }
    ]

jobSites :: Language -> PlainHTML
jobSites language = section_
    [ heading_ $ choose language
        { de : "Einsatzorte"
        , en : "Job Sites"
        }
    , paragraph paragraphStyleNoMargin $ text $ choose language
        { de : "Projekte, die vollständig remote duchgeführt werden \
               \können oder deren Laufzeit maximal zwei Wochen beträgt, \
               \unterstütze ich gerne deutschlandweit. Projekte, die \
               \eine Anwesenheit erfordern und längerfristig sind, nehme \
               \ich nur in der Nähe von Aschaffenburg (Frankfurt am \
               \Main, Darmstadt, Würzburg) an."
        , en : "If a project can be completely done remotely or lasts up \
               \to two weeks then I would like to support it in all of \
               \Germany. Otherwise I accept projects only nearby \
               \Aschaffenburg (Frankfurt on the Main, Darmstadt, \
               \Würzburg)."
        }
    ]

availability :: Language -> PlainHTML
availability language = section_
    [ heading_ $ choose language
        { de : "Verfügbarkeit"
        , en : "Availability"
        }
    , paragraph paragraphStyleNoMargin $ text $ choose language
        { de : "Für Vollzeitprojekte werde ich erst wieder ab Januar \
               \2021 verfügbar sein."
        , en : "I will be available for fulltime projects from January \
               \2021."
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
                  , rating    : 7
                  }
                , { name      : "PureScript (Halogen)"
                  , rating    : 8
                  }
                , { name      : "Java (Spring Boot)"
                  , rating    : 10
                  }
                , { name      : "JavaScript (Vue.js)"
                  , rating    : 7
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
                  , rating    : 10
                  }
                , { name      : "IntelliJ IDEA"
                  , rating    : 9
                  }
                , { name      : "Git (Git Flow)"
                  , rating    : 10
                  }
                , { name      : "Jenkins"
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
                  , rating    : 8
                  }
                , { name      : "Microservices"
                  , rating    : 8
                  }
                ]
            ]
        , box_
            [ subheading_ $ choose language
                { de : "Schnittstellen"
                , en : "Interfaces"
                }
            , skillSet_
                [ { name      : "REST"
                  , rating    : 10
                  }
                , { name      : "Kafka"
                  , rating    : 8
                  }
                , { name      : "RabbitMQ"
                  , rating    : 7
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
                  , rating    : 9
                  }
                , { name      : "Solr"
                  , rating    : 9
                  }
                , { name      : "MySQL"
                  , rating    : 7
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
                  , rating    : 9
                  }
                , { name      : "NixOS"
                  , rating    : 9
                  }
                , { name      : "Debian GNU/Linux"
                  , rating    : 10
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
                  , rating    : 7
                  }
                , { name      : choose language
                                { de : "Finanzen"
                                , en : "Financial sector"
                                }
                  , rating    : 7
                  }
                , { name      : choose language
                                { de : "Versicherungen"
                                , en : "Insurance business"
                                }
                  , rating    : 8
                  }
                , { name      : choose language
                                { de : "Computerspiele"
                                , en : "Gaming industry"
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
                  , rating    : 10
                  }
                , { name      : choose language
                                { de : "Englisch"
                                , en : "English"
                                }
                  , rating    : 8
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
    , linkedIcon linkedIconStyleOriginalSize
        "Weiter zur IT-Haftpflicht von Siegfried Weber, Aschaffenburg"
        "https://www.exali.de/siegel/Haftpflicht_Siegel_2_a42d2266a3bae930f0024c87da406fd5.png"
        "http://www.exali.de/siegel/Siegfried-Weber"
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

