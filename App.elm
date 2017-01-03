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
    { currentSlide : Int }


type Msg
    = Forward
    | Back



-- UPDATE


update msg model =
    case msg of
        Forward ->
            { model | currentSlide = (model.currentSlide + 1) }

        Back ->
            { model | currentSlide = (model.currentSlide - 1) }



-- VIEW


{ id, class, classList } =
    Html.CssHelpers.withNamespace "main"
view model =
    Html.div []
        [ slide model
        , navigation model
        ]


slide model =
    div [ id Styles.Slide ] [ Slides.slide model.currentSlide ]


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
