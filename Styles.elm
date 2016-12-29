module Styles exposing (..)

import Css exposing (..)
import Css.Elements exposing (body)
import Css.Namespace exposing (namespace)


css =
    stylesheet
        [ body [ margin (px 0) ]
        , (#) "main" [ displayFlex, flexFlow1 column, height (pct 100), width (pct 100) ]
        ]
