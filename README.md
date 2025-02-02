
<!-- README.md is generated from README.Rmd. Please edit that file -->

# castarter.readability

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

The goal of `castarter.readability` is to extract text and metadata from
web pages through `readability.js`. As the name suggests, this is a
companion package to
[`castarter`](https://github.com/giocomai/castarter) - Content Analysis
Starter Toolkit for the R programming language.

This package sticks together various elements of pre-existing libraries
(see below for references and licenses details) for easier embedding in
workflows. The R implementation is based on [this
tutorial](https://nanx.me/blog/post/r-readability-parser/) / [see
repo](https://github.com/nanxstats/r-readability-parser/), which is
partly based on this [V8
vignette](https://cran.r-project.org/web/packages/V8/vignettes/npm.html).
All of the credits go to respective authors.

## Installation

You can install the development version of `castarter.readability` from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("giocomai/castarter.readability")
```

## Embedded libraries

This package embeds dependencies. Newer versions may be available by the
time you see this. In order to pack these dependencies, follow the
above-mentioned tutorials. In brief, these are the key steps.

- make sure you have `browserify` installed
  (`npm install -g browserify`)
- pack `readability.js`, `jsdom.js`, and `dompurify.js`

<!-- -->

    npm install @mozilla/readability
    echo "window.Readability = require('@mozilla/readability');" > in.js
    browserify in.js -o readability.js

    npm install jsdom@20.0.0
    echo "window.jsdom = require('jsdom');" > in.js
    browserify in.js -o jsdom.js

    npm install dompurify
    echo "window.dompurify = require('dompurify');" > in.js
    browserify in.js -o dompurify.js

- in order to prevent encoding issues, include
  [`encoding.min.js`](https://cdn.jsdelivr.net/npm/text-encoding@0.7.0/lib/encoding.min.js)

Following the above-mentioned [`V8`
vignette](https://cran.r-project.org/web/packages/V8/vignettes/npm.html)

## Example

``` r
library("castarter.readability")

url <- "https://giorgiocomai.eu/post/2020-06-abkhazia-gorecki/"


html_source <- readLines(con = url, warn = FALSE) |>
  paste0(collapse = "\n")

cas_extract_readability_check(html = html_source)
#> [1] TRUE
```

``` r
extracted_readability_list <- cas_extract_readability(html = html_source, url = url)

str(extracted_readability_list)
#> List of 10
#>  $ title        : chr "“Abchazja” and other untranslated bits of Wojciech Górecki's Caucasus trilogy"
#>  $ byline       : chr "Giorgio Comai"
#>  $ dir          : NULL
#>  $ lang         : chr "en-us"
#>  $ content      : chr "<div class=\"page\" id=\"readability-page-1\"><div>\n      <p><strong>\n<a rel=\"noopener\" href=\"https://www."| __truncated__
#>  $ textContent  : chr "\n      \nOriginally published on balcanicaucaso.org\nWojciech Górecki’s Planeta Kaukaz on the Northern Caucasu"| __truncated__
#>  $ length       : int 11277
#>  $ excerpt      : chr "Górecki spent a lavish amount of time in the Caucasus, meeting people across the region and hearing their stori"| __truncated__
#>  $ siteName     : chr "Giorgio Comai"
#>  $ publishedTime: chr "2020-06-26T00:00:00Z"
```
