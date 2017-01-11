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


type alias SlideModel =
    { counterModel : Counter.Model, twitterModel : Twitter.Model }


type alias Model =
    { slides : Navigation.Model (Slide.Slide SlideMsg SlideModel)
    , elapsedTime : Int
    , slideModel : SlideModel
    }


slides =
    [ createSlide "För hundra år sedan"
    , createSlide "Under mellantiden"
    , createSlide "Nuförtiden"
    , createSlide "The Elm Architecture"
    , codeSlide Counter.code counterSlideView initSlideModel
    , createSlide "Elm 101"
    , createSlide "Navigating a set of slides"
    , createSlide "Keeping track of time"
    , codeSlide "<code>" twitterSlideView initSlideModel
    ]


counterSlideView : SlideModel -> Html.Html SlideMsg
counterSlideView model =
    Html.map CounterMsg (Counter.view model.counterModel)


twitterSlideView : SlideModel -> Html.Html SlideMsg
twitterSlideView model =
    Html.map TwitterMsg (Twitter.view model.twitterModel)


init =
    ( { slides = Navigation.init titleSlide slides, elapsedTime = 0, slideModel = initSlideModel }, Cmd.none )


initSlideModel =
    { counterModel = 0, twitterModel = Twitter.init }



-- UPDATE


type SlideMsg
    = CounterMsg Counter.Msg
    | TwitterMsg Twitter.Msg


type Msg
    = NavigationMsg Navigation.Msg
    | Tick Time.Time
    | SlideComponentMsg SlideMsg


update msg model =
    case msg of
        NavigationMsg msg ->
            ( { model | slides = Navigation.update msg model.slides }, Cmd.none )

        Tick time ->
            ( { model | elapsedTime = (model.elapsedTime + 1) }, Cmd.none )

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

        TwitterMsg twitterMsg ->
            let
                ( twitterModel, cmd ) =
                    Twitter.update twitterMsg model.twitterModel
            in
                ( { model | twitterModel = twitterModel }, Cmd.map TwitterMsg cmd )



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


slide : Model -> SlideModel -> Html.Html SlideMsg
slide bigmodel model =
    Html.div [ id Styles.Slide ] [ bigmodel.slides.current.render model ]


elapsed model =
    div [ id Styles.Elapsed ]
        [ span [ class [ Styles.DisplayNumber ] ] [ Html.text (toString model.elapsedTime) ]
        ]
