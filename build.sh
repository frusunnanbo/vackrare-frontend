#!/bin/bash

elm-css Stylesheets.elm &&
elm-make App.elm --output app.js
