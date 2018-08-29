#!/usr/bin/env bash

rm -rf _site

jekyll clean

JEKYLL_ENV=production jekyll build