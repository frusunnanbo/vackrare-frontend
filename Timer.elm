module Timer exposing (Model, Msg, init, update, subscriptions, view)

import Html exposing (..)
import Html.Attributes exposing (style)
import Html.CssHelpers as CssHelpers
import Css exposing (asPairs, width, px)
import Time exposing (Time, every, second)
import Date exposing (fromTime)
import Styles


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
            1484509336000

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
    formatMinute time
        ++ ":"
        ++ formatSecond time


formatMinute : Time -> String
formatMinute time =
    time
        |> fromTime
        |> Date.minute
        |> toString


formatSecond : Time -> String
formatSecond time =
    let
        seconds =
            secondOf time
    in
        if seconds < 10 then
            "0" ++ toString seconds
        else
            toString seconds


secondOf : Time -> Int
secondOf time =
    time
        |> fromTime
        |> Date.second


elapsedWidth : Model -> Float
elapsedWidth model =
    Styles.timerWidth - (timeLeftPercentage model * Styles.timerWidth)


timeLeftPercentage : Model -> Float
timeLeftPercentage model =
    (timeLeft model) / model.duration


timeLeft : Model -> Time
timeLeft model =
    model.targetTime - model.now
