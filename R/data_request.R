#The API Kolada
#The used guide https://www.dataquest.io/blog/r-api-tutorial/

#Source: Kolada

library(httr)
library(jsonlite)

#Server request:
request <- httr::GET("http://api.kolada.se/v2/municipality?title=lund")

#Convert from raw unicode to .json to a list
data <- jsonlite::fromJSON(rawToChar(request$content))
print(data)

#10 largest cities in Sweden (starting from the largest): Stockholm, Gothenburg, Malmo, Uppsala, Vasteros, Orebro, Linkoping, Helsingborg, Jonkoping, Norrkoping
#Data: