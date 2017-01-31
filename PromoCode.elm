module PromoCode exposing (Model, Msg, init, update, view, subscriptions)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http


main =
    program
        { init = init, update = update, subscriptions = subscriptions, view = view }



-- MODEL


type alias Model =
    { code : Maybe String }


init =
    ( { code = Nothing }, Cmd.none )



-- UPDATE


type Msg
    = GetPromoCode
    | PromoCode (Result Http.Error String)


update msg model =
    case msg of
        GetPromoCode ->
            ( model, getPromoCode )

        PromoCode (Ok code) ->
            ( { model | code = Just code }, Cmd.none )

        PromoCode (Err _) ->
            ( model, Cmd.none )


getPromoCode =
    let
        url =
            "/promocode.txt"

        request =
            Http.getString url
    in
        Http.send PromoCode request



-- SUBSCRIPTIONS


subscriptions model =
    Sub.none



-- VIEW


view model =
    div []
        [ button [ onClick GetPromoCode ] [ text "Gimme that code!" ]
        , (model.code
            |> Maybe.map renderCode
            |> Maybe.withDefault noCode
          )
        ]


noCode : Html Msg
noCode =
    div [] [ text "" ]


renderCode : String -> Html Msg
renderCode code =
    div []
        [ text code ]
