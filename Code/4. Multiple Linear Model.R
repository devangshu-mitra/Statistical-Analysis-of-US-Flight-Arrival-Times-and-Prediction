#Arrow package to read and write .parquet files
install.packages("arrow")
library(arrow)

#System for declaratively creating graphics, based on The Grammar of Graphics
install.packages("ggplot2")
library(ggplot2)

#Dplyr package to manipulate data
install.packages("dplyr")
library(dplyr)

#Streamline the process for creating predictive model
install.packages("caret")
library(caret)

#For performing variable selection for Linear Mode
install.packages("faraway")
library(faraway)

#Importing the formatted file
american_airlines.df = read_parquet("/Users/devangshumitra/Desktop/UTD MS Marketing/1. Course Materials/1. Fall 22/4. BUAN 6356 - BUSINESS ANALYTICS WITH R/Group Project/Data Sets/Individual Airline Wise/american_airlines_formated.df.parquet" )
attach(american_airlines.df)

#Variable selection using Forward, Backward and Step
american_mod_start=lm(ArrDelayMinutes~1, data = american_airlines.df)

#First forward variable selection without DepDelayMinutes
#DepTime+DepDelayMinutes+DepDelay+DepartureDelayGroups+Cancelled+Diverted+DivAirportLandings+TaxiOut+TaxiIn
american_mod_for_aic=step(american_mod_start, scope = ArrDelayMinutes~ FlightDate+Year+Quarter+Month+
                            DayofMonth+DayOfWeek+Distance+OriginCityName+OriginStateName+Origin+
                            OriginState+DestCityName+DestStateName+Dest+DestState+
                            CRSDepTime++DepTimeBlk+CRSArrTime+ArrTimeBlk+TaxiOut+
                            TaxiIn+CRSElapsedTime, direction = "forward")

#First stepwise variable selection without DepDelayMinutes
american_mod_both_aic = step(american_mod_start, scope = ArrDelayMinutes~ FlightDate+Year+Quarter+
                               Month+DayofMonth+DayOfWeek+Distance+OriginCityName+OriginStateName+
                               Origin+OriginState+DestCityName+DestStateName+Dest+DestState+
                               CRSDepTime+DepTimeBlk+CRSArrTime+ArrTimeBlk+
                               CRSElapsedTime, direction = "both")

#Creating a model with outcome variables obtained
my_lm1=lm(ArrDelayMinutes ~ DepTimeBlk + Month + Year + Origin + DayofMonth + 
            FlightDate + DayOfWeek + ArrTimeBlk + CRSDepTime + CRSArrTime + 
            CRSElapsedTime + Distance + Dest, data = american_airlines.df)
summary(my_lm1)

##Second variable selection with DepDelayMinutes, and variables selected from previous outcome
american_mod_both_aic = step(american_mod_start, scope = ArrDelayMinutes~ DepTimeBlk + Month + 
                               Year + Origin + DayofMonth + FlightDate + DayOfWeek + ArrTimeBlk + 
                               CRSDepTime + CRSArrTime + CRSElapsedTime + Distance + Dest + 
                               DepTime + DepDelayMinutes + DepDelay, direction = "both")


#Creating a model with outcome variables obtained
my_lm2=lm(ArrDelayMinutes ~ DepDelayMinutes + DepDelay + Year + Dest + 
            ArrTimeBlk + Origin + Month + DayOfWeek + DayofMonth + DepTimeBlk + 
            DepTime + CRSElapsedTime + Distance + CRSDepTime + CRSArrTime, data = american_airlines.df)
summary(my_lm2)

#Running the same model using forward variable selection to see the output
american_mod_for_aic2=step(american_mod_start, scope = ArrDelayMinutes~ DepDelayMinutes + DepDelay + Year + Dest + 
                             ArrTimeBlk + Origin + Month + DayOfWeek + DayofMonth + DepTimeBlk + 
                             DepTime + CRSElapsedTime + Distance + CRSDepTime + CRSArrTime, direction = "forward")

#Running the same model using backward variable elimination to see the output
american_mod_start1 = lm(ArrDelayMinutes ~ DepDelayMinutes + DepDelay + Year + Dest + 
                           ArrTimeBlk + Origin + Month + DayOfWeek + DayofMonth + DepTimeBlk + 
                           DepTime + CRSElapsedTime + Distance + CRSDepTime + CRSArrTime, data = american_airlines.df)

american_mod_back_aic = step(american_mod_start1, direction = "backward")

#Creating the multiple linear model using the selected variables
my_lm3=lm(ArrDelayMinutes ~ DepDelayMinutes + DepDelay + Year + Dest + 
            ArrTimeBlk + Origin + Month + DayOfWeek + DayofMonth + DepTimeBlk + 
            DepTime + CRSElapsedTime + Distance + CRSDepTime + CRSArrTime, data = american_airlines.df)
summary(my_lm3)

set.seed(2)

#Linear Model to Predict Arrival Delay Minutes
#Splitting data into 70% Training Set and 30% Validation Set
train.index <- sample(c(1:nrow(american_airlines.df)),round(nrow(american_airlines.df)*0.7))
train.df <-american_airlines.df[train.index,]
valid.df <- american_airlines.df[-train.index,]
#Creating the Linear Model using the variables selected
model_lm<-lm(ArrDelayMinutes ~ DepDelayMinutes + DepDelay + Year + Dest + 
               ArrTimeBlk + Origin + Month + DayOfWeek + DayofMonth + DepTimeBlk + 
               DepTime + CRSElapsedTime + Distance + CRSDepTime + CRSArrTime,data = train.df )
summary(model_lm)
#Predicting on the validation set using the linear model
predictions=predict(model_lm,newdata = valid.df)

#Plotting the actual arrival delay values vs predicted arrival delay
#The straight line means that the actual and predicted values are very close
plot(valid.df$ArrDelayMinutes,predictions)

#Creating a data frame to store the R^2, RMSE and MAE values for the model
accuracy_lm=data.frame(R2 = R2(predictions, valid.df$ArrDelayMinutes, na.rm = T), 
                    RMSE = RMSE(predictions, valid.df$ArrDelayMinutes, na.rm = T), 
                    MAE = MAE(predictions, valid.df$ArrDelayMinutes, na.rm = T))
accuracy_lm

#Plotting the various graphs of residuals, fitted and leverage
plot(model_lm)
