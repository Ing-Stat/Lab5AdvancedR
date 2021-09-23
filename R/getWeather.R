getWeather <- function(lon, lat){
  #' API-retrived weather near Norrkoping
  #'
  #' @export getWeather
  #' 
  #' @param lon The longitude.
  #' @param lat The latitude.
  #' @param VariablesDf A data.frame that contains all variables of interest at a given day at an interval of 1 h.
  #' @param CurrentDate The current date.
  #'
  #' @return The API that lets to retrieve information about weather near Norrkoping at longitude = {lon1, lon2, lo3, lo4} and at latitude = {lat1, lat2, lat3, lat4} at the current day.
  #' @examples
  #' getWeather(16, 58)
  
  
  
  if(!is.numeric(lon) || !is.numeric(lat)){stop()}
  #if((lon > 39.20) || (lon < -9.66)){stop()}
  #if((lat > 71.2) || (lat < 52.40)){stop()}
  #The used guide https://www.dataquest.io/blog/r-api-tutorial/
  
  library(httr)
  library(jsonlite)
  
  #Server request:
  request <- httr::GET(paste0("https://opendata-download-metanalys.smhi.se/api/category/mesan1g/version/2/geotype/point/lon/",lon,"/lat/",lat,"/data.json"))
  
  status <- request$status
  #print(status)
  
  #Convert from raw unicode to .json to a list
  data <- jsonlite::fromJSON(rawToChar(request$content))
  
  #Create a data.frame for analysis. 24 entries (time steps: 00:00-23.00)
  variables <- data$timeSeries$parameters
  
  #print("Obtained variables:")
  #print(variables)
  
  currentDate = Sys.Date()
  
  times = c("00:00", "01:00", "02:00", "03:00", "04:00", "05:00", "06:00", "07:00", "08:00", "09:00", "10:00", "11:00", "12:00", "13:00", "14:00", "15:00", "16:00", "17:00", "18:00", "19:00", "20:00", "21:00", "22:00", "23:00")
  
  #Create vectors for each variable of interest.
  temperature <- c()
  wind_direction <- c()
  wind_speed <- c()
  visibility <- c()
  pressure <- c()
  humidity <- c()
  
  #print(variables)
  #print(variables[[1]][1,5])
  #print(unlist(variables[[1]][,1]))
  
  #Unfortunately, all 24 data entries are different. Thus, the correct place at the table should be found to read from. This is done by operation 'which'. The values of the variables are, fortunately, at the 5th column.
  #Fill the vectors of each variable of interest.
  for (i in 1:24){
    temperature <- c(temperature, variables[[i]][which(as.vector(variables[[i]][,1]) == "t"),5])
    wind_direction <- c(wind_direction, variables[[i]][which(as.vector(variables[[i]][,1]) == "wd"),5])
    wind_speed <- c(wind_speed, variables[[i]][which(as.vector(variables[[i]][,1]) == "ws"),5])
    visibility <- c(visibility, variables[[i]][which(as.vector(variables[[i]][,1]) == "vis"),5])
    pressure <- c(pressure, variables[[i]][which(as.vector(variables[[i]][,1]) == "msl"),5])
    humidity <- c(humidity, variables[[i]][which(as.vector(variables[[i]][,1]) == "r"),5])
    #print(temperature)
  }
  
  #Prepare to create the data.frame.
  temperature <- unlist(temperature)
  wind_direction <- unlist(wind_direction)
  wind_speed <- unlist(wind_speed)
  visibility <- unlist(visibility)
  pressure <- unlist(pressure)
  humidity <- unlist(humidity)
  
  #Create the data.frame
  VariablesDf <- cbind.data.frame("time" = times, "temperature" = temperature, "wind_direction" = wind_direction, "wind_speed" = wind_speed, "visibility" = visibility, "pressure" = pressure, "humidity" = humidity)
  #print(VariablesDf)
  
  retur <- list("status" = status, "date" = currentDate, "variables" = VariablesDf)
  #print(retur$variables$visibility)
  return(retur)
}

getWeather(16, 58)