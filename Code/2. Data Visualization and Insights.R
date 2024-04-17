#Arrow package to read and write .parquet files
install.packages("arrow")
library(arrow)

#System for declaratively creating graphics, based on The Grammar of Graphics
install.packages("ggplot2")
library(ggplot2)

# map data to aesthetics, and provide methods for automatically determining breaks and labels for axes and legends.
install.packages("scales")
library(scales)

#Importing the formatted file
american_airlines.df = read_parquet("/Users/devangshumitra/Desktop/UTD MS Marketing/1. Course Materials/1. Fall 22/4. BUAN 6356 - BUSINESS ANALYTICS WITH R/Group Project/Data Sets/Individual Airline Wise/american_airlines_formated.df.parquet" )

#Creating a subset of american_airlines.df, with all flights which have arrived delayed
plotdata <- subset(american_airlines.df, ArrDelayBinary == "1")

#Scheduled Flight by Year
ggplot(american_airlines.df, aes(x = Year)) +
  geom_bar(fill = "indianred3",
           color = "black") +
  labs(x = "Year",
       y = "No. of Flights",
       title = "Scheduled Flight by Year")

#Scheduled Flight by Month
ggplot(american_airlines.df, aes(x = Month)) +
  geom_bar(fill = "indianred3",
           color = "black") +
  labs(x = "Month",
       y = "No. of Flights",
       title = "Scheduled Flight by Month")

#Scheduled Flight by Quarter
ggplot(american_airlines.df, aes(x = Quarter)) +
  geom_bar(fill = "indianred3",
           color = "black") +
  labs(x = "Quarter",
       y = "No. of Flights",
       title = "Scheduled Flight by Quarter")

#Arrival Delay by Month
ggplot(plotdata,
       aes(x = Month,
           y = ArrDelayMinutes)) +
  geom_violin(fill = "cornflowerblue") +
  geom_boxplot(width = .2,
               fill = "orange",
               outlier.color = "green",
               outlier.size = 2) +
  ylim(0,150)+
  labs(title = "Arrival Delay by Month")

#Departure Delay by Month
ggplot(plotdata,
       aes(x = Month,
           y = DepDelayMinutes)) +
  geom_violin(fill = "cornflowerblue") +
  geom_boxplot(width = .2,
               fill = "orange",
               outlier.color = "green",
               outlier.size = 2) +
  ylim(0,150)+
  labs(title = "Departure Delay by Month")

#Arrival Delay by Year
ggplot(plotdata,
       aes(x = Year,
           y = ArrDelayMinutes)) +
  geom_violin(fill = "cornflowerblue") +
  geom_boxplot(width = .2,
               fill = "orange",
               outlier.color = "green",
               outlier.size = 2) +
  ylim(0,100)+
  labs(title = "Arrival Delay by Year")

#Departure Delay by Year
ggplot(plotdata,
       aes(x = Year,
           y = DepDelayMinutes)) +
  geom_violin(fill = "cornflowerblue") +
  geom_boxplot(width = .2,
               fill = "orange",
               outlier.color = "green",
               outlier.size = 2) +
  ylim(0,100)+
  labs(title = "Departure Delay by Year")

#Arrival Delay by Quarters
ggplot(plotdata,
       aes(x = Quarter,
           y = ArrDelayMinutes)) +
  geom_violin(fill = "cornflowerblue") +
  geom_boxplot(width = .2,
               fill = "orange",
               outlier.color = "green",
               outlier.size = 2) +
  ylim(0,100)+
  labs(title = "Arrival Delay by Quarter")

#Departure Delay by Quarters
ggplot(plotdata,
       aes(x = Quarter,
           y = DepDelayMinutes)) +
  geom_violin(fill = "cornflowerblue") +
  geom_boxplot(width = .2,
               fill = "orange",
               outlier.color = "green",
               outlier.size = 2) +
  ylim(0,100)+
  labs(title = "Departure Delay by Quarter")

