module SimpleTimer exposing (Model, Msg, init, update, subscriptions, view)

import Html exposing (..)
import Html.Attributes exposing (style, height, width, id, class)
import Time exposing (Time, every, second)
import Date exposing (fromTime, toTime)
import Result exposing (withDefault)
import Styles


main =
    program
        { init = init
        , update = update
        , subscriptions = always subscriptions
        , view = view
        }



-- MODEL


type alias Model =
    { elapsed : Int }


init : ( Model, Cmd Msg )
init =
    ( { elapsed = 0 }, Cmd.none )



-- UPDATE


type Msg
    = Tick Time


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick _ ->
            ( { model | elapsed = model.elapsed + 1 }, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Sub Msg
subscriptions =
    every second Tick



-- VIEW


view : Model -> Html Msg
view model =
    div [ id "Total" ]
        [ div [ id "Elapsed", style [ ( "width", (model.elapsed |> toString) ++ "px" ) ] ] []
        , span [ class "DisplayNumber" ]
            [ model.elapsed |> minuteOf |> toString |> String.pad 2 '0' |> text
            , ":" |> text
            , model.elapsed |> secondOf |> toString |> String.pad 2 '0' |> text
            ]
        ]


minuteOf : Int -> Int
minuteOf time =
    time // 60


secondOf : Int -> Int
secondOf time =
    time % 60
