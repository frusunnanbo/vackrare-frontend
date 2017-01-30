module SimpleTimer exposing (Model, Msg, init, update, subscriptions, view)

import Html exposing (..)
import Html.Attributes exposing (style, height, width, id, class)
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
    { elapsed : Int }


init : Model
init =
    { elapsed = 0 }



-- UPDATE


type Msg
    = Tick Time


update : Msg -> Model -> Model
update msg model =
    case msg of
        Tick time ->
            { model | elapsed = model.elapsed + 1 }



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
