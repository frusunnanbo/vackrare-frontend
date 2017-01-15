module Timer exposing (Model, Msg, init, update, subscriptions, view)

import Html exposing (..)
import Html.CssHelpers as CssHelpers
import Time exposing (Time, every, second)
import Styles


-- MODEL


type alias Model =
    { elapsedTime : Int }


init : Model
init =
    { elapsedTime = 0 }



-- UPDATE


type Msg
    = Tick Time


update : Msg -> Model -> Model
update msg model =
    case msg of
        Tick time ->
            { model | elapsedTime = model.elapsedTime + 1 }



-- SUBSCRIPTIONS


subscriptions : Sub Msg
subscriptions =
    every second Tick



-- VIEW


{ id, class, classList } =
    CssHelpers.withNamespace ""
view : Model -> Html Msg
view model =
    div [ id Styles.Elapsed ]
        [ span [ class [ Styles.DisplayNumber ] ] [ text (toString model.elapsedTime) ]
        ]
