module Twitter exposing (slide, init, update, view, Msg, Model)

import Html exposing (..)
import Html.Events exposing (onInput, onClick)
import Html.Attributes exposing (id, for)
import Http exposing (Error, send, getString)


slide =
    { render = view }


url =
    "https://api.twitter.com/1.1/search/tweets.json?"


tag =
    "#brexit"


token =
    "SECRET"



-- MODEL


type alias Model =
    { tag : String, token : String, tweet : String }


init : Model
init =
    { tag = "", token = "", tweet = "" }



-- UPDATE


type Msg
    = NewTag String
    | NewToken
    | Submit
    | Response (Result Error String)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NewTag tag ->
            ( { model | tag = tag }, Cmd.none )

        NewToken ->
            ( model, Cmd.none )

        Submit ->
            ( model, Http.send Response (Http.getString url) )

        Response result ->
            case result of
                Ok response ->
                    ( { model | tweet = response }, Cmd.none )

                Err error ->
                    ( { model | tweet = "Error!" }, Cmd.none )



-- SUBSCRIPTIONS
-- VIEW


view model =
    div []
        [ label [ for "tagInput" ] [ text "Hashtag #" ]
        , input [ onInput NewTag ] []
        , button [ onClick Submit ] [ text "Search Twitter" ]
        , text model.tweet
        ]
