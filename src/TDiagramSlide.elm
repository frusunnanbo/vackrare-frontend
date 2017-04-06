module TDiagramSlide exposing (tDiagramSlide)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.CssHelpers as CssHelpers
import Css exposing (asPairs, px)
import Css.Elements exposing (body)
import Styles
import Slide exposing (Slide, image, slideWithHeading)


{ id, class, classList } =
    CssHelpers.withNamespace ""
tDiagramSlide : Slide msg model
tDiagramSlide =
    { render = renderTDiagramSlide }


renderTDiagramSlide : model -> Html msg
renderTDiagramSlide model =
    slideWithHeading "Vad är Elm?"
        [ div [ class [ Styles.KindaCentered ] ]
            [ div
                [ class [ Styles.TDiagram ] ]
                [ imageBox Styles.TInput "elm-logo.png"
                , imageBox Styles.TOutput "js-logo.png"
                , image "haskell-logo.png"
                ]
            ]
        ]


imageBox : Styles.CssClasses -> String -> Html msg
imageBox cssClass filename =
    div [ class [ cssClass ] ]
        [ image filename ]
