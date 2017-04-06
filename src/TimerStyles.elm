module TimerStyles exposing (CssIds(..), CssClasses(..), css, timerWidth)

import Css exposing (..)
import Css.Elements exposing (html, body, h1, button, img, div, span, a)
import Css.Namespace exposing (namespace)
import Styles exposing (topBox, accentColor, baseColor, darker)


type CssIds
    = Elapsed
    | Timer
    | Total


type CssClasses
    = DisplayNumber


timerWidth =
    16


timerHeight =
    (vh 5)


css =
    (stylesheet << namespace "timer")
        [ (#) Timer
            [ position absolute
            , right (vw 3)
            , top (vw 3)
            ]
        , (#) Total
            [ width (vw timerWidth)
            , height timerHeight
            , backgroundColor baseColor
            , border3 (px 1) solid (darker accentColor 0.2)
            , borderRadius (px 4)
            , descendants
                [ (#) Elapsed
                    [ backgroundColor accentColor
                    , height timerHeight
                    , display inlineBlock
                    , borderRadius (px 4)
                    ]
                , span
                    [ display inlineBlock
                    , padding (Css.rem 0.3)
                    , fontSize (Css.rem 1.4)
                    ]
                , everything [ position absolute ]
                ]
            ]
        , (.) DisplayNumber
            []
        ]
