module Slides exposing (Slides, init, next, previous, currentSlide)

import Html
import InTheBeginningOfTime
import InTheMeanTime
import TheseDays
import WhatsAWebapp
import ElmOneOOne
import PageNavigation
import PresentationTimer
import FetchingPages


type alias Slides =
    { previous : List Slide, current : Slide, next : List Slide }


type alias Slide =
    { heading : String }


init : Slides
init =
    { previous = []
    , current = createSlide "In the Begining of Time"
    , next =
        [ createSlide "In the Mean Time"
        , createSlide "These Days"
        , createSlide "Whats a webapp, anyway?"
        , createSlide "Elm 101"
        , createSlide "Navigating a set of slides"
        , createSlide "Keeping track of time"
        , createSlide "Fetching Stuff from a server"
        ]
    }


createSlide : String -> Slide
createSlide heading =
    { heading = heading }


next : Slides -> Slides
next slides =
    if List.isEmpty slides.next then
        slides
    else
        { previous = slides.current :: slides.previous
        , current = List.head slides.next |> Maybe.withDefault slides.current
        , next = List.tail slides.next |> Maybe.withDefault []
        }


previous : Slides -> Slides
previous slides =
    if List.isEmpty slides.previous then
        slides
    else
        { previous = List.tail slides.previous |> Maybe.withDefault []
        , current = List.head slides.previous |> Maybe.withDefault slides.current
        , next = slides.current :: slides.next
        }


currentSlide : Slides -> Int
currentSlide slides =
    List.length slides.previous + 1
