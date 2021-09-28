
server <- function(input, output) {

observeEvent(input$lonlat, {
  lon <- 0
  lat <- 0
  if (input$lonlat == 1) {lon <- 2.00; lat <- 52.40}
  if (input$lonlat == 2) {lon <- 27.74; lat <- 52.43}
  if (input$lonlat == 3) {lon <- 39.20; lat <- 71.20}
  if (input$lonlat == 4) {lon <- -9.66; lat <- 71.14}
 
  minaData <- getWeather(lon, lat)
  
  time           <- minaData$variables$times
  temperature    <- minaData$variables$temperature
  wind_direction <- minaData$variables$wind_direction
  wind_speed     <- minaData$variables$wind_speed
  visibility     <- minaData$variables$visibility
  pressure       <- minaData$variables$pressure
  humidity       <- minaData$variables$humidity
  
  
  data <- data.frame(time, temperature, wind_direction, wind_speed, visibility, pressure, humidity)
  data <- data[order(time),] 
  
  klockslag <- c(1:24)
  
output$plot1 <- renderPlot({
  mingraf <- ggplot2::ggplot(data, ggplot2::aes(x = klockslag, y = temperature)) + ggplot2::geom_line(colour = 'blue', size = 1)
  mingraf <- mingraf + ggplot2::geom_point(colour = 'red', size = 2) + ggplot2::ylab('Temperature') + ggplot2::xlab('Time (h) (Latest available 24 hours)')
  mingraf 
})
  
output$plot2 <- renderPlot({
  mingraf <- ggplot2::ggplot(data, ggplot2::aes(x = klockslag, y = wind_direction)) + ggplot2::geom_line(colour = 'blue', size = 1)
  mingraf <- mingraf + ggplot2::geom_point(colour = 'red', size = 2) + ggplot2::ylab('Wind direction') + ggplot2::xlab('Time (h) (Latest available 24 hours)')
  mingraf 
})

output$plot3 <- renderPlot({
  mingraf <- ggplot2::ggplot(data, ggplot2::aes(x = klockslag, y = wind_speed)) + ggplot2::geom_line(colour = 'blue', size = 1)
  mingraf <- mingraf + ggplot2::geom_point(colour = 'red', size = 2) + ggplot2::ylab('Wind speed') + ggplot2::xlab('Time (h) (Latest available 24 hours)')
  mingraf 
}) 

output$plot4 <- renderPlot({
  mingraf <- ggplot2::ggplot(data, ggplot2::aes(x = klockslag, y = visibility)) + ggplot2::geom_line(colour = 'blue', size = 1)
  mingraf <- mingraf + ggplot2::geom_point(colour = 'red', size = 2) + ggplot2::ylab('Visibility') + ggplot2::xlab('Time (h) (Latest available 24 hours)')
  mingraf 
})  

output$plot5 <- renderPlot({
  mingraf <- ggplot2::ggplot(data, aes(x = klockslag, y = pressure)) + ggplot2::geom_line(colour = 'blue', size = 1)
  mingraf <- mingraf + ggplot2::geom_point(colour = 'red', size = 2) + ggplot2::ylab('Pressure') + ggplot2::xlab('Time (h) (Latest available 24 hours)')
  mingraf 
})  

output$plot6 <- renderPlot({
  mingraf <- ggplot2::ggplot(data, ggplot2::aes(x = klockslag, y = humidity)) + ggplot2::geom_line(colour = 'blue', size = 1)
  mingraf <- mingraf + ggplot2::geom_point(colour = 'red', size = 2) + ggplot2::ylab('Humidity') + ggplot2::xlab('Time (h) (Latest available 24 hours)')
  mingraf 
}) 

}) 
  
}