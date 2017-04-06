module Slide exposing (Slide, image, slideWithHeading, singlePictureSlide, linkPictureSlide)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.CssHelpers as CssHelpers
import Css exposing (asPairs, px)
import Css.Elements exposing (body)
import Css.Namespace exposing (namespace)
import Styles


type alias Slide msg model =
    { render : model -> Html msg }


singlePictureSlide : String -> String -> Slide msg model
singlePictureSlide heading picture =
    { render = renderPictureSlide heading picture }


linkPictureSlide : String -> String -> String -> Slide msg model
linkPictureSlide heading picture link =
    { render = renderLinkPictureSlide heading picture link }


{ id, class, classList } =
    CssHelpers.withNamespace ""
renderPictureSlide : String -> String -> model -> Html msg
renderPictureSlide heading picture model =
    div []
        [ h1 []
            [ text heading ]
        , renderPicture picture
        ]


renderLinkPictureSlide : String -> String -> String -> model -> Html msg
renderLinkPictureSlide heading picture link model =
    div []
        [ h1 []
            [ text heading ]
        , renderLink link (renderPicture picture)
        ]


slideWithHeading : String -> List (Html msg) -> Html msg
slideWithHeading heading slideContent =
    div []
        (h1 [] [ text heading ] :: slideContent)


renderLink : String -> Html msg -> Html msg
renderLink link inner =
    a [ href link, target "_blank" ] [ inner ]


renderPicture : String -> Html msg
renderPicture picture =
    div [ class [ Styles.MainPicture ] ]
        [ image picture ]


image : String -> Html msg
image name =
    img [ src ("/images/" ++ name) ] []
