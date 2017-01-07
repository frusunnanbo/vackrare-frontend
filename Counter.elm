module Counter exposing (code, Msg, Model, update, view)

import Html exposing (..)
import Html.Events exposing (onClick)


main =
    beginnerProgram { model = 0, view = view, update = update }



--- MODEL


type alias Model =
    Int



-- UPDATE


type Msg
    = Increment
    | Decrement


update msg model =
    case msg of
        Increment ->
            model + 1

        Decrement ->
            model - 1



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick Decrement ] [ text "-" ]
        , div [] [ text (toString model) ]
        , button [ onClick Increment ] [ text "+" ]
        ]



--- OTHER STUFF


code =
    """
main =
    beginnerProgram { model = 0, view = view, update = update }



--- MODEL


type alias Model =
    Int



-- UPDATE


type Msg
    = Increment
    | Decrement


update msg model =
    case msg of
        Increment ->
            model + 1

        Decrement ->
            model - 1



-- VIEW


view model =
    div []
        [ button [ onClick Decrement ] [ text "-" ]
        , div [] [ text (toString model) ]
        , button [ onClick Increment ] [ text "+" ]
        ]

  """