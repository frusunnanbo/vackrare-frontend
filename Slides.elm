module Slides exposing (slide)

import Html


slide number =
    case number of
        1 ->
            Html.text "This is the first slide"

        2 ->
            Html.text "This is the second slide"

        _ ->
            Html.text "This slide is not supported"
