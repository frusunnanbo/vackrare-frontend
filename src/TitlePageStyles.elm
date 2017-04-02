module TitlePageStyles exposing (..)

import Css exposing (..)
import Css.Elements exposing (body, h1, button, img, div, a)
import Css.Namespace exposing (namespace)
import Styles exposing (bottomOfSlide)


type CssClasses
    = Title
    | AboutMe
    | Logo


css =
    stylesheet
        [ (.) Title
            [ fontSize (Css.rem 4)
            , fontWeight bold
            , marginTop (vh 23)
            , marginLeft (vw 7)
            , descendants
                [ everything
                    [ verticalAlign middle
                    , textAlign left
                    ]
                , div [ display inlineBlock, maxWidth (pct 75) ]
                , img
                    [ marginRight (Css.rem 2.0)
                    , maxWidth (vw 17)
                    ]
                ]
            ]
        , (.) AboutMe
            [ bottomOfSlide
            , fontSize (Css.rem 1.3)
            , fontWeight bold
            , lineHeight (Css.rem 0.2)
            ]
        , (.) Logo
            [ bottomOfSlide
            , right (vw 5)
            , padding (Css.rem 1)
            , children
                [ img [ height (vw 5) ] ]
            ]
        ]
