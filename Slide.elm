module Slide exposing (Slide, createSlide, renderHeadingSlide)

import Html exposing (..)


type alias Slide msg =
    { heading : String
    , render : Html msg
    }


createSlide : String -> Slide msg
createSlide heading =
    { heading = heading
    , render = renderHeadingSlide heading
    }


renderHeadingSlide : String -> Html msg
renderHeadingSlide heading =
    h1 [] [ text heading ]
