module Styles exposing (..)

import Css exposing (..)
import Css.Elements exposing (body, button, img)
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
    | Title
    | AboutMe
    | Logo


white =
    (rgb 255 255 255)


elmLightBlue =
    (rgb 80 165 192)


elmDarkBlue =
    (rgb 71 78 79)


elmGreen =
    (rgb 124 209 42)


elmOrange =
    (rgb 232 148 9)


baseColor =
    elmDarkBlue


accentColor =
    elmGreen


foregroundColor =
    white


slideHeight =
    500


css =
    stylesheet
        [ body
            [ margin (px 0)
            , fontFamilies [ "Courier New", "Mono" ]
            , color foregroundColor
            ]
        , slide
        , theme
        , elapsed
        , navigation
        , navigationButton
        , title
        , aboutMe
        , logo
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


title =
    (.) Title
        [ fontSize (px 72)
        , fontWeight bold
        , marginTop (px 150)
        , marginLeft (px 100)
        ]


aboutMe =
    (.) AboutMe
        [ bottomOfSlide
        , fontSize (px 20)
        , fontWeight bold
        , lineHeight (px 4)
        ]


logo =
    (.) Logo
        [ bottomOfSlide
        , right (px 50)
        , padding (px 20)
        , children
            [ img [ height (px 50) ] ]
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


bottomOfSlide =
    mixin
        [ position absolute
        , top (px (slideHeight - 50))
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
