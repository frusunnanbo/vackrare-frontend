module Slide exposing (Slide, titleSlide, tDiagramSlide, pictureSlide, singlePictureSlide, linkPictureSlide, takeAwaySlide)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.CssHelpers as CssHelpers
import Css exposing (asPairs, px)
import Css.Elements exposing (body)
import Css.Namespace exposing (namespace)
import Regex exposing (replace, regex, HowMany(..))
import Styles


type alias Slide msg model =
    { render : model -> Html msg }


titleSlide : Slide msg model
titleSlide =
    { render = renderTitleSlide }


tDiagramSlide : Slide msg model
tDiagramSlide =
    { render = renderTDiagramSlide }


pictureSlide : String -> List ( String, Float ) -> Slide msg model
pictureSlide heading pictures =
    { render = renderPictureSlide heading pictures }


singlePictureSlide : String -> String -> Slide msg model
singlePictureSlide heading picture =
    { render = renderPictureSlide heading [ ( picture, 1 ) ] }


linkPictureSlide : String -> String -> String -> Slide msg model
linkPictureSlide heading picture link =
    { render = renderLinkPictureSlide heading picture link }


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
        div [ class [ Styles.MainPicture ], asPairs [ Css.maxHeight (px (pictureHeight percent)) ] |> style ]
            [ image picture ]


pictureHeight : Float -> Float
pictureHeight percent =
    (Styles.slideHeight - 100) * percent


renderTitleSlide : model -> Html msg
renderTitleSlide model =
    div []
        [ div [ class [ Styles.Title ] ]
            [ image "elm-logo.png"
            , div [] [ text "Vackrare frontend med Elm" ]
            ]
        , div
            [ class [ Styles.AboutMe ] ]
            [ p [] [ text "Pia Fåk Sunnanbo" ]
            , p [] [ text "pia.fak.sunnanbo@omegapoint.se" ]
            , p [] [ text "@frusunnanbo" ]
            ]
        , div [ class [ Styles.Logo ] ] [ image "logo_white.png" ]
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
        , bigLink "http://noredink.com"
        , bigLink "http://tekster.svt.se"
        , bigLink "http://elm-lang.org/blog/blazing-fast-html-round-two"
        , bigLink "http://github.com/frusunnanbo/vackrare-frontend"
        , bigLink "http://studentkonferens.omegapoint.se"
        , bigLinkWithText "/promocode.html" "  -->"
        ]


bigLink : String -> Html msg
bigLink link =
    stripHttp link
        |> bigLinkWithText link


bigLinkWithText : String -> String -> Html msg
bigLinkWithText link linkText =
    div [ class [ Styles.BigLink ] ]
        [ a
            [ href link, target "_blank" ]
            [ text linkText ]
        ]


stripHttp : String -> String
stripHttp link =
    replace All (regex "http://") (\_ -> "") link


image : String -> Html msg
image name =
    img [ src ("/images/" ++ name) ] []