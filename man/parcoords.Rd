% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/parcoords.R
\name{parcoords}
\alias{parcoords}
\title{htmlwidget for d3.js parallel-coordinates}
\usage{
parcoords(data, rownames = T, color = NULL, brushMode = NULL,
  brushPredicate = "and", reorderable = F, axisDots = NULL,
  margin = NULL, composite = NULL, alpha = NULL, queue = F, mode = F,
  rate = NULL, tasks = NULL, width = NULL, height = NULL)
}
\arguments{
\item{data}{data.frame with data to use in the chart}

\item{rownames}{logical use rownames from the data.frame in the chart.  Regardless of
this parameter, we will append rownames to the data that we send to JavaScript.
If \code{rownames} equals \code{FALSE}, then we will use parallel coordinates
to hide it.}

\item{color}{see \href{https://github.com/syntagmatic/parallel-coordinates\#parcoords_color}{parcoords.color( color )}.
Color can be a single color as rgb or hex.  For a color function,
provide a list( colorScale = , colorBy = ) where colorScale is
a function such as \code{d3.scale.category10()} and colorBy
is the column name from the data to determine color.}

\item{brushMode}{string, either \code{"1D-axes"}, \code{"1D-axes-multi"},
or \code{"2D-strums"}
giving the type of desired brush behavior for the chart.}

\item{brushPredicate}{string, either \code{"and"} or \code{"or"} giving
the logic forthe join with multiple brushes.}

\item{reorderable}{logical enable reordering of axes}

\item{axisDots}{logical mark the points where polylines meet an axis with dots}

\item{margin}{list of sizes of margins in pixels.  Currently
\code{brushMode = "2D-strums"} requires left margin = 0, so
this will change automatically and might result in unexpected
behavior.}

\item{alpha}{opacity from 0 to 1 of the polylines}

\item{queue}{logical (default FALSE) to change rendering mode to queue for
progressive rendering.  Usually \code{ queue = T } for very large datasets.}

\item{mode}{string see\code{queue} above; \code{ queue = T } will set
\code{ mode = "queue" }}

\item{tasks}{a character string or \code{\link[htmlwidgets]{JS}} or list of
strings or \code{JS} representing a JavaScript function(s) to run
after the \code{parcoords} has rendered.  These provide an opportunity
for advanced customization.  Note, the \code{function} will use the
JavaScript \code{call} mechanism, so within the function, \code{this} will
be an object with {this.el} representing the containing element of the
\code{parcoords} and {this.parcoords} representing the \code{parcoords}
instance.}

\item{width}{integer in pixels defining the width of the widget.  Autosizing  to 100%
of the widget container will occur if \code{ width = NULL }.}

\item{height}{integer in pixels defining the height of the widget.  Autosizing to 400px
of the widget container will occur if \code{ height = NULL }.}
}
\value{
An object of class \code{htmlwidget} that will
intelligently print itself into HTML in a variety of contexts
including the R console, within R Markdown documents,
and within Shiny output bindings.
}
\description{
Create interactive parallel coordinates charts with this htmlwidget
wrapper for d3.js \href{http://syntagmatic.github.io/parallel-coordinates/}{parallel-coordinates}.
}
\examples{
\dontrun{
  # simple example using the mtcars dataset
  data( mtcars )
  parcoords( mtcars )

  # various ways to change color
  #   in these all lines are the specified color
  parcoords( mtcars, color = "green" )
  parcoords( mtcars, color=RColorBrewer::brewer.pal(3,"BuPu")[3] )
  parcoords( mtcars, color = "#f0c" )
  #   in these we supply a function for our color
  parcoords(
    mtcars
    , color = list(
       colorBy="cyl"
       ,colorScale=htmlwidgets::JS('d3.scale.category10()')
    )
  )
  ### be careful; this might strain your system #######
  ###                                           #######
  data( diamonds, package = "ggplot2" )
  parcoords(
    diamonds
    ,rownames=F
    ,brushMode = "1d-axes"
    ,reorderable=T
    ,queue = T
    ,color= list(
       colorBy="cut"
       ,colorScale = htmlwidgets::JS("d3.scale.category10()")
     )
  )
  # or if we want to add in a dplyr chain
  library(dplyr)
  data( diamonds, package = "ggplot2" )
  diamonds \%>\%
    mutate( carat = cut(carat,breaks = c(0,1,2,3,4,5), right =F) ) \%>\%
    group_by( carat ) \%>\%
    summarise_each(funs(mean),-carat) \%>\%
    parcoords(
      rownames= F
      ,color = list(
         colorScale = htmlwidgets::JS('d3.scale.category10()' )
        , colorBy = "carat"
      )
      ,brushMode = "1D"
    )
}
}

