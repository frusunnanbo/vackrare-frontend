module Main exposing (..)

import Html exposing (h1, div, input, button)
import Html.Attributes
import Html.Events
import Html.CssHelpers
import Css exposing (..)
import Css.Elements exposing (body)
import Css.Namespace exposing (namespace)
import Styles


main =
    Html.beginnerProgram { model = { theme = Styles.Light, slideNumber = 1, baseColor = (hex "FFFFFF") }, view = view, update = update }



-- MODEL


type alias Model =
    { theme : Styles.CssClasses, slideNumber : Int, baseColor : Color }


type Msg
    = SetSlideNumber String
    | SetBaseColor String
    | DarkTheme
    | LightTheme


makeColor : String -> Color
makeColor hexString =
    hex hexString



-- UPDATE


update msg model =
    case msg of
        SetSlideNumber number ->
            String.toInt number
                |> Result.withDefault 0
                |> \slideNumber -> { model | slideNumber = 0 }

        SetBaseColor hexString ->
            { model | baseColor = (hex hexString) }

        DarkTheme ->
            { model | theme = Styles.Dark }

        LightTheme ->
            { model | theme = Styles.Light }



-- VIEW


{ id, class, classList } =
    Html.CssHelpers.withNamespace "main"
view model =
    Html.div [ Html.Attributes.style (Css.asPairs (myCss model.baseColor)) ]
        [ h1 [] [ Html.text ("Vackrare frontend med Elm. Slide number: " ++ toString model.slideNumber) ]
        , input
            [ Html.Events.onInput SetSlideNumber ]
            []
        , input
            [ Html.Events.onInput SetBaseColor ]
            []
        , button [ Html.Events.onClick DarkTheme ] [ Html.text "Dark" ]
        , button [ Html.Events.onClick LightTheme ] [ Html.text "Light" ]
        ]


myCss baseColor =
    [ backgroundColor baseColor
    ]
