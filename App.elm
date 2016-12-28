module Main exposing (..)

import Html
import Html.Events


main =
    Html.beginnerProgram { model = 1, view = view, update = update }



-- MODEL


type alias Model =
    Int


type Msg
    = SetSlideNumber String



-- UPDATE


update msg model =
    case msg of
        SetSlideNumber number ->
            String.toInt number
                |> Result.withDefault 0



-- VIEW


view model =
    Html.div []
        [ Html.text ("Vackrare frontend med Elm. Slide number: " ++ toString model)
        , Html.input
            [ Html.Events.onInput SetSlideNumber ]
            []
        ]
