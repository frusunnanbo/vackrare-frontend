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
            [ fontSize (px 72)
            , fontWeight bold
            , marginTop (px 150)
            , textAlign center
            , descendants
                [ everything
                    [ verticalAlign middle
                    , textAlign left
                    ]
                , div [ display inlineBlock, maxWidth (pct 75) ]
                , img [ marginRight (px 30) ]
                ]
            ]
        , (.) AboutMe
            [ bottomOfSlide
            , fontSize (px 20)
            , fontWeight bold
            , lineHeight (px 4)
            ]
        , (.) Logo
            [ bottomOfSlide
            , right (px 50)
            , padding (px 20)
            , children
                [ img [ height (px 50) ] ]
            ]
        ]
