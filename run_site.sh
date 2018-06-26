#!/bin/bash

docker build . -t jekyll_site
docker run -it --rm -v $(pwd):/www_source --net=host jekyll_site
