module TitlePage exposing (titleSlide)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.CssHelpers as CssHelpers
import Css exposing (asPairs, px)
import Css.Elements exposing (body)
import Css.Namespace exposing (namespace)
import Regex exposing (replace, regex, HowMany(..))
import TitlePageStyles
import Slide exposing (Slide, image)


titleSlide : Slide msg model
titleSlide =
    { render = renderTitleSlide }


{ id, class, classList } =
    CssHelpers.withNamespace "titleSlide"
renderTitleSlide : model -> Html msg
renderTitleSlide model =
    div []
        [ div [ class [ TitlePageStyles.Title ] ]
            [ image "elm-logo.png"
            , div [] [ text "Vackrare frontend med Elm" ]
            ]
        , div
            [ class [ TitlePageStyles.AboutMe ] ]
            [ p [] [ text "Pia Fåk Sunnanbo" ]
            , p [] [ text "pia.fak.sunnanbo@omegapoint.se" ]
            , p [] [ text "@frusunnanbo" ]
            ]
        , div [ class [ TitlePageStyles.Logo ] ] [ image "logo_white.png" ]
        ]
