#!/bin/bash

elm-css src/Stylesheets.elm &&
elm-make src/App.elm --output app.js &&
elm-make src/Hello.elm --output hello.js &&
elm-make src/RandomGif.elm --output randomgif.js &&
elm-make src/Counter.elm --output counter.js &&
elm-make src/SimpleTimer.elm --output simpletimer.js &&
elm-make src/PromoCode.elm --output promocode.js
