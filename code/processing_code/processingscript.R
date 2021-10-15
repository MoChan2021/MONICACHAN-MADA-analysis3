###############################
# processing script


#load needed packages. make sure they are installed.
library(readxl) #for loading Excel files
library(dplyr) #for data processing
library(here) #to set paths

#path to data

data_location <- here::here("data","raw_data","SympAct_Any_Pos.Rda")

#load data. 

rawdata <- readRDS(data_location)

#take a look at the data
dplyr::glimpse(rawdata)
str(rawdata)
summary(rawdata)

#remove varible Score, Total, FluA, FluB, Dxname, or activity in name
#chose to use direct pipes since the actions were so similar and I didn't wnat to repeat myself too much in the comments
##select(-contains("")) == removes columns with the whatever is inside the "quotes".
rawdata1<-rawdata%>%
  select(-contains("Score"))%>% #removed cols containing Score
  select(-contains("Total"))%>% #removed cols containing Total
  select(-contains("FluA"))%>% #removed cols containing FluA
  select(-contains("FluB"))%>% #removed cols containing FluB
  select(-contains("DxName"))%>% #removed cols containing DxName
  select(-contains("Activity"))%>% #removed cols containing Activity
  select(-c(Unique.Visit)) # -c removes exactly named cols, remove col Unique.Visit
  
#take a look at  cleaned data  removed cols directed by assessment page
glimpse(rawdata1)  
str(rawdata1)
summary(rawdata1)

#the data set is not quite like the assignment I am 5 over in observations
#noted that BodyTemp has 5 NA's, need to remove

rawdata2<-rawdata1%>%
  na.omit() # omit NAs in the data set

#take a look at  cleaned data to assignment specs (760 obv. of 32 variables)
glimpse(rawdata2)  
str(rawdata2)
summary(rawdata2)

# location to save file
save_data_location <- here::here("data","processed_data","processeddata.rds")

saveRDS(rawdata2, file = save_data_location)


