#!/bin/bash

elm-css Stylesheets.elm &&
elm-make App.elm --output app.js &&
elm-make Hello.elm --output hello.js &&
elm-make RandomGif.elm --output randomgif.js
