module Main exposing (..)

import Html exposing (h1, div, input, button, span)
import Html.Attributes
import Html.Events
import Html.CssHelpers
import Time exposing (Time, every, second)
import Css exposing (..)
import Css.Elements exposing (body)
import Css.Namespace exposing (namespace)
import Styles
import Slides
import Keyboard


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { currentSlide : Int
    , elapsedTime : Int
    }


type Msg
    = Forward
    | Back
    | Tick Time.Time
    | Noop


init =
    ( { currentSlide = 1, elapsedTime = 0 }, Cmd.none )



-- UPDATE


update msg model =
    case msg of
        Forward ->
            ( { model | currentSlide = (model.currentSlide + 1) }, Cmd.none )

        Back ->
            ( { model | currentSlide = (model.currentSlide - 1) }, Cmd.none )

        Tick time ->
            ( { model | elapsedTime = (model.elapsedTime + 1) }, Cmd.none )

        Noop ->
            ( model, Cmd.none )



-- subscriptions


subscriptions model =
    Sub.batch
        [ every second Tick
        , Keyboard.downs handleKeyPress
        ]


handleKeyPress : Keyboard.KeyCode -> Msg
handleKeyPress keyCode =
    case keyCode of
        13 ->
            Forward

        32 ->
            Forward

        39 ->
            Forward

        37 ->
            Back

        _ ->
            Noop



-- VIEW


{ id, class, classList } =
    Html.CssHelpers.withNamespace ""
view model =
    Html.div []
        [ slide model
        , navigation model
        , elapsed model
        ]


slide model =
    div [ id Styles.Slide ] [ Slides.slide model.currentSlide ]


elapsed model =
    div [ id Styles.Elapsed ]
        [ span [ class [ Styles.DisplayNumber ] ] [ Html.text (toString model.elapsedTime) ]
        ]


navigation model =
    div [ id Styles.Navigation ]
        [ button
            [ Html.Events.onClick Back
            , Html.Attributes.disabled (model.currentSlide <= Slides.min)
            ]
            [ Html.text "<" ]
        , span [ class [ Styles.DisplayNumber ] ] [ Html.text (toString model.currentSlide) ]
        , button
            [ Html.Events.onClick Forward
            , Html.Attributes.disabled (model.currentSlide >= Slides.max)
            ]
            [ Html.text ">" ]
        ]
