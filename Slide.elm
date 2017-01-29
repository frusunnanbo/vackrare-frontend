module Slide exposing (Slide, titleSlide, pictureSlide, singlePictureSlide, codeSlide, takeAwaySlide)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.CssHelpers as CssHelpers
import Css exposing (asPairs, px)
import Css.Elements exposing (body)
import Css.Namespace exposing (namespace)
import Regex exposing (replace, regex, HowMany(..))
import Styles


type alias Slide msg model =
    { render : model -> Html msg
    }


titleSlide : Slide msg model
titleSlide =
    { render = renderTitleSlide }


pictureSlide : String -> List ( String, Float ) -> Slide msg model
pictureSlide heading pictures =
    { render = renderPictureSlide heading pictures }


singlePictureSlide : String -> String -> Slide msg model
singlePictureSlide heading picture =
    { render = renderPictureSlide heading [ ( picture, 1 ) ] }


codeSlide : String -> (model -> Html msg) -> model -> Slide msg model
codeSlide code view model =
    { render = renderCodeSlide code view }


takeAwaySlide : Slide msg model
takeAwaySlide =
    { render = renderTakeAwaySlide }


{ id, class, classList } =
    CssHelpers.withNamespace ""
renderPictureSlide : String -> List ( String, Float ) -> model -> Html msg
renderPictureSlide heading pictures model =
    div []
        (h1 [] [ text heading ] :: List.map renderPicture pictures)


renderPicture : ( String, Float ) -> Html msg
renderPicture picturePair =
    let
        ( picture, percent ) =
            picturePair
    in
        div [ class [ Styles.MainPicture ], asPairs [ Css.maxHeight (px (pictureHeight percent)) ] |> style ]
            [ img
                [ src picture
                ]
                []
            ]


pictureHeight : Float -> Float
pictureHeight percent =
    (Styles.slideHeight - 100) * percent


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


renderTakeAwaySlide : model -> Html msg
renderTakeAwaySlide model =
    div []
        [ h1 [] [ text "Att ta med sig hem:" ]
        , bigLink "http://elm-lang.org/try"
        , bigLink "http://tekster.svt.se"
        , bigLink "http://noredink.com"
        , bigLink "http://github.com/frusunnanbo/vackrare-frontend"
        ]


bigLink : String -> Html msg
bigLink link =
    div [ class [ Styles.BigLink ] ]
        [ a
            [ href link ]
            [ text (stripHttp link) ]
        ]


stripHttp : String -> String
stripHttp link =
    replace All (regex "http://") (\_ -> "") link
