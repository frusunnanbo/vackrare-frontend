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
    { now : Time
    , duration : Time
    , targetTime : Time
    }


init : Model
init =
    let
        targetTime =
            Date.fromString "2017-01-15T22:00+01:00"
                |> withDefault (fromTime 1484513103000)
                |> toTime

        duration =
            45 * 60 * 1000
    in
        { targetTime = targetTime
        , now = 0
        , duration = duration
        }



-- UPDATE


type Msg
    = Tick Time


update : Msg -> Model -> Model
update msg model =
    case msg of
        Tick time ->
            { model | now = time }



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
                [ timeLeft model |> formatTime |> text ]
            ]
        ]


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
    Styles.timerWidth - (timeLeftPercentage model * Styles.timerWidth)


timeLeftPercentage : Model -> Float
timeLeftPercentage model =
    (timeLeft model) / model.duration


timeLeft : Model -> Time
timeLeft model =
    model.targetTime - model.now