#Arrival Delay by Day Of Month
ggplot(plotdata,
       aes(x = DayofMonth,
           y = ArrDelayMinutes)) +
  geom_violin(fill = "cornflowerblue") +
  geom_boxplot(width = .2,
               fill = "orange",
               outlier.color = "green",
               outlier.size = 2) +
  ylim(0,85)+
  labs(title = "Arrival Delay by Day Of Month")+
  coord_flip()

#Departure Delay by Day Of Month
ggplot(plotdata,
       aes(x = DayofMonth,
           y = DepDelayMinutes)) +
  geom_violin(fill = "cornflowerblue") +
  geom_boxplot(width = .2,
               fill = "orange",
               outlier.color = "green",
               outlier.size = 2) +
  ylim(0,85)+
  labs(title = "Departure Delay by Day Of Month")+
  coord_flip()

#Arrival Delay by Departure Time Block
ggplot(plotdata,
       aes(x = DepTimeBlk,
           y = ArrDelayMinutes)) +
  geom_violin(fill = "cornflowerblue") +
  geom_boxplot(width = .2,
               fill = "orange",
               outlier.color = "green",
               outlier.size = 2) +
  ylim(0,100)+
  labs(title = "Arrival Delay by Departure Time Block")+
  coord_flip()

#Departure Delay by Departure Time Block
ggplot(plotdata,
       aes(x = DepTimeBlk,
           y = DepDelayMinutes)) +
  geom_violin(fill = "cornflowerblue") +
  geom_boxplot(width = .2,
               fill = "orange",
               outlier.color = "green",
               outlier.size = 2) +
  ylim(0,100)+
  labs(title = "Departure Delay by Departure Time Block")+
  coord_flip()

#Arrival Delay by Arrival Time Block
ggplot(plotdata,
       aes(x = ArrTimeBlk,
           y = ArrDelayMinutes)) +
  geom_violin(fill = "cornflowerblue") +
  geom_boxplot(width = .2,
               fill = "orange",
               outlier.color = "green",
               outlier.size = 2) +
  ylim(0,100)+
  labs(title = "Arrival Delay by Arrival Time Block")+
  coord_flip()

#Departure Delay by Arrival Time Block
ggplot(plotdata,
       aes(x = ArrTimeBlk,
           y = DepDelayMinutes)) +
  geom_violin(fill = "cornflowerblue") +
  geom_boxplot(width = .2,
               fill = "orange",
               outlier.color = "green",
               outlier.size = 2) +
  ylim(0,100)+
  labs(title = "Departure Delay by Arrival Time Block")+
  coord_flip()

#Arrival Delay by Origin State
ggplot(plotdata,
       aes(x = OriginState,
           y = ArrDelayMinutes)) +
  geom_violin(fill = "cornflowerblue") +
  geom_boxplot(width = .2,
               fill = "orange",
               outlier.color = "green",
               outlier.size = 2) +
  ylim(0,85)+
  labs(title = "Arrival Delay by Origin State", )+
  coord_flip()+
  theme(axis.text=element_text(size = 14, face = "bold"))

#Arrival Delay by Destination State
ggplot(plotdata,
       aes(x = DestState,
           y = ArrDelayMinutes)) +
  geom_violin(fill = "cornflowerblue") +
  geom_boxplot(width = .2,
               fill = "orange",
               outlier.color = "green",
               outlier.size = 2) +
  ylim(0,85)+
  labs(title = "Arrival Delay by Destination State", )+
  coord_flip()+
  theme(axis.text=element_text(size = 14, face = "bold"))

#Departure Delay by Origin State
ggplot(plotdata,
       aes(x = OriginState,
           y = DepDelayMinutes)) +
  geom_violin(fill = "cornflowerblue") +
  geom_boxplot(width = .2,
               fill = "orange",
               outlier.color = "green",
               outlier.size = 2) +
  ylim(0,85)+
  labs(title = "Departure Delay by Origin State", )+
  coord_flip()+
  theme(axis.text=element_text(size = 14, face = "bold"))

