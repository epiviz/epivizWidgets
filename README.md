epivizWidgets
--------------


A prototype of bindings to epiviz visualizations through `htmlwidgets`

## Installation

```r
# install bioconductor
source("http://bioconductor.org/biocLite.R")

# install dependencies
biocLite(c("epivizr","htmlwidgets","devtools"))

# install this package
devtools::install_github("epiviz/epivizWidgets")
```

Once installed, you can see an example in the vignette

```r
vignette("IntroEpivizWidgets")
```
