\name{dijkstra}
\alias{dijkstra}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
dijkstra(graph, init_node)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{graph}{
%%     ~~Describe \code{graph} here~~
}
  \item{init_node}{
%%     ~~Describe \code{init_node} here~~
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
%%  ~~who you are~~
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function (graph, init_node) 
{
    if (!is.data.frame(graph)) {
        stop()
    }
    if (!identical(names(graph), c("v1", "v2", "w"))) {
        stop()
    }
    v_v1 <- unlist(graph$v1)
    v_v2 <- unlist(graph$v2)
    v_w <- unlist(graph$w)
    int_max_node <- max(v_v1)
    if (int_max_node < init_node) {
        stop()
    }
    v_answer <- 1:int_max_node + Inf
    v_answer[init_node] <- 0
    int_updated_node <- init_node
    while ((Inf \%in\% v_answer)) {
        v_connected_vortex_positions <- which(v_v1 == int_updated_node)
        for (int_position in v_connected_vortex_positions) {
            if (v_answer[v_v2[int_position]] > v_w[int_position] + 
                v_answer[int_updated_node]) {
                v_answer[v_v2[int_position]] <- v_w[int_position] + 
                  v_answer[int_updated_node]
            }
        }
        v_v1 <- v_v1[-which(v_v2 == int_updated_node)]
        v_w <- v_w[-which(v_v2 == int_updated_node)]
        v_v2 <- v_v2[-which(v_v2 == int_updated_node)]
        v_connected_vortex_positions <- which(v_v1 == int_updated_node)
        int_min_distance <- min(v_answer[v_v2[v_connected_vortex_positions]])
        int_updated_node <- which(v_answer == int_min_distance)
    }
    return(v_answer)
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory (show via RShowDoc("KEYWORDS")):
% \keyword{ ~kwd1 }
% \keyword{ ~kwd2 }
% Use only one keyword per line.
% For non-standard keywords, use \concept instead of \keyword:
% \concept{ ~cpt1 }
% \concept{ ~cpt2 }
% Use only one concept per line.
