#The Euclidean Algorithm
#Two integers are given. The objective is to find their largest common divisor. The algorithm procedure is based on the following Wikipedia page: https://en.wikipedia.org/wiki/Euclidean_algorithm

euclidean <- function(a, b) {
  #' Calculates the GCD for two integers
  #'
  #' @param a A first integer
  #' @param b A second integer
  #' @return The GCD
  #' @examples
  #' euclidean(123612, 13892347912)
  #' euclidean(100, 1000)
  #' @source \url{https://en.wikipedia.org/wiki/Euclidean_algorithm/}


  #Check the validity of inputs
  if(!is.numeric(a) || !is.numeric(b) ){
    print("The input numbers should be integers!")
    stop()}
  #If b is lower than a, reassign a with b and b with a.
  if(b < a){c <- b; b <- a; a <- c}

  rest <- 1

  while(rest > 0) {
    previousRest <- rest
    rest <- a %% b
    a <- b
    b <- rest
  }
  return(previousRest)
}
euclidean(123612, 13892347912)
euclidean(100, 1000)

