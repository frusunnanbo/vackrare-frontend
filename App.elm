module Main exposing (..)

import Html
import Html.Attributes
import Html.Events
import Html.CssHelpers
import Styles


main =
    Html.beginnerProgram { model = { theme = Styles.Light, slideNumber = 1 }, view = view, update = update }



-- MODEL


type alias Model =
    { theme : Styles.CssClasses, slideNumber : Int }


type Msg
    = SetSlideNumber String
    | DarkTheme
    | LightTheme



-- UPDATE


update msg model =
    case msg of
        SetSlideNumber number ->
            String.toInt number
                |> Result.withDefault 0
                |> \slideNumber -> { model | slideNumber = 0 }

        DarkTheme ->
            { model | theme = Styles.Dark }

        LightTheme ->
            { model | theme = Styles.Light }



-- VIEW


{ id, class, classList } =
    Html.CssHelpers.withNamespace "main"
view model =
    Html.div [ class [ model.theme ] ]
        [ Html.h1 [] [ Html.text ("Vackrare frontend med Elm. Slide number: " ++ toString model.slideNumber) ]
        , Html.input
            [ Html.Events.onInput SetSlideNumber ]
            []
        , Html.button [ Html.Events.onClick DarkTheme ] []
        ]
