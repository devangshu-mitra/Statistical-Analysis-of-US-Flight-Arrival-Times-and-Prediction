#Arrow package to read and write .parquet files
install.packages("arrow")
library(arrow)

#Streamline the process for creating predictive model
install.packages("caret")
library(caret)

#Dplyr package to manipulate data
install.packages("dplyr")
library(dplyr)

#Importing the formatted file
american_airlines.df = read_parquet("/Users/devangshumitra/Desktop/UTD MS Marketing/1. Course Materials/1. Fall 22/4. BUAN 6356 - BUSINESS ANALYTICS WITH R/Group Project/Data Sets/Individual Airline Wise/american_airlines_formated.df.parquet" )

#Logisticmodel to predict the whether a flight will be delayed or not

set.seed(1)
#Splitting data into 70% Training Set and 30% Validation Set
train.index <- sample(c(1:nrow(american_airlines.df)),round(nrow(american_airlines.df)*0.6))
train.df <-american_airlines.df[train.index,]
valid.df <- american_airlines.df[-train.index,]

#Logistic regression to predict whether a flight will be delayed or not based on departure delay, distance and scheduled flight duration
logistic.reg <- glm(ArrDelayBinary~DepDelayMinutes+Distance+CRSElapsedTime, 
                    data = train.df, family = "binomial" )
options(scipen=999)
summary(logistic.reg)

#predicting based on regression for validation data set
predict.valid=predict(logistic.reg, newdata=valid.df, type = "response")

#Confusion Matrix for validation dataset with 0.5 threshold
predict.valid.binary=ifelse(predict.valid > 0.5, 1, 0)
predict.valid.binary=as.factor(predict.valid.binary)

confusionMatrix(predict.valid.binary,valid.df$ArrDelayBinary)
