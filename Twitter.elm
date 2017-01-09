module Twitter exposing (slide, init, Msg, Model)

import Html exposing (..)
import Html.Events exposing (onInput)
import Html.Attributes exposing (id, for)


slide =
    { render = view }


url =
    "https://api.twitter.com/1.1/search/tweets.json?"


tag =
    "#brexit"


token =
    "AAAAAAAAAAAAAAAAAAAAAOxryQAAAAAAghznPFyzH%2BzdHNLxMgw3NnWKgC0%3DypXZqCdGy1WN4Ft3dwxIWdHPE2uCw0qlQ12sMT6hEaRHFDOGjc"



-- MODEL


type alias Model =
    { tag : String, token : String }


init : Model
init =
    { tag = "", token = "" }



-- UPDATE


type Msg
    = NewTag String
    | NewToken
    | Submit


update : Msg -> Model -> Model
update msg model =
    case msg of
        NewTag tag ->
            model

        NewToken ->
            model

        Submit ->
            model



-- SUBSCRIPTIONS
-- VIEW


view model =
    div []
        [ label [ for "tagInput" ] [ text "Hashtag #" ]
        , input [ onInput NewTag ] []
        , text "This is where the latest #elm Twitter status goes."
        ]
