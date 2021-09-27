# Define server logic for random distribution app ----
server <- function(input, output) {
  
  
  a_test_value <- 2
 # print(a_test_value)               # This works
  
  
  observeEvent(input$antal, { result <- input$antal + 133
    cat("Showing", result, "rows\n")
    
    print(paste("a_test_value: ", a_test_value))
    
    output$summary2 <- renderPrint({ a_test_value })
    
    lon <- 0
    lat <- 0
    
    if (input$lonlat == 1) {lon <- 50; lat <- 10}
    if (input$lonlat == 2) {lon <- 60; lat <- 20}
    if (input$lonlat == 3) {lon <- 70; lat <- 30}
    if (input$lonlat == 4) {lon <- 80; lat <- 40}
    
    print(paste("a lonlat value: ", lon, " ", lat)) 
    
    })
  
  
  observeEvent(input$dist, { result <- input$antal + 17
  cat("Showing nytt", input$dist, "rows\n")
  # stop()
  })
  
  
 
  reactive(input$lonlat, {print("It works!")})
  
  
  
  
  
  
  
  
  # Reactive expression to generate the requested distribution ----
  # This is called whenever the inputs change. The output functions
  # defined below then use the value computed from this expression
  
  d <- reactive({
    
    #print(input$antal)               # THIS WORKS
    
    print(paste('Number of values:', input$antal))
    
    dist <- switch(input$dist,
                   norm = rnorm,
                   unif = runif,
                   lnorm = rlnorm,
                   exp = rexp,
                   rnorm)
    
    dist(input$antal)
  })
  
  # Generate a plot of the data ----
  # Also uses the inputs to build the plot label. Note that the
  # dependencies on the inputs and the data reactive expression are
  # both tracked, and all expressions are called in the sequence
  # implied by the dependency graph.
  
  output$plot <- renderPlot({
    dist <- input$dist
    n <- input$antal
    
    hist(d(),
         main = paste("r", dist, "(", n, ")", sep = ""),
         col = "#75AADB", border = "white")
  })
  
  
  
  
  output$plot2 <- renderPlot({
    dist <- input$dist
    n <- input$antal
    
    hist(d(),
         main = paste("r", dist, "(", n, ")", sep = ""),
         col = "#75AADB", border = "white")
  })
  
  
 # Generate a summary of the data ----
  output$summary <- renderPrint({
    summary(d())
  })
  
  # Generate an HTML table view of the head of the data ----
#  output$table <- renderTable({
#    head(data.frame(x = d()))
#  })
  
}

