#!/bin/bash

elm-css Stylesheets.elm &&
elm-make App.elm --output app.js &&
elm-make Hello.elm --output hello.js &&
elm-make RandomGif.elm --output randomgif.js &&
elm-make Counter.elm --output counter.js &&
elm-make SimpleTimer.elm --output simpletimer.js
