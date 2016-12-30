module Styles exposing (..)

import Css exposing (..)
import Css.Elements exposing (body)
import Css.Namespace exposing (namespace)


type CssIds
    = Main
    | Navigation
    | Theme
    | Slide


baseColor =
    (rgb 80 165 192)


foregroundColor =
    (rgb 124 209 42)


slideHeight =
    500


css =
    stylesheet
        [ body
            [ margin (px 0)
            , fontFamilies [ "Helvetica", "Arial", "Sans" ]
            ]
        , slide
        , theme
        , navigation
        ]


slide =
    (#) Slide
        [ box baseColor
        , margin (px 10)
        , height (px slideHeight)
        ]


theme =
    (#) Theme
        [ topBox foregroundColor
        , position absolute
        , left (px 20)
        , bottom (px 20)
        ]


navigation =
    (#) Navigation
        [ topBox foregroundColor
        , position absolute
        , right (px 20)
        , bottom (px 20)
        ]


topBox color =
    mixin
        [ box color
        , boxShadow4 (px 2) (px 2) (px 2) (rgb 200 200 200)
        ]


box color =
    mixin
        [ border3 (px 3) solid (tenPercentDarker color)
        , backgroundColor color
        , padding (px 20)
        ]


tenPercentDarker color =
    rgb (tenPercentOff color.red) (tenPercentOff color.green) (tenPercentOff color.blue)


tenPercentOff value =
    Basics.round (toFloat value * 0.9)
