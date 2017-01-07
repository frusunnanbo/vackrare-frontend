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
import Slide exposing (createSlide, titleSlide, codeSlide)
import Keyboard
import Counter


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { slides : Slides.Slides (Slide.Slide Counter.Msg Counter.Model)
    , elapsedTime : Int
    , slideModel : Counter.Model
    }


type Msg
    = Forward
    | Back
    | Tick Time.Time
    | Noop
    | CounterMsg Counter.Msg


slides =
    [ createSlide "För hundra år sedan"
    , createSlide "Under mellantiden"
    , createSlide "Nuförtiden"
    , createSlide "The Elm Architecture"
    , codeSlide Counter.code Counter.view 0
    , createSlide "Elm 101"
    , createSlide "Navigating a set of slides"
    , createSlide "Keeping track of time"
    , createSlide "Fetching Stuff from a server"
    ]


init =
    ( { slides = Slides.init titleSlide slides, elapsedTime = 0, slideModel = 0 }, Cmd.none )



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

        CounterMsg countermsg ->
            ( { model | slideModel = Counter.update countermsg model.slideModel }, Cmd.none )



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
view : Model -> Html.Html Msg
view model =
    Html.div []
        [ Html.map CounterMsg (slide model)
        , navigation model
        , elapsed model
        ]


slide model =
    div [ id Styles.Slide ] [ model.slides.current.render model.slideModel ]


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
