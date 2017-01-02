module Main exposing (..)

import Html exposing (h1, div, input, button, span)
import Html.Attributes
import Html.Events
import Html.CssHelpers
import Css exposing (..)
import Css.Elements exposing (body)
import Css.Namespace exposing (namespace)
import Styles
import Slides


main =
    Html.beginnerProgram { model = { currentSlide = 1, baseColor = (hex "FFFFFF") }, view = view, update = update }



-- MODEL


type alias Model =
    { currentSlide : Int, baseColor : Color }


type Msg
    = SetBaseColor String
    | Forward
    | Back



-- UPDATE


update msg model =
    case msg of
        Forward ->
            { model | currentSlide = (model.currentSlide + 1) }

        Back ->
            { model | currentSlide = (model.currentSlide - 1) }

        SetBaseColor color ->
            { model | baseColor = (hex color) }



-- VIEW


{ id, class, classList } =
    Html.CssHelpers.withNamespace "main"
view model =
    Html.div [ Html.Attributes.style (Css.asPairs (myCss model.baseColor)) ]
        [ slide model
        , navigation model
        ]


slide model =
    div [ id Styles.Slide ] [ Slides.slide model.currentSlide ]


theme =
    div [ id Styles.Theme ]
        [ input
            [ Html.Events.onInput SetBaseColor ]
            []
        ]


navigation model =
    div [ id Styles.Navigation ]
        [ button
            [ Html.Events.onClick Back
            , Html.Attributes.disabled (model.currentSlide <= Slides.min)
            ]
            [ Html.text "<" ]
        , span [ id Styles.CurrentSlide ] [ Html.text (toString model.currentSlide) ]
        , button
            [ Html.Events.onClick Forward
            , Html.Attributes.disabled (model.currentSlide >= Slides.max)
            ]
            [ Html.text ">" ]
        ]


myCss baseColor =
    [ backgroundColor baseColor
    ]
