#Arrow package to read and write .parquet files
install.packages("arrow")
library(arrow)

#Writexl package to write .xlsx files
install.packages("writexl")
library(writexl)

#Dplyr package to manipulate data
install.packages("dplyr")
library(dplyr)

#Mosaic package for Statistics and Calculus
install.packages("mosaic")
library(mosaic)

#Importing data files for years 2018-22 in .parquet format, containing only the selected columns
flights_2022.df=read_parquet("/Users/devangshumitra/Desktop/UTD MS Marketing/1. Course Materials/1. Fall 22/4. BUAN 6356 - BUSINESS ANALYTICS WITH R/Group Project/Data Sets/Flight Status Prediction/Combined_Flights_2022.parquet")
flights_2021.df=read_parquet("/Users/devangshumitra/Desktop/UTD MS Marketing/1. Course Materials/1. Fall 22/4. BUAN 6356 - BUSINESS ANALYTICS WITH R/Group Project/Data Sets/Flight Status Prediction/Combined_Flights_2021.parquet")
flights_2020.df=read_parquet("/Users/devangshumitra/Desktop/UTD MS Marketing/1. Course Materials/1. Fall 22/4. BUAN 6356 - BUSINESS ANALYTICS WITH R/Group Project/Data Sets/Flight Status Prediction/Combined_Flights_2020.parquet")
flights_2019.df=read_parquet("/Users/devangshumitra/Desktop/UTD MS Marketing/1. Course Materials/1. Fall 22/4. BUAN 6356 - BUSINESS ANALYTICS WITH R/Group Project/Data Sets/Flight Status Prediction/Combined_Flights_2019.parquet")
flights_2018.df=read_parquet("/Users/devangshumitra/Desktop/UTD MS Marketing/1. Course Materials/1. Fall 22/4. BUAN 6356 - BUSINESS ANALYTICS WITH R/Group Project/Data Sets/Flight Status Prediction/Combined_Flights_2018.parquet")

#Combining all data frames into one by rows
flights_combined.df=rbind(flights_2022.df, flights_2021.df, flights_2020.df, flights_2019.df, flights_2018.df)

#storing the combined data frame as .parquet file
write_parquet(flights_combined.df,"/Users/devangshumitra/Desktop/UTD MS Marketing/1. Course Materials/1. Fall 22/4. BUAN 6356 - BUSINESS ANALYTICS WITH R/Group Project/Data Sets/flights_combined.df.parquet")

#creating a subset of data for 'American Airlines'
american_airlines.df = subset(flights_combined.df, flights_combined.df$Airline == "American Airlines Inc.")
write_parquet(american_airlines.df,"/Users/devangshumitra/Desktop/UTD MS Marketing/1. Course Materials/1. Fall 22/4. BUAN 6356 - BUSINESS ANALYTICS WITH R/Group Project/Data Sets/american_airlines.df.parquet")

#creating a subset of data for 'Southwest Airlines Co.'
southwest_airlines.df = subset(flights_combined.df, flights_combined.df$Airline == "Southwest Airlines Co.")
write_parquet(southwest_airlines.df,"/Users/devangshumitra/Desktop/UTD MS Marketing/1. Course Materials/1. Fall 22/4. BUAN 6356 - BUSINESS ANALYTICS WITH R/Group Project/Data Sets/southwest_airlines.df.parquet")

#creating a subset of data for 'Delta Air Lines Inc.'
delta_airines.df = subset(flights_combined.df, flights_combined.df$Airline == "Delta Air Lines Inc.")
write_parquet(delta_airines.df,"/Users/devangshumitra/Desktop/UTD MS Marketing/1. Course Materials/1. Fall 22/4. BUAN 6356 - BUSINESS ANALYTICS WITH R/Group Project/Data Sets/delta_airines.df.parquet")

#creating a subset of data for 'United Air Lines Inc.'
united_airines.df = subset(flights_combined.df, flights_combined.df$Airline == "United Air Lines Inc.")
write_parquet(united_airines.df,"/Users/devangshumitra/Desktop/UTD MS Marketing/1. Course Materials/1. Fall 22/4. BUAN 6356 - BUSINESS ANALYTICS WITH R/Group Project/Data Sets/united_airines.df.parquet")

#creating a subset of data for 'SkyWest Airlines Inc.'
skywest_airines.df = subset(flights_combined.df, flights_combined.df$Airline == "SkyWest Airlines Inc.")
write_parquet(skywest_airines.df,"/Users/devangshumitra/Desktop/UTD MS Marketing/1. Course Materials/1. Fall 22/4. BUAN 6356 - BUSINESS ANALYTICS WITH R/Group Project/Data Sets/skywest_airines.df.parquet")

#importing the combined .parquet file into a data frame
american_airlines.df=data.frame(read_parquet("/Users/devangshumitra/Desktop/UTD MS Marketing/1. Course Materials/1. Fall 22/4. BUAN 6356 - BUSINESS ANALYTICS WITH R/Group Project/Data Sets/Individual Airline Wise/american_airlines.df.parquet"))
southwest_airlines.df=data.frame(read_parquet("/Users/devangshumitra/Desktop/UTD MS Marketing/1. Course Materials/1. Fall 22/4. BUAN 6356 - BUSINESS ANALYTICS WITH R/Group Project/Data Sets/Individual Airline Wise/southwest_airlines.df.parquet"))

