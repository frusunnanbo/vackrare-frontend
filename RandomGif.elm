module RandomGif exposing (Model, Msg, init, update, view, subscriptions)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode as Json


main =
    program
        { init = init, update = update, subscriptions = subscriptions, view = view }



-- MODEL


type alias Model =
    { url : Maybe String }


init =
    ( { url = Nothing }, Cmd.none )



-- UPDATE


type Msg
    = GetImage
    | NewImageUrl (Result Http.Error String)


update msg model =
    case msg of
        GetImage ->
            ( model, getRandomCat )

        NewImageUrl (Ok url) ->
            ( { model | url = Just url }, Cmd.none )

        NewImageUrl (Err _) ->
            ( model, Cmd.none )


getRandomCat =
    let
        url =
            "http://random.cat/meow"

        request =
            Http.get url decodeGifUrl
    in
        Http.send NewImageUrl request


decodeGifUrl : Json.Decoder String
decodeGifUrl =
    Json.at [ "file" ] Json.string



-- SUBSCRIPTIONS


subscriptions model =
    Sub.none



-- VIEW


view model =
    div []
        [ button [ onClick GetImage ] [ text "Another cat please!" ]
        , (model.url
            |> Maybe.map renderImage
            |> Maybe.withDefault noImage
          )
        ]


noImage : Html Msg
noImage =
    div [] [ text "No cats here yet." ]


renderImage : String -> Html Msg
renderImage url =
    div []
        [ img [ src url ] []
        ]
