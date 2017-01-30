module Styles exposing (..)

import Css exposing (..)
import Css.Elements exposing (body, h1, button, img, div, a)
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
    | Title
    | AboutMe
    | Logo
    | MainPicture
    | SlideHeading
    | CodeSlide
    | Code
    | Compiled
    | BigLink


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
    700


timerHeight =
    40


timerWidth =
    200


css =
    stylesheet
        [ body
            [ margin (px 0)
            , padding (px 20)
            , fontFamilies [ "Courier New", "Mono" ]
            , fontSize (pt 14)
            , color foregroundColor
            , backgroundColor baseColor
            ]
        , slide
        , timer
        , total
        , navigation
        , navigationButton
        , title
        , logo
        , displayNumber
        ]


slide =
    (#) Slide
        [ paddingLeft (px 30)
        , margin (px 10)
        , height (px slideHeight)
        , descendants
            [ h1 [ fontSize (em 3.0) ]
            , (.) AboutMe
                [ bottomOfSlide
                , fontSize (px 20)
                , fontWeight bold
                , lineHeight (px 4)
                ]
            , (.) MainPicture
                [ textAlign center
                , height (px (slideHeight - 100))
                , verticalAlign middle
                , descendants
                    [ img
                        [ maxHeight (pct 90)
                        , maxWidth (pct 90)
                        , verticalAlign middle
                        ]
                    ]
                ]
            , (.) SlideHeading
                [ textAlign left ]
            , (.) CodeSlide codeSlide
            , (.) BigLink bigLink
            ]
        ]


codeSlide =
    [ children
        [ div
            [ height (px (slideHeight - 100))
            , display inlineBlock
            , padding (px 10)
            , border3 (px 4) solid elmLightBlue
            , borderRadius (px 3)
            , backgroundColor foregroundColor
            , color baseColor
            , verticalAlign top
            ]
        , (.) Code
            [ overflow scroll
            , width (pct 75)
            ]
        , (.) Compiled
            [ display inlineBlock
            , width (pct 15)
            , marginLeft (pct 2)
            , textAlign center
            , descendants
                [ everything [ marginTop (pct 20) ]
                ]
            ]
        ]
    ]


timer =
    (#) Timer
        [ topBox accentColor
        , position absolute
        , left (px 20)
        , bottom (px 20)
        ]


total =
    (#) Total
        [ width (px timerWidth)
        , height (px timerHeight)
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


bigLink =
    [ margin (px 20)
    , descendants
        [ a
            [ color foregroundColor
            , textDecoration none
            , fontWeight bold
            , fontSize (px 42)
            ]
        ]
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
        , bottom (px 110)
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