#Departure Delay by Destination State
ggplot(plotdata,
       aes(x = DestState,
           y = DepDelayMinutes)) +
  geom_violin(fill = "cornflowerblue") +
  geom_boxplot(width = .2,
               fill = "orange",
               outlier.color = "green",
               outlier.size = 2) +
  ylim(0,85)+
  labs(title = "Departure Delay by Destination State", )+
  coord_flip()+
  theme(axis.text=element_text(size = 14, face = "bold"))

#Arrival Delay by Flight Date Time Series
ggplot(plotdata,aes(x=FlightDate,y=ArrDelayMinutes))+
  geom_line(color = "indianred3",
            size=0.1 )+
  geom_smooth()+
  ylim(0,1000)+
  labs(title = "Arrival Delay by Flight Date" )

#Departure Delay by Flight Date Time Series
ggplot(plotdata,aes(x=FlightDate,y=DepDelayMinutes))+
  geom_line(color = "indianred3",
            size=0.1 )+
  geom_smooth()+
  ylim(0,1000)+
  labs(title = "Departure Delay by Flight Date" )

#Visualizing Delay by the top 5 airlines in terms of the number of flights
#Importing the files
#Loading the subset of data for 'American Airlines'
american_airlines.df = read_parquet("/Users/devangshumitra/Desktop/UTD MS Marketing/1. Course Materials/1. Fall 22/4. BUAN 6356 - BUSINESS ANALYTICS WITH R/Group Project/Data Sets/Individual Airline Wise/american_airlines.df.parquet")

#Loading the subset of data for 'Southwest Airlines Co.'
southwest_airlines.df = read_parquet("/Users/devangshumitra/Desktop/UTD MS Marketing/1. Course Materials/1. Fall 22/4. BUAN 6356 - BUSINESS ANALYTICS WITH R/Group Project/Data Sets/Individual Airline Wise/southwest_airlines.df.parquet")

#Loading the subset of data for 'Delta Air Lines Inc.'
delta_airines.df = read_parquet("/Users/devangshumitra/Desktop/UTD MS Marketing/1. Course Materials/1. Fall 22/4. BUAN 6356 - BUSINESS ANALYTICS WITH R/Group Project/Data Sets/Individual Airline Wise/delta_airines.df.parquet")

#Loading the subset of data for 'United Air Lines Inc.'
united_airines.df = read_parquet("/Users/devangshumitra/Desktop/UTD MS Marketing/1. Course Materials/1. Fall 22/4. BUAN 6356 - BUSINESS ANALYTICS WITH R/Group Project/Data Sets/Individual Airline Wise/united_airines.df.parquet")

#Loading the subset of data for 'SkyWest Airlines Inc.'
skywest_airines.df = read_parquet("/Users/devangshumitra/Desktop/UTD MS Marketing/1. Course Materials/1. Fall 22/4. BUAN 6356 - BUSINESS ANALYTICS WITH R/Group Project/Data Sets/Individual Airline Wise/skywest_airines.df.parquet")

#Combining all data frames into one by rows
combined_airlines.df=rbind(american_airlines.df, southwest_airlines.df, delta_airines.df, united_airines.df, skywest_airines.df)

#Converting Airlines into factors
combined_airlines.df$Airline=as.factor(combined_airlines.df$Airline)

#Departure Delay Vs Airline
ggplot(combined_airlines.df,
       aes(x = Airline,
           y = DepDelayMinutes)) +
  geom_boxplot()+
  labs(title = "Departure Delay by Airline")

#Arrival Delay Vs Airline
ggplot(combined_airlines.df,
       aes(x = Airline,
           y = ArrDelayMinutes)) +
  geom_boxplot()+
  labs(title = "Arrival Delay by Airline")
