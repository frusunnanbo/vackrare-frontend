module Timer exposing (Model, Msg, init, update, subscriptions, view)

import Html exposing (..)
import Html.Attributes exposing (style)
import Html.CssHelpers as CssHelpers
import Css exposing (asPairs, width, px)
import Time exposing (Time, every, second)
import Date exposing (fromTime, toTime)
import Result exposing (withDefault)
import TimerStyles exposing (CssClasses(..), CssIds(..), timerWidth)


main =
    program
        { init = ( init, Cmd.none )
        , update = \msg model -> ( update msg model, Cmd.none )
        , subscriptions = always subscriptions
        , view = view
        }



-- MODEL


type alias Model =
    { duration : Time
    , targetTime : Time
    , timeLeft : TimeLeft
    }


init : Model
init =
    let
        duration =
            minutes 2880
    in
        { targetTime = targetTime "2017-04-07T09:55+02:00"
        , timeLeft = NotStarted
        , duration = duration
        }


targetTime : String -> Time
targetTime dateString =
    Date.fromString dateString
        |> withDefault (fromTime 1484513103000)
        |> toTime


minutes : Int -> Time
minutes minutes =
    minutes * 60 * 1000 |> toFloat



-- UPDATE


type Msg
    = Tick Time


type TimeLeft
    = NotStarted
    | Left Time
    | TimesUp


update : Msg -> Model -> Model
update msg model =
    case msg of
        Tick time ->
            { model | timeLeft = newTimeLeft time model }


newTimeLeft : Time -> Model -> TimeLeft
newTimeLeft time model =
    let
        timeLeft =
            model.targetTime - time
    in
        if timeLeft < 0 then
            TimesUp
        else if timeLeft > model.duration then
            NotStarted
        else
            Left timeLeft



-- SUBSCRIPTIONS


subscriptions : Sub Msg
subscriptions =
    every second Tick



-- VIEW


width : Float -> Html.Attribute Msg
width width =
    asPairs [ Css.width (px width) ] |> style


{ id, class, classList } =
    CssHelpers.withNamespace "timer"
view : Model -> Html Msg
view model =
    div [ id Timer ]
        [ div [ id Total ]
            [ div [ id Elapsed, width (elapsedWidth model) ] []
            , span [ class [ DisplayNumber ] ]
                [ timeLeftText model |> text ]
            ]
        ]


timeLeftText : Model -> String
timeLeftText model =
    let
        left =
            model.timeLeft
    in
        case model.timeLeft of
            TimesUp ->
                "Time's up!"

            NotStarted ->
                "Not started."

            Left time ->
                time |> formatTime


formatTime : Time -> String
formatTime time =
    (time
        |> minuteOf
        |> padLeft
    )
        ++ ":"
        ++ (time
                |> secondOf
                |> padLeft
           )


padLeft : Int -> String
padLeft time =
    if time < 10 then
        "0" ++ toString time
    else
        toString time


minuteOf : Time -> Int
minuteOf time =
    time |> timeUnitOf Date.minute


secondOf : Time -> Int
secondOf time =
    time |> timeUnitOf Date.second


timeUnitOf : (Date.Date -> Int) -> Time -> Int
timeUnitOf extractor time =
    time
        |> fromTime
        |> extractor


elapsedWidth : Model -> Float
elapsedWidth model =
    timerWidth - ((timeLeftPercentage model) * timerWidth)


timeLeftPercentage : Model -> Float
timeLeftPercentage model =
    case model.timeLeft of
        NotStarted ->
            1

        TimesUp ->
            0

        Left time ->
            time / model.duration


timeLeft : Model -> TimeLeft
timeLeft model =
    model.timeLeft
