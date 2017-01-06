module Slide exposing (Slide, titleSlide, createSlide)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.CssHelpers as CssHelpers
import Css
import Css.Elements exposing (body)
import Css.Namespace exposing (namespace)
import Styles


type alias Slide msg =
    { render : Html msg
    }


titleSlide : Slide msg
titleSlide =
    { render = renderTitleSlide }


createSlide : String -> Slide msg
createSlide heading =
    { render = renderHeadingSlide heading }


{ id, class, classList } =
    CssHelpers.withNamespace ""
renderHeadingSlide : String -> Html msg
renderHeadingSlide heading =
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


renderTitleSlide : Html msg
renderTitleSlide =
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
