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
import Slide exposing (createSlide)
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
    { slides : Slides.Slides (Slide.Slide Msg)
    , elapsedTime : Int
    }


type Msg
    = Forward
    | Back
    | Tick Time.Time
    | Noop


slides =
    [ createSlide "In the Begining of Time"
    , createSlide "In the Mean Time"
    , createSlide "These Days"
    , createSlide "Whats a webapp, anyway?"
    , createSlide "Elm 101"
    , createSlide "Navigating a set of slides"
    , createSlide "Keeping track of time"
    , createSlide "Fetching Stuff from a server"
    ]


init =
    ( { slides = Slides.init (createSlide "Vackrare frontend med Elm") slides, elapsedTime = 0 }, Cmd.none )



-- UPDATE


update msg model =
    case msg of
        Forward ->
            ( { model | slides = Slides.next model.slides }, Cmd.none )

        Back ->
            ( { model | slides = Slides.previous model.slides }, Cmd.none )

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
    div [ id Styles.Slide ] [ model.slides.current.render ]


elapsed model =
    div [ id Styles.Elapsed ]
        [ span [ class [ Styles.DisplayNumber ] ] [ Html.text (toString model.elapsedTime) ]
        ]


navigation model =
    div [ id Styles.Navigation ]
        [ button
            [ Html.Events.onClick Back ]
            [ Html.text "<" ]
        , span [ class [ Styles.DisplayNumber ] ] [ Html.text (toString (Slides.currentSlide model.slides)) ]
        , button
            [ Html.Events.onClick Forward ]
            [ Html.text ">" ]
        ]
