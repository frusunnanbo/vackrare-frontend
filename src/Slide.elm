module Slide exposing (Slide, tDiagramSlide, singlePictureSlide, linkPictureSlide, takeAwaySlide)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.CssHelpers as CssHelpers
import Css exposing (asPairs, px)
import Css.Elements exposing (body)
import Css.Namespace exposing (namespace)
import Regex exposing (replace, regex, HowMany(..))
import Styles
import TitlePageStyles


type alias Slide msg model =
    { render : model -> Html msg }


tDiagramSlide : Slide msg model
tDiagramSlide =
    { render = renderTDiagramSlide }


singlePictureSlide : String -> String -> Slide msg model
singlePictureSlide heading picture =
    { render = renderPictureSlide heading [ ( picture, 1 ) ] }


linkPictureSlide : String -> String -> String -> Slide msg model
linkPictureSlide heading picture link =
    { render = renderLinkPictureSlide heading picture link }


takeAwaySlide : Slide msg model
takeAwaySlide =
    { render = renderTakeAwaySlide }


{ id, class, classList } =
    CssHelpers.withNamespace ""
renderPictureSlide : String -> List ( String, Float ) -> model -> Html msg
renderPictureSlide heading pictures model =
    div []
        (h1 [] [ text heading ] :: List.map renderPicture pictures)


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


renderLinkPictureSlide : String -> String -> String -> model -> Html msg
renderLinkPictureSlide heading picture link model =
    div []
        [ h1 [] [ text heading ]
        , renderLink link (renderPicture ( picture, 1 ))
        ]


slideWithHeading : String -> List (Html msg) -> Html msg
slideWithHeading heading slideContent =
    div []
        (h1 [] [ text heading ] :: slideContent)


renderLink : String -> Html msg -> Html msg
renderLink link inner =
    a [ href link, target "_blank" ] [ inner ]


renderPicture : ( String, Float ) -> Html msg
renderPicture picturePair =
    let
        ( picture, percent ) =
            picturePair
    in
        div [ class [ Styles.MainPicture ] ]
            [ image picture ]


pictureHeight : Float -> Float
pictureHeight percent =
    (Styles.slideHeight - 100) * percent


renderTakeAwaySlide : model -> Html msg
renderTakeAwaySlide model =
    div []
        [ h1 [] [ text "Att ta med sig hem:" ]
        , bigLink "http://elmrepl.cuberoot.in"
        , bigLink "http://elm-lang.org/try"
        , bigLink "https://ellie-app.com"
        , bigLink "http://noredink.com"
        , bigLink "http://tekster.svt.se"
        , bigLink "http://elm-lang.org/blog/blazing-fast-html-round-two"
        , bigLink "http://github.com/frusunnanbo/vackrare-frontend"
        , bigLink "https://medium.com/imbybio/caring-for-elms-with-elm-98711f5128f1"
        ]


bigLink : String -> Html msg
bigLink link =
    stripHttp link
        |> bigLinkWithText link


bigLinkWithText : String -> String -> Html msg
bigLinkWithText link linkText =
    div [ class [ Styles.BigLink ] ]
        [ span [ class [ Styles.Dash ] ]
            [ text "--> " ]
        , a
            [ href link, target "_blank" ]
            [ text linkText ]
        ]


stripHttp : String -> String
stripHttp link =
    replace All (regex "http://") (\_ -> "") link


image : String -> Html msg
image name =
    img [ src ("/images/" ++ name) ] []
