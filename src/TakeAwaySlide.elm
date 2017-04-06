module TakeAwaySlide exposing (takeAwaySlide)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.CssHelpers as CssHelpers
import Css exposing (asPairs, px)
import Css.Elements exposing (body)
import Regex exposing (replace, regex, HowMany(..))
import Styles
import Slide exposing (Slide, image, slideWithHeading)


{ id, class, classList } =
    CssHelpers.withNamespace ""
takeAwaySlide : Slide msg model
takeAwaySlide =
    { render = renderTakeAwaySlide }


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
