module Styles exposing (css, CssIds)

import Css exposing (..)
import Css.Elements exposing (body)
import Css.Namespace exposing (namespace)


type CssIds
    = Main
    | Navigation
    | Theme
    | Slide


slideHeight =
    500


css =
    stylesheet
        [ body
            [ margin (px 0)
            , fontFamilies [ "Helvetica", "Arial", "Sans" ]
            ]
        , (#) Main [ displayFlex, flexFlow1 column, height (pct 100), width (pct 100) ]
        , slide
        , (#) Theme [ position absolute, left (px 10), bottom (px 10) ]
        , (#) Navigation [ position absolute, right (px 10), bottom (px 10) ]
        ]


slide =
    (#) Slide
        [ margin (px 10)
        , padding (px 20)
        , border3 (px 3) solid (hex "#CCCCCC")
        , height (px slideHeight)
        ]
