module Styles exposing (..)

import Css exposing (..)
import Css.Elements exposing (body, button, img, div)
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
    600


timerHeight =
    40


timerWidth =
    200


css =
    stylesheet
        [ body
            [ margin (px 0)
            , fontFamilies [ "Courier New", "Mono" ]
            , fontSize (pt 14)
            , color foregroundColor
            ]
        , slide
        , theme
        , elapsed
        , navigation
        , navigationButton
        , title
        , logo
        , displayNumber
        ]


slide =
    (#) Slide
        [ box baseColor
        , paddingLeft (px 30)
        , margin (px 10)
        , height (px slideHeight)
        , descendants
            [ (.) AboutMe
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
                        [ maxHeight (px (slideHeight - 100))
                        , maxWidth (pct 90)
                        , verticalAlign middle
                        ]
                    ]
                ]
            , (.) SlideHeading
                [ textAlign left ]
            , (.) CodeSlide codeSlide
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


theme =
    (#) Theme
        [ topBox accentColor
        , position absolute
        , left (px 20)
        , bottom (px 20)
        ]


elapsed =
    (#) Timer
        [ topBox accentColor
        , position absolute
        , left (px 20)
        , bottom (px 20)
        , descendants
            [ (#) Total
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
