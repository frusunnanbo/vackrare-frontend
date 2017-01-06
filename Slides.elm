module Slides exposing (Slides, init, next, previous, currentSlide)

import Html
import Slide


type alias Slides slide =
    { previous : List slide, current : slide, next : List slide }


init : slide -> List slide -> Slides slide
init firstSlide slides =
    { previous = []
    , current = firstSlide
    , next = slides
    }


next : Slides slide -> Slides slide
next slides =
    if List.isEmpty slides.next then
        slides
    else
        { previous = slides.current :: slides.previous
        , current = List.head slides.next |> Maybe.withDefault slides.current
        , next = List.tail slides.next |> Maybe.withDefault []
        }


previous : Slides slide -> Slides slide
previous slides =
    if List.isEmpty slides.previous then
        slides
    else
        { previous = List.tail slides.previous |> Maybe.withDefault []
        , current = List.head slides.previous |> Maybe.withDefault slides.current
        , next = slides.current :: slides.next
        }


currentSlide : Slides slide -> Int
currentSlide slides =
    List.length slides.previous + 1
