module Styles exposing (..)

import Css exposing (..)
import Css.Elements exposing (body, button)
import Css.Namespace exposing (namespace)


type CssIds
    = Main
    | Navigation
    | Elapsed
    | Theme
    | Slide
    | CurrentSlide


type CssClasses
    = DisplayNumber


baseColor =
    (rgb 80 165 192)


accentColor =
    (rgb 124 209 42)


accentColor2 =
    (rgb 232 148 9)


foregroundColor =
    (rgb 71 78 79)


slideHeight =
    500


css =
    stylesheet
        [ body
            [ margin (px 0)
            , fontFamilies [ "Helvetica", "Arial", "Sans" ]
            , color foregroundColor
            ]
        , slide
        , theme
        , elapsed
        , navigation
        , navigationButton
        , displayNumber
        ]


slide =
    (#) Slide
        [ box baseColor
        , margin (px 10)
        , height (px slideHeight)
        ]


theme =
    (#) Theme
        [ topBox accentColor
        , position absolute
        , left (px 20)
        , bottom (px 20)
        ]


elapsed =
    (#) Elapsed
        [ topBox accentColor
        , position absolute
        , left (px 20)
        , bottom (px 20)
        ]


navigation =
    (#) Navigation
        [ topBox accentColor
        , position absolute
        , right (px 20)
        , bottom (px 20)
        ]


displayNumber =
    (.) DisplayNumber
        [ display inlineBlock
        , padding (px 5)
        , fontSize (px 24)
        ]


navigationButton =
    button
        [ padding (px 3)
        , fontSize (px 20)
        , color foregroundColor
        , border3 (px 1) solid (darker accentColor 0.2)
        , backgroundColor accentColor
        , padding (px 10)
        , borderRadius (px 6)
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


lightenColor color howMuch =
    let
        adjust =
            percentage (1.0 + howMuch)
    in
        rgb (adjust color.red) (adjust color.green) (adjust color.blue)


darker color howMuch =
    let
        adjust =
            percentage (1.0 - howMuch)
    in
        rgb (adjust color.red) (adjust color.green) (adjust color.blue)


tenPercentDarker color =
    rgb (tenPercentOff color.red) (tenPercentOff color.green) (tenPercentOff color.blue)


tenPercentOff value =
    percentage 0.9 value


percentage percentage value =
    Basics.round (toFloat value * percentage)
