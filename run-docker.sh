#!/bin/bash
docker run -i -t -v "$PWD":/srv/jekyll -p "4000:4000" jekyll/jekyll jekyll serve --watch --incremental
