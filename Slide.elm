module Slide exposing (Slide, titleSlide, pictureSlide, createSlide, codeSlide)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.CssHelpers as CssHelpers
import Css exposing (asPairs, px)
import Css.Elements exposing (body)
import Css.Namespace exposing (namespace)
import Styles


type alias Slide msg model =
    { render : model -> Html msg
    }


titleSlide : Slide msg model
titleSlide =
    { render = renderTitleSlide }


pictureSlide : String -> List String -> Slide msg model
pictureSlide heading pictures =
    { render = renderPictureSlide heading pictures }


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
    renderPictureSlide heading [ "your-dream-appearance.png" ] model


renderPictureSlide : String -> List String -> model -> Html msg
renderPictureSlide heading pictures model =
    div []
        (h1 [] [ text heading ] :: List.map (renderPicture (maxPictureHeight pictures)) pictures)


maxPictureHeight : List picture -> Float
maxPictureHeight pictures =
    (Styles.slideHeight - 100) / toFloat (List.length pictures)


renderPicture : Float -> String -> Html msg
renderPicture maxHeight picture =
    div [ class [ Styles.MainPicture ], asPairs [ Css.maxHeight (px maxHeight) ] |> style ]
        [ img
            [ src picture
            ]
            []
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
