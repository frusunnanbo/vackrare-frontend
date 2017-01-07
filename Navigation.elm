module Navigation exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Html.CssHelpers as CssHelpers
import Keyboard
import Styles


-- MODEL


type alias Model slide =
    { previous : List slide, current : slide, next : List slide }


init : slide -> List slide -> Model slide
init firstSlide slides =
    { previous = []
    , current = firstSlide
    , next = slides
    }



-- UPDATE


type Msg
    = Forward
    | Back
    | Noop


update : Msg -> Model slide -> Model slide
update msg model =
    case msg of
        Forward ->
            next model

        Back ->
            previous model

        Noop ->
            model


next : Model slide -> Model slide
next slides =
    if List.isEmpty slides.next then
        slides
    else
        { previous = slides.current :: slides.previous
        , current = List.head slides.next |> Maybe.withDefault slides.current
        , next = List.tail slides.next |> Maybe.withDefault []
        }


previous : Model slide -> Model slide
previous slides =
    if List.isEmpty slides.previous then
        slides
    else
        { previous = List.tail slides.previous |> Maybe.withDefault []
        , current = List.head slides.previous |> Maybe.withDefault slides.current
        , next = slides.current :: slides.next
        }


currentSlide : Model slide -> Int
currentSlide slides =
    List.length slides.previous + 1



-- SUBSCRIPTIONS


subscriptions =
    Keyboard.downs handleKeyPress


handleKeyPress : Keyboard.KeyCode -> Msg
handleKeyPress keyCode =
    case keyCode of
        13 ->
            Forward

        32 ->
            Forward

        39 ->
            Forward

        37 ->
            Back

        _ ->
            Noop



-- VIEW


{ id, class, classList } =
    CssHelpers.withNamespace ""
view : Model slide -> Html Msg
view model =
    div [ id Styles.Navigation ]
        [ button
            [ onClick Back ]
            [ text "<" ]
        , span [ class [ Styles.DisplayNumber ] ] [ text (toString (currentSlide model)) ]
        , button
            [ onClick Forward ]
            [ text ">" ]
        ]
