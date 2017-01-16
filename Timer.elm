module Timer exposing (Model, Msg, init, update, subscriptions, view)

import Html exposing (..)
import Html.Attributes exposing (style)
import Html.CssHelpers as CssHelpers
import Css exposing (asPairs, width, px)
import Time exposing (Time, every, second)
import Date exposing (fromTime, toTime)
import Result exposing (withDefault)
import Styles


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
    , timeLeft : Time
    }


init : Model
init =
    let
        duration =
            minutes 45
    in
        { targetTime = targetTime "2017-01-16T02:12+01:00"
        , timeLeft = duration
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


update : Msg -> Model -> Model
update msg model =
    case msg of
        Tick time ->
            { model | timeLeft = newTimeLeft time model }


newTimeLeft : Time -> Model -> Time
newTimeLeft time model =
    let
        timeLeft =
            model.targetTime - time
    in
        if timeLeft < 0 then
            0
        else if timeLeft > model.duration then
            model.duration
        else
            timeLeft



-- SUBSCRIPTIONS


subscriptions : Sub Msg
subscriptions =
    every second Tick



-- VIEW


width : Float -> Html.Attribute Msg
width width =
    asPairs [ Css.width (px width) ] |> style


{ id, class, classList } =
    CssHelpers.withNamespace ""
view : Model -> Html Msg
view model =
    div [ id Styles.Timer ]
        [ div [ id Styles.Total ]
            [ div [ id Styles.Elapsed, width (elapsedWidth model) ] []
            , span [ class [ Styles.DisplayNumber ] ]
                [ timeLeftText model |> text ]
            ]
        ]


timeLeftText : Model -> String
timeLeftText model =
    let
        left =
            model.timeLeft
    in
        if left > 0 then
            left |> formatTime
        else
            "Time's up!"


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
    Styles.timerWidth - ((timeLeftPercentage model) * Styles.timerWidth)


timeLeftPercentage : Model -> Float
timeLeftPercentage model =
    model.timeLeft / model.duration


timeLeft : Model -> Time
timeLeft model =
    model.timeLeft
