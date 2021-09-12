dijkstra <- function(graph, init_node){

  #' Calculates the shortest distances between an initial node and all other nodes in an input data.frame
  #'
  #' @export
  #' @param v_v1 A Vector of integers for the start positions
  #' @param v_v2 A Vector of integers for the stop positions
  #' @param v_w A Vector of distances between the corresponding vertexes in vector v_v1 and v_v2
  #' @param init_node The initialized vertex from which distances should be computed
  #' @param int_max_node The maximum vertex
  #' @param v_answer A vector of distances between the initialized node and every other node
  #' @param int_updated_node The current next node
  #' @param v_connected_vortex_positions A vector of all connected positions to the current node
  #' @param int_position An integer rutting over v_connected_vortex_positions
  #' @param int_min_distance The shortest path to the nest vertex
  #' @param graph A function argument. A data.frame
  #' @param v1 A Vector of integers for the start positions
  #' @param v2 A Vector of integers for the stop positions
  #' @param w A Vector of distances between the corresponding vertexes in vector v1 and v2
  #' @param int_node_with_minimum_distance_position_in_v_answer Node with minimum distance position in v_answer
  #'
  #' @return The vector of shortest distances between the initialized node and every other node
  #' @examples
  #' dijkstra(wiki_graph, 1)
  #' dijkstra(wiki_graph, 3)
  #' @source \url{https://en.wikipedia.org/wiki/Dijkstra\%27s_algorithm/}

  #https://stackoverflow.com/questions/68971969/roxygen2-return-mismatched-braces-or-quotes
  if(!is.data.frame(graph)){stop()}
  if(!identical(names(graph), c("v1", "v2", "w"))){stop()}

  v_v1 <- unlist(graph$v1)
  v_v2 <- unlist(graph$v2)
  v_w <- unlist(graph$w)
  int_max_node <- max(v_v1)
  if(int_max_node < init_node){stop()}

  v_answer <- 1:int_max_node + Inf # The vector that holds distances

  v_answer[init_node] <- 0

  int_updated_node <- init_node

  while ((Inf %in% v_answer)) {

    #Update the information about the connected nodes.
    v_connected_vortex_positions <- which(v_v1 == int_updated_node)

    #Update the distances in v_answer
    for (int_position in v_connected_vortex_positions) {
      if(v_answer[v_v2[int_position]] > v_w[int_position] + v_answer[int_updated_node] ){v_answer[v_v2[int_position]] <- v_w[int_position] + v_answer[int_updated_node]}
    }

    #exclude all elements, where connected to int_updated_node
    v_v1 <- v_v1[-which(v_v2 == int_updated_node)]
    v_w <- v_w[-which(v_v2 == int_updated_node)]
    v_v2 <- v_v2[-which(v_v2 == int_updated_node)]

    #update the vector of connected positions based on the new vectors v_v1, v_v2, and v_w
    v_connected_vortex_positions <- which(v_v1 == int_updated_node)

    #find the minimum distance and find the next node based on the minimum distance
    int_min_distance <- min(v_answer[v_v2[v_connected_vortex_positions]])
    #print("int_min_distance:")
    #print(int_min_distance)
    #print("which(v_answer[v_v2[v_connected_vortex_positions]] == int_min_distance:")
    #print(which(v_answer[v_v2[v_connected_vortex_positions]] == int_min_distance)) 
    int_node_with_minimum_distance_position_in_v_answer <- which(v_answer[v_v2[v_connected_vortex_positions]] == int_min_distance)
    int_updated_node <- v_v2[v_connected_vortex_positions[int_node_with_minimum_distance_position_in_v_answer]]
  }
  return(v_answer)
}

wiki_graph <-
  data.frame(v1=c(1,1,1,2,2,2,3,3,3,3,4,4,4,5,5,6,6,6),
             v2=c(2,3,6,1,3,4,1,2,4,6,2,3,5,4,6,1,3,5),
             w=c(7,9,14,7,10,15,9,10,11,2,15,11,6,6,9,14,2,9))
dijkstra(wiki_graph, 1)
dijkstra(wiki_graph, 3)
