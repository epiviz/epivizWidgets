#' <Add Title>
#'
#' <Add Description>
#'
#' @import htmlwidgets
#'
#' @export
scatterplot <- function(message, width = NULL, height = NULL) {

  # forward options using x
  x = list(
    message = message
  )

  # create widget
  htmlwidgets::createWidget(
    name = 'scatterplot',
    x,
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