#Checking the summary of the data to figure out variables to be converted into variables
colnames(american_airlines.df)
summary(american_airlines.df)

#Checking the summary to verify changes made to the dataset and to understand the structure and features
summary(american_airlines.df)

#Checking the structure of the data
str(american_airlines.df)

#Converting required fields into numeric
american_airlines.df$CRSDepTime=as.numeric(american_airlines.df$CRSDepTime)
american_airlines.df$OriginStateFips=as.numeric(american_airlines.df$OriginStateFips)
american_airlines.df$OriginWac=as.numeric(american_airlines.df$OriginWac)
american_airlines.df$DestStateFips=as.numeric(american_airlines.df$DestStateFips)
american_airlines.df$DestWac=as.numeric(american_airlines.df$DestWac)
american_airlines.df$CRSArrTime=as.numeric(american_airlines.df$CRSArrTime)

#Verifying the change to numeric data types
str(american_airlines.df)

#Storing the column names as a xlsx file
names.df=data.frame(names(american_airlines.df))
write_xlsx(names.df, path = "/Users/devangshumitra/Desktop/UTD MS Marketing/1. Course Materials/1. Fall 22/4. BUAN 6356 - BUSINESS ANALYTICS WITH R/Group Project/Data Sets/Col Names/Column Names.df.xlsx")

#Importing selected columns to reduce the number of variables
selected_columns.df =c("FlightDate","Year","Quarter","Month","DayofMonth","DayOfWeek",
                       "Operating_Airline","Flight_Number_Operating_Airline","Airline","Distance","DistanceGroup",
                        "Marketing_Airline_Network","Flight_Number_Marketing_Airline",
                       "OriginCityName","OriginStateName","Origin","OriginState","DestCityName","DestStateName",
                       "Dest","DestState","Cancelled","Diverted","DivAirportLandings","CRSDepTime","DepTime",
                       "DepDelayMinutes","DepDelay","DepDel15","DepartureDelayGroups","DepTimeBlk","CRSArrTime",
                       "ArrTime","ArrDelayMinutes", "ArrDelay","ArrDel15","ArrivalDelayGroups","ArrTimeBlk","AirTime",
                       "TaxiOut","TaxiIn","CRSElapsedTime","ActualElapsedTime")
american_airlines.df = read_parquet("/Users/devangshumitra/Desktop/UTD MS Marketing/1. Course Materials/1. Fall 22/4. BUAN 6356 - BUSINESS ANALYTICS WITH R/Group Project/Data Sets/Individual Airline Wise/american_airlines.df.parquet",col_select =selected_columns.df )

summary(american_airlines.df)

#Creating a vector to store the variable names to be converted into factors, and then converting them into factors
variables_as_factor<-c("Year","Quarter","Month","DayofMonth","DayOfWeek", "Operating_Airline", 
                       "Flight_Number_Operating_Airline", "Airline","DistanceGroup", "Marketing_Airline_Network",
                       "Flight_Number_Marketing_Airline","OriginCityName","OriginStateName","Origin","OriginState",
                       "DestCityName","DestStateName","Dest","DestState","Cancelled","Diverted","DivAirportLandings",
                       "DepDel15","DepartureDelayGroups","DepTimeBlk","ArrDel15","ArrivalDelayGroups","ArrTimeBlk")
american_airlines.df[variables_as_factor]=lapply(american_airlines.df[variables_as_factor],as.factor)

#Checking the Sttructure of the data before adding new columns
str(american_airlines.df)

#Creating 2 new binary columns for DepDelayMinutes & ArrivalDelayMinutes and converting them to factors
american_airlines.df$DepDelayBinary=ifelse(american_airlines.df$DepDelayMinutes==0,'0','1')
american_airlines.df$DepDelayBinary=as.factor(american_airlines.df$DepDelayBinary)
american_airlines.df$ArrDelayBinary=ifelse(american_airlines.df$ArrDelayMinutes==0,'0','1')
american_airlines.df$ArrDelayBinary=as.factor(american_airlines.df$ArrDelayBinary)

#Saving the formated file on to the disk
write_parquet(american_airlines.df,"/Users/devangshumitra/Desktop/UTD MS Marketing/1. Course Materials/1. Fall 22/4. BUAN 6356 - BUSINESS ANALYTICS WITH R/Group Project/Data Sets/Individual Airline Wise/american_airlines_formated.df.parquet")

#Storing the column names as a xlsx file
names.df=data.frame(names(american_airlines.df))
write_xlsx(names.df, path = "/Users/devangshumitra/Desktop/UTD MS Marketing/1. Course Materials/1. Fall 22/4. BUAN 6356 - BUSINESS ANALYTICS WITH R/Group Project/Data Sets/Col Names/Formatted Column Names.df.xlsx")




