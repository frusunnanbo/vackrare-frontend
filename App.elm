module Main exposing (..)

import Html


main =
    Html.beginnerProgram { model = 1, view = view, update = update }



-- MODEL


type alias Model =
    Int


type Msg
    = SetSlideNumber Int



-- UPDATE


update msg model =
    case msg of
        SetSlideNumber number ->
            number



-- VIEW


view model =
    Html.text ("Vackrare frontend med Elm. Slide number: " ++ toString model)
