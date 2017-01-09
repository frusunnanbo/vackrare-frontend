module Main exposing (..)

import Html exposing (h1, div, input, button, span)
import Html.CssHelpers
import Time exposing (Time, every, second)
import Styles
import Navigation
import Slide exposing (createSlide, titleSlide, codeSlide)
import Keyboard
import Counter
import Twitter


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { slides : Navigation.Model (Slide.Slide SlideMsg Counter.Model)
    , elapsedTime : Int
    , slideModel : Counter.Model
    }


type SlideMsg
    = CounterMsg Counter.Msg
    | TwitterMsg Twitter.Msg


type Msg
    = NavigationMsg Navigation.Msg
    | Tick Time.Time
    | SlideComponentMsg SlideMsg


slides =
    [ createSlide "För hundra år sedan"
    , createSlide "Under mellantiden"
    , createSlide "Nuförtiden"
    , createSlide "The Elm Architecture"
    , codeSlide Counter.code (convert Counter.view) 0
    , createSlide "Elm 101"
    , createSlide "Navigating a set of slides"
    , createSlide "Keeping track of time"
      ---, Twitter.slide
    ]


convert : (Counter.Model -> Html.Html Counter.Msg) -> (Counter.Model -> Html.Html SlideMsg)
convert counterView =
    Html.map CounterMsg << counterView


init =
    ( { slides = Navigation.init titleSlide slides, elapsedTime = 0, slideModel = 0 }, Cmd.none )



-- UPDATE


update msg model =
    case msg of
        NavigationMsg msg ->
            ( { model | slides = Navigation.update msg model.slides }, Cmd.none )

        Tick time ->
            ( { model | elapsedTime = (model.elapsedTime + 1) }, Cmd.none )

        SlideComponentMsg slideMsg ->
            ( { model | slideModel = updateSlide slideMsg model.slideModel }, Cmd.none )


updateSlide msg slideModel =
    case msg of
        CounterMsg counterMsg ->
            Counter.update counterMsg slideModel

        TwitterMsg twitterMsg ->
            slideModel



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
        [ Html.map SlideComponentMsg (slide model model.slideModel)
        , Html.map NavigationMsg (Navigation.view model.slides)
        , elapsed model
        ]


slide : Model -> Counter.Model -> Html.Html SlideMsg
slide bigmodel model =
    Html.div [ id Styles.Slide ] [ bigmodel.slides.current.render model ]


elapsed model =
    div [ id Styles.Elapsed ]
        [ span [ class [ Styles.DisplayNumber ] ] [ Html.text (toString model.elapsedTime) ]
        ]
