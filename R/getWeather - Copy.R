getWeather <- function(lon, lat){
  #' API-retrived weather near Norrkoping
  #'
  #' @export getWeather
  #' 
  #' @param location The longitude and latitude of the weather retrieved.
  #' @param parameters The weather parameters obtained.
  #' @param CurrentDate The current date.
  #'
  #' @return The API that lets to retrieve information about weather near Norrkoping at longitude = 16 and at latitude = 58 at the current day.
  #' @examples
  #' getWeather()

  
 
  if(!is.numeric(lon) || !is.numeric(lat)){stop()}
  if((lon > 39.20) || (lon < -9.66)){stop()}
  if((lat > 71.2) || (lat < 52.40)){stop()}
  #The used guide https://www.dataquest.io/blog/r-api-tutorial/
  
  library(httr)
  library(jsonlite)
  
  #Server request:
  request <- httr::GET(paste0("https://opendata-download-metanalys.smhi.se/api/category/mesan1g/version/2/geotype/point/lon/",lon,"/lat/",lat,"/data.json"))
  
  #print(request)
  
  #Convert from raw unicode to .json to a list
  data <- jsonlite::fromJSON(rawToChar(request$content))
  location <- c("longitude" = 16, "latitude" = 58)
  
  #print("The chosen location:")
  #print(location)
  
  #Create a data.frame for analysis. 24 entries (time steps: 00:00-23.00)
  parameters <- data$timeSeries$parameters
  
  #print("Obtained parameters:")
  #print(parameters)
  
  currentDate = Sys.Date()
  
  retur <- list("date" = currentDate, "parameters" = parameters, "location" = location)

  return(retur)
}

getWeather(16, 58)