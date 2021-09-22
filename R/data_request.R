#The API 
#The used guide https://www.dataquest.io/blog/r-api-tutorial/

#Source: Kolada

library(httr)
library(jsonlite)

#Server request:
request <- httr::GET("https://opendata-download-metanalys.smhi.se/api/category/fwia1g/version/1/daily/geotype/point/lon/20/lat/58/data.json")

print(request)
#Convert from raw unicode to .json to a list
data <- jsonlite::fromJSON(rawToChar(request$content))
keys <- names(data)
print(as.data.frame(data))
