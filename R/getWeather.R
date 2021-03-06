getWeather <- function(lon, lat){
  #' API-retrieved weather near Norrkoping
  #'
  #' @export getWeather
  #' 
  #' @param url The processed url
  #' @param request The server response
  #' @param status The status of the server response
  #' @param data The returned data from the server
  #' @param variablesDf A data.frame with variables of interest
  #' @param lon The longitude.
  #' @param lat The latitude.
  #' @param times The retrieved times from the data
  #' @param temperature Temepatures
  #' @param wind_direction Wind directions
  #' @param wind_speed Wind speeds
  #' @param visibility Visibility
  #' @param pressure Pressures
  #' @param humidity Humidities
  #' @param currentDate The system current data
  #' @param retur The data.frame with objects required for analysis
  #' @param VariablesDf A data.frame that contains all variables of interest at a given day at an interval of 1 h.
  #' @param CurrentDate The current date.
  #'
  #' @return The API that lets to retrieve information about weather near Norrkoping at longitude = {lon1, lon2, lo3, lo4} and at latitude = {lat1, lat2, lat3, lat4} at the current day.

  
  
  
  if(!is.numeric(lon) || !is.numeric(lat)){stop()}

  #The used guide https://www.dataquest.io/blog/r-api-tutorial/
  
  url <- paste0("https://opendata-download-metanalys.smhi.se/api/category/mesan1g/version/2/geotype/point/lon/",lon,"/lat/",lat,"/data.json")
  
  # Server request:
  # https://stackoverflow.com/questions/12193779/how-to-write-trycatch-in-r
  
  request_server <- function(url){
    request <- tryCatch(
      {
        request <- httr::GET(url)
        #print(request)
      },
      error=function(cond) {
        message(paste("URL does not seem to exist:", url, sep = " "))
        message("Here's the original error message:")
        message(cond)
        return(NA)
      },
      error=function(cond = "Empty reply from server"){
        return(request)
      },
      warning=function(cond) {
        message(paste("URL caused a warning:", url))
        message("Here's the original warning message:")
        message(cond)
        # Choose a return value in case of warning
        return(NULL)
      },
      finally={
        message(paste("Processed URL:", url))
      }
    )    
    return(request)
  }
  
  #Request the server
  request <- request_server(url)
  
  #try - catch. Get around the error.
  
  status <- request$status
  #print(status)
  
 if(status == 200){
   #Convert from raw unicode to .json to a list
   data <- jsonlite::fromJSON(rawToChar(request$content))
   
   #Create a data.frame for analysis. 24 entries (time steps: 00:00-23.00)
   variables <- data$timeSeries$parameters
   
   #print("Obtained variables:")
   #print(variables)
   
   currentDate = Sys.Date()
   
   times = data$timeSeries$validTime
   
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
   VariablesDf <- cbind.data.frame("times" = times, "temperature" = temperature, "wind_direction" = wind_direction, "wind_speed" = wind_speed, "visibility" = visibility, "pressure" = pressure, "humidity" = humidity)
   #print(VariablesDf)
   
   retur <- list("status" = status, "date" = currentDate, "variables" = VariablesDf)
   #print(retur$variables$times)
   #print(retur$variables$temperature)
   return(retur)
  }
  else{
    message("The server cannot be reached!")
  }
  
}

#getWeather(16, 58)