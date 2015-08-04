## ----options, echo=FALSE-------------------------------------------------
knitr::opts_chunk$set(cache=TRUE)

## ----pkgs, message=FALSE-------------------------------------------------
require(epivizr)
require(antiProfilesData)

data(apColonData)

## ----setup---------------------------------------------------------------
keep <- pData(apColonData)$SubType!="adenoma"
apColonData <- apColonData[,keep]
status <- pData(apColonData)$Status
Indexes <- split(seq(along=status),status)

exprMat <- exprs(apColonData)
mns <- sapply(Indexes, function(ind) rowMeans(exprMat[,ind]))
mat <- cbind(colonM=mns[,"1"]-mns[,"0"], colonA=0.5*(mns[,"1"]+mns[,"0"]))
assayDataElement(apColonData, "MA") <- mat
show(apColonData)

## ----scatterplot, cache=FALSE--------------------------------------------
library(epivizWidgets)
epivizWidgets::scatterplot(apColonData, columns=c("colonA","colonM"), assay="MA")

