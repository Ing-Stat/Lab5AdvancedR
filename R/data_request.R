getWeather <- function(){
  #The API 
  #The used guide https://www.dataquest.io/blog/r-api-tutorial/
  
  library(httr)
  library(jsonlite)
  
  #Server request:
  request <- httr::GET(paste0("https://opendata-download-metanalys.smhi.se/api/category/mesan1g/version/2/geotype/point/lon/16/lat/58/data.json"))
  
  #print(request)
  
  #Convert from raw unicode to .json to a list
  data <- jsonlite::fromJSON(rawToChar(request$content))
  location <- data$geometry
  
  print("The chosen location:")
  print(location)
  
  #Create a data.frame for analysis. 24 entries (time steps: 00:00-23.00)
  parameters <- data$timeSeries$parameters
  
  print("Obtained parameters:")
  print(parameters)
  
  currentDate = Sys.Date()

}

#getWeather()