module Slide exposing (Slide, titleSlide, createSlide, codeSlide)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.CssHelpers as CssHelpers
import Css
import Css.Elements exposing (body)
import Css.Namespace exposing (namespace)
import Styles


type alias Slide msg model =
    { render : model -> Html msg
    }


titleSlide : Slide msg model
titleSlide =
    { render = renderTitleSlide }


createSlide : String -> Slide msg model
createSlide heading =
    { render = renderHeadingSlide heading }


codeSlide : String -> (model -> Html msg) -> model -> Slide msg model
codeSlide code view model =
    { render = renderCodeSlide code view }


{ id, class, classList } =
    CssHelpers.withNamespace ""
renderHeadingSlide : String -> model -> Html msg
renderHeadingSlide heading model =
    div []
        [ h1 []
            [ text heading ]
        , div [ class [ Styles.MainPicture ] ]
            [ img
                [ src "your-dream-appearance.png"
                ]
                []
            ]
        ]


renderTitleSlide : model -> Html msg
renderTitleSlide model =
    div []
        [ div [ class [ Styles.Title ] ]
            [ img [ src "elm-logo.png" ] []
            , div [] [ text "Vackrare frontend med Elm" ]
            ]
        , div
            [ class [ Styles.AboutMe ] ]
            [ p [] [ text "Pia Fåk Sunnanbo" ]
            , p [] [ text "pia.fak.sunnanbo@omegapoint.se" ]
            , p [] [ text "@frusunnanbo" ]
            ]
        , div [ class [ Styles.Logo ] ] [ img [ src "logo_white.png" ] [] ]
        ]


renderCodeSlide : String -> (model -> Html msg) -> model -> Html msg
renderCodeSlide code view model =
    div [ class [ Styles.CodeSlide ] ]
        [ div [ class [ Styles.Code ] ] [ pre [] [ text code ] ]
        , div [ class [ Styles.Compiled ] ] [ view model ]
        ]
