module Twitter exposing (slide, init, update, view, Msg, Model)

import Html exposing (..)
import Html.Events exposing (onInput, onClick)
import Html.Attributes exposing (id, for)
import Http exposing (Error(..), send, getString)


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


init : ( Model, Cmd Msg )
init =
    ( { tag = "", token = "", tweet = "" }, getToken )


getToken : Cmd Msg
getToken =
    Http.send SecretResponse (Http.getString "/token.txt")



-- UPDATE


type Msg
    = NewTag String
    | NewToken
    | Submit
    | SecretResponse (Result Error String)
    | TwitterResponse (Result Error String)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NewTag tag ->
            ( { model | tag = tag }, Cmd.none )

        NewToken ->
            ( model, Cmd.none )

        Submit ->
            ( model, Http.send TwitterResponse (Http.getString url) )

        SecretResponse result ->
            case result of
                Ok response ->
                    ( { model | token = response }, Cmd.none )

                Err error ->
                    ( { model | tweet = "Token Error: " ++ (errorMessage error) }, Cmd.none )

        TwitterResponse result ->
            case result of
                Ok response ->
                    ( { model | tweet = response }, Cmd.none )

                Err error ->
                    ( { model | tweet = "Error!" }, Cmd.none )


errorMessage : Error -> String
errorMessage error =
    case error of
        BadUrl url ->
            "Bad url " ++ url

        Timeout ->
            "Timeout"

        NetworkError ->
            "Network Error"

        BadStatus response ->
            "Status: " ++ response.status.message

        BadPayload message response ->
            "Bad payload:  " ++ message ++ " - " ++ response.body



-- SUBSCRIPTIONS
-- VIEW


view model =
    div []
        [ label [ for "tagInput" ] [ text "Hashtag #" ]
        , input [ onInput NewTag ] []
        , button [ onClick Submit ] [ text "Search Twitter" ]
        , text model.tweet
        ]
