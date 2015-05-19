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

  query <- range(as(rowRanges(tmp$object), "GRanges"))[1]
  rows <- msObj$getRows(query, NULL)
  xval <- msObj$getValues(query, columns[1])
  yval <- msObj$getValues(query, columns[2])

  # forward options using x
  bindings = list(
    ms=rjson::toJSON(ms),
    rows=rows,
    xval=xval,
    yval=yval
  )

  # create widget
  htmlwidgets::createWidget(
    name = 'scatterplot',
    bindings,
    width = width,
    height = height,
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
