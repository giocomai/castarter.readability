#' Extract text and metadata from an html string with `readability.js`
#'
#' @param html
#' @param url
#' @param candidates
#' @param threshold
#'
#' @return
#' @export
#'
#' @examples
cas_extract_readability <- function(html,
                                    url,
                                    candidates = 5L,
                                    threshold = 500L) {
  ct <- V8::v8(global = "window")

  ct$eval("function setTimeout(){}")
  ct$eval("function clearInterval(){}")
  ct$source(system.file("js/encoding.min.js", package = "castarter.readability"))
  ct$source(system.file("js/jsdom.js", package = "castarter.readability"))
  ct$source(system.file("js/dompurify.js", package = "castarter.readability"))
  ct$source(system.file("js/readability.js", package = "castarter.readability"))
  ct$eval(readLines(system.file("js/readability-parser.js", package = "castarter.readability")))

  ct$call("readabilityParser", html, url, candidates, threshold)
}
