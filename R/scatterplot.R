#' <Add Title>
#'
#' <Add Description>
#'
#' @import htmlwidgets
#'
#' @export
scatterplot <- function(obj, columns, width = NULL, height = NULL, ...) {
  msObj <- epivizr:::register(obj, ...)
  ms <- msObj$getMeasurements()

  # make sure they are ordered properly
  m <- match(columns, sapply(ms, "[[", "id"))
  ms <- ms[m]

  query <- range(as(rowRanges(msObj$object), "GRanges"))[1]
  rows <- msObj$getRows(query, NULL)
  values <- lapply(columns, function(i) msObj$getValues(query, i))

  # forward options using x
  bindings = list(
    range=list(seqname=as.character(seqnames(query))[1],
               start=start(query)[1],
               width=width(query)[1]),
    ms=rjson::toJSON(ms),
    rows=rows,
    values=values
  )

  # create widget
  htmlwidgets::createWidget(
    name = 'scatterplot',
    bindings,
    width = width,
    height = height,
    sizingPolicy = htmlwidgets::sizingPolicy(padding=0, browser.fill=TRUE),
    package = 'epivizWidgets'
  )
}

#' Widget output function for use in Shiny
#'
#' @export
scatterplotOutput <- function(outputId, width = '100%', height = '400px'){
  shinyWidgetOutput(outputId, 'scatterplot', width, height, package = 'epivizWidgets')
}

#' Widget render function for use in Shiny
#'
#' @export
renderScatterplot <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  shinyRenderWidget(expr, scatterplotOutput, env, quoted = TRUE)
}
