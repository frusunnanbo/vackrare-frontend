module Main exposing (..)

import Html exposing (h1, div, input, button, span)
import Html.CssHelpers
import Time exposing (Time, every, second)
import Styles
import Navigation
import Timer
import Slide exposing (createSlide, titleSlide, pictureSlide, codeSlide)
import Counter


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias SlideModel =
    { counterModel : Counter.Model }


type alias Model =
    { slides : Navigation.Model (Slide.Slide SlideMsg SlideModel)
    , timerModel : Timer.Model
    , slideModel : SlideModel
    }


slides slideModel =
    [ pictureSlide "För hundra år sedan" [ "piolinsidan.png", "beginning_of_time.jpg" ]
    , pictureSlide "Under mellantiden" [ "mean_time.jpg" ]
    , pictureSlide "Nuförtiden" [ "elm_discovery.jpg" ]
    , createSlide "The Elm Architecture"
    , codeSlide Counter.code counterSlideView slideModel
    , createSlide "Elm 101"
    , createSlide "Navigating a set of slides"
    , createSlide "Keeping track of time"
    ]


counterSlideView : SlideModel -> Html.Html SlideMsg
counterSlideView model =
    Html.map CounterMsg (Counter.view model.counterModel)


init : ( Model, Cmd Msg )
init =
    let
        ( slideModel, slideCmd ) =
            initSlides
    in
        ( { slides = Navigation.init titleSlide (slides slideModel)
          , timerModel = Timer.init
          , slideModel = slideModel
          }
        , Cmd.map SlideComponentMsg slideCmd
        )


initSlides : ( SlideModel, Cmd SlideMsg )
initSlides =
    ( { counterModel = 0 }, Cmd.none )



-- UPDATE


type SlideMsg
    = CounterMsg Counter.Msg


type Msg
    = NavigationMsg Navigation.Msg
    | TimerMsg Timer.Msg
    | SlideComponentMsg SlideMsg


update msg model =
    case msg of
        TimerMsg msg ->
            ( { model | timerModel = Timer.update msg model.timerModel }, Cmd.none )

        NavigationMsg msg ->
            ( { model | slides = Navigation.update msg model.slides }, Cmd.none )

        SlideComponentMsg slideMsg ->
            let
                ( slideModel, slideCmd ) =
                    updateSlide slideMsg model.slideModel
            in
                ( { model | slideModel = slideModel }, Cmd.map SlideComponentMsg slideCmd )


updateSlide : SlideMsg -> SlideModel -> ( SlideModel, Cmd SlideMsg )
updateSlide msg model =
    case msg of
        CounterMsg counterMsg ->
            ( { model | counterModel = Counter.update counterMsg model.counterModel }, Cmd.none )



-- subscriptions


subscriptions model =
    Sub.batch
        [ Sub.map TimerMsg Timer.subscriptions
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
        , Html.map TimerMsg (Timer.view model.timerModel)
        ]


slide : Model -> SlideModel -> Html.Html SlideMsg
slide bigmodel model =
    Html.div [ id Styles.Slide ] [ bigmodel.slides.current.render model ]
