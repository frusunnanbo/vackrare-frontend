module TimerStyles exposing (CssIds(..), CssClasses(..), css, timerHeight, timerWidth)

import Css exposing (..)
import Css.Elements exposing (html, body, h1, button, img, div, a)
import Css.Namespace exposing (namespace)
import Styles exposing (topBox, accentColor, baseColor, darker)


type CssIds
    = Elapsed
    | Timer
    | Total


type CssClasses
    = DisplayNumber


timerHeight =
    40


timerWidth =
    200


css =
    (stylesheet << namespace "timer")
        [ (#) Timer
            [ position absolute
            , right (vw 0)
            , top (vh 0)
            ]
        , (#) Total
            [ width (px timerWidth)
            , height (px timerHeight)
            , margin (vw 3)
            , backgroundColor baseColor
            , border3 (px 1) solid (darker accentColor 0.2)
            , borderRadius (px 4)
            , descendants
                [ (#) Elapsed
                    [ backgroundColor accentColor
                    , height (px timerHeight)
                    , width (px (timerWidth - 100))
                    , display inlineBlock
                    , borderRadius (px 4)
                    ]
                , everything [ position absolute ]
                ]
            ]
        , (.) DisplayNumber
            [ display inlineBlock
            , padding (px 5)
            , fontSize (px 24)
            ]
        ]
