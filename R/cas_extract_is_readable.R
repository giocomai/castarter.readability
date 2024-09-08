#' Check if a an html input can be successfully parsed through `readability.js`
#'
#' @param html
#' @param min_content_length
#' @param min_score
#'
#' @return
#' @export
#'
#' @examples
cas_extract_readability_check <- function(html,
                                          min_content_length = 140,
                                          min_score = 20) {
  ct <- V8::v8(global = "window")

  ct$eval("function setTimeout(){}")
  ct$eval("function clearInterval(){}")
  ct$source(system.file("js/encoding.min.js", package = "castarter.readability"))
  ct$source(system.file("js/jsdom.js", package = "castarter.readability"))
  ct$source(system.file("js/readability.js", package = "castarter.readability"))
  ct$eval(readLines(system.file("js/readability-parser.js", package = "castarter.readability")))

  ct$call("isReadable", html, min_content_length, min_score)
}
