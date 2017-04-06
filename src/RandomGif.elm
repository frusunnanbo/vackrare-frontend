module RandomGif exposing (Model, Msg, init, update, view, subscriptions)

import Maybe exposing (withDefault, map)
import Html exposing (Html, program, div, button, img, text)
import Html.Attributes exposing (src)
import Html.Events exposing (..)
import Html.CssHelpers
import Http
import Json.Decode as Json
import Styles


main =
    program
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }



-- MODEL


type alias Model =
    { url : Maybe String }


init =
    ( { url = Nothing }, Cmd.none )



-- UPDATE


type Msg
    = GetImage
    | NewImageUrl (Result Http.Error String)


update : Msg -> Model -> ( Model, Cmd Msg )
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
    div [ class [ Styles.KindaCentered ] ]
        [ button [ onClick GetImage ] [ text "Another cat please!" ]
        , div [ class [ Styles.RandomCat ] ]
            (model.url
                |> map renderImage
                |> withDefault noImage
            )
        ]


noImage : List (Html Msg)
noImage =
    [ text "No cats here yet." ]


renderImage : String -> List (Html Msg)
renderImage url =
    [ img [ src url ] [] ]


{ id, class, classList } =
    Html.CssHelpers.withNamespace ""
