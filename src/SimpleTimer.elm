module SimpleTimer exposing (Model, Msg, init, update, subscriptions, view)

import Html exposing (..)
import Html.Attributes exposing (style, height, width, id, class)
import Html.CssHelpers as CssHelpers
import Time exposing (Time, every, second)
import Date exposing (fromTime, toTime)
import Result exposing (withDefault)
import TimerStyles exposing (CssIds(..), CssClasses(..))


{ id, class, classList } =
    CssHelpers.withNamespace "timer"
main =
    program
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }



-- MODEL


type alias Model =
    Int


init : ( Model, Cmd Msg )
init =
    ( 0, Cmd.none )



-- UPDATE


type Msg
    = Tick Time


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick _ ->
            ( model + 1, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    every second Tick



-- VIEW


view : Model -> Html Msg
view model =
    div [ id Total ]
        [ div [ id Elapsed, style [ ( "width", (model |> toString) ++ "px" ) ] ] []
        , span [ class [ DisplayNumber ] ]
            [ model |> minuteOf |> toString |> String.pad 2 '0' |> text
            , ":" |> text
            , model |> secondOf |> toString |> String.pad 2 '0' |> text
            ]
        ]


minuteOf : Int -> Int
minuteOf time =
    time // 60


secondOf : Int -> Int
secondOf time =
    time % 60
