module Styles exposing (..)

import Css exposing (..)
import Css.Elements exposing (body)
import Css.Namespace exposing (namespace)


type CssIds
    = Main
    | Navigation
    | Theme
    | Slide


css =
    stylesheet
        [ body
            [ margin (px 0)
            , fontFamilies [ "Helvetica", "Arial", "Sans" ]
            ]
        , (#) Main [ displayFlex, flexFlow1 column, height (pct 100), width (pct 100) ]
        , (#) Slide [ border3 (px 1) solid (hex "#111111"), height (px 300), width (pct 90) ]
        , (#) Theme [ position absolute, left (px 10), bottom (px 10) ]
        , (#) Navigation [ position absolute, right (px 10), bottom (px 10) ]
        ]
