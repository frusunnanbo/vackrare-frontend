module Styles exposing (..)

import Css exposing (..)
import Css.Elements exposing (html, body, h1, button, img, div, a)
import Css.Namespace exposing (namespace)


type CssIds
    = Main
    | Navigation
    | Elapsed
    | Theme
    | Slide
    | CurrentSlide
    | Timer
    | Total


type CssClasses
    = DisplayNumber
    | MainPicture
    | SlideHeading
    | RandomCat
    | BigLink
    | Dash
    | KindaCentered
    | TDiagram
    | TInput
    | TOutput
    | TBottom


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


baseMargin =
    (vh 6)


textContentMargin =
    (Css.rem 3)


css =
    stylesheet
        [ mediaQuery "screen and ( min-width: 1300px )" [ html [ fontSize (pt 17) ] ]
        , mediaQuery "screen and ( min-width: 1600px )" [ html [ fontSize (pt 20) ] ]
        , body
            [ margin (px 0)
            , fontFamilies [ "Courier New", "Mono" ]
            , fontSize (pt 16)
            , color foregroundColor
            , backgroundColor baseColor
            ]
        , slide
        , navigation
        , navigationButton
        , displayNumber
        , randomCat
        , bigLink
        , centered
        , tDiagram
        ]


slide =
    (#) Slide
        [ margin baseMargin
        , descendants
            [ h1
                [ fontSize (Css.rem 3.2)
                , marginLeft textContentMargin
                , marginTop (Css.rem 3)
                ]
            , (.) MainPicture
                [ textAlign center
                , descendants
                    [ img
                        [ maxHeight (vh 70)
                        , maxWidth (vw 90)
                        , verticalAlign middle
                        ]
                    ]
                ]
            , (.) SlideHeading
                [ textAlign left ]
            ]
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


randomCat =
    (.) RandomCat
        [ margin (px 20)
        , descendants
            [ everything
                [ maxHeight (px 400) ]
            ]
        ]


tDiagram =
    (.) TDiagram
        [ display inlineBlock
        , maxWidth (px 310)
        , descendants
            [ (.) TInput
                [ display inlineBlock
                , paddingRight (px 60)
                ]
            , (.) TOutput [ display inlineBlock ]
            , img
                [ maxHeight (px 100)
                ]
            , everything
                [ backgroundColor white
                , padding (px 6)
                ]
            ]
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


bigLink =
    (.) BigLink
        [ marginLeft (Css.rem 4)
        , descendants
            [ (.) Dash [ color accentColor ]
            , a
                [ color foregroundColor
                , textDecoration none
                ]
            , everything
                [ fontWeight bold
                , fontSize (Css.rem 2.3)
                , lineHeight (pct 150)
                ]
            ]
        ]


centered =
    (.) KindaCentered [ kindaCentered ]


kindaCentered =
    mixin
        [ textAlign center
        , marginTop (px 200)
        ]


topBox color =
    mixin
        [ box color
        , borderRadius (px 4)
          --, boxShadow4 (px 2) (px 2) (px 2) (rgb 200 200 200)
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
        , bottom (vh 3)
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
