module Styles exposing (..)

import Css exposing (..)
import Css.Elements exposing (body)
import Css.Namespace exposing (namespace)


type CssClasses
    = Dark
    | Light


css =
    (stylesheet << namespace "main")
        [ (.) Dark [ backgroundColor (hex "333333") ]
        , (.) Light [ backgroundColor (hex "EEEEEE") ]
        , (#) "main" [ padding (px 10) ]
        ]
