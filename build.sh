#!/bin/bash

elm-css css-src/Stylesheets.elm &&
elm-make src/App.elm --output build/app.js &&
elm-make src/Hello.elm --output build/hello.js &&
elm-make src/RandomGif.elm --output build/randomgif.js &&
elm-make src/Counter.elm --output build/counter.js &&
elm-make src/SimpleTimer.elm --output build/simpletimer.js
