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
import Navigation
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
    { slides : Navigation.Model (Slide.Slide Counter.Msg Counter.Model)
    , elapsedTime : Int
    , slideModel : Counter.Model
    }


type Msg
    = NavigationMsg Navigation.Msg
    | Tick Time.Time
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
    ( { slides = Navigation.init titleSlide slides, elapsedTime = 0, slideModel = 0 }, Cmd.none )



-- UPDATE


update msg model =
    case msg of
        NavigationMsg msg ->
            ( { model | slides = Navigation.update msg model.slides }, Cmd.none )

        Tick time ->
            ( { model | elapsedTime = (model.elapsedTime + 1) }, Cmd.none )

        CounterMsg countermsg ->
            ( { model | slideModel = Counter.update countermsg model.slideModel }, Cmd.none )



-- subscriptions


subscriptions model =
    Sub.batch
        [ every second Tick
        , Sub.map NavigationMsg Navigation.subscriptions
        ]



-- VIEW


{ id, class, classList } =
    Html.CssHelpers.withNamespace ""
view : Model -> Html.Html Msg
view model =
    Html.div []
        [ Html.map CounterMsg (slide model)
        , Html.map NavigationMsg (Navigation.view model.slides)
        , elapsed model
        ]


slide model =
    div [ id Styles.Slide ] [ model.slides.current.render model.slideModel ]


elapsed model =
    div [ id Styles.Elapsed ]
        [ span [ class [ Styles.DisplayNumber ] ] [ Html.text (toString model.elapsedTime) ]
        ]
