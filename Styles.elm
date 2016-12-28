module Styles exposing (css)

import Css exposing (..)
import Css.Elements exposing (body)


css =
    stylesheet [ body [ backgroundColor (hex "CCFFFF") ] ]
