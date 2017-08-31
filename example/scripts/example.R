#get portal data
download.file("https://ndownloader.figshare.com/files/2292169",
              "data/portal_data_joined.csv")
#surveys <- read.csv("data/portal_data_joined.csv", 
#                    na.strings = c('missing','NA','na'))
surveys <- read.csv("data/portal_data_joined.csv")
#surveys <- read.csv("data/portal_data_joined.csv",
#                    stringsAsFactors = FALSE)

#this is how I get info about the data
head(surveys)
dim(surveys)
nrow(surveys)
ncol(surveys)
names(surveys)
head(rownames(surveys))
str(surveys)

#access some of the data
all_sp_ids <- surveys$species_id
all_sp_ids2 <- surveys[,"species_id"]
all_sp_ids_df <- surveys["species_id"]
all_sp_ids3 <- surveys[["species_id"]]

surveys[1,1]
surveys[1,6]
surveys[1,]
surveys[1:3,1:3]

surveys_sample1 <- surveys[1,]

#Challenge
#1. Create a data frame containing only row 200
survey200 <- surveys[200,]
#2. Find the number of rows in surveys and create a 
#data frame of the last row
nrow(surveys) #outputs 34786
row_last <- surveys[34786,]
#3. Create a data frame of the last row _without_ inputing
# the row number directly

num_of_rows <-nrow(surveys) #stores 34786 in num_of_rows
row_last <- surveys[num_of_rows,] 

str(row_last <- surveys[nrow(surveys),])
#option 2
str(tail(surveys,1))

#view in a separate window
View(row_last)
View(surveys[nrow(surveys),])

#calculate the mean of a column (eg weight)
mean(surveys$weight, na.rm = TRUE)

#convert weights to kg
tail(surveys$weight/1000)
tail(surveys$weight)
surveys$weight_kg <-surveys$weight/1000
surveys$hf_w <- surveys$hindfoot_length/surveys$weight

#types of data
str(surveys)
surveys$taxa
nlevels(surveys$taxa)
as.character(surveys$taxa)

#be careful with factors!
#factors that look like integers will convert to the 
#wrong value with as.numeric
year_as_factor <- factor(surveys$year)
as.numeric(year_as_factor)
as.numeric(as.character(year_as_factor))

plot(surveys$sex)
sex <- surveys$sex
head(sex)
levels(sex)
levels(sex)[1] <- "missing"

#Challenge
#rename M and F as Male and Female
levels(sex)[2] <- "Female"
levels(sex)[3] <- "Male"

levels(sex) <- c("Missing","Female","Male")
plot(sex)
sex[75]

#dates
#keep Y, M, D as separate columns
#YYYY-MM-DD is best for sorting

install.packages('lubridate')
library(lubridate)
#put all three date related columns into a single list
mydates <- paste(surveys$year,surveys$month,surveys$day,
      sep = "-")
head(mydates)
ymd(mydates)
surveys$date <- ymd(mydates)
#note that some dates didn't convert
#dates that don't exist are converted to NA
#might consider converting these to the next real day
str(surveys)

#Data Manipulation
library(dplyr)
#install if needed
#dplyr is part of the tidyverse which can be
#installed as one unit
#it's too large to have everyone install on URI
#wifi right now

#get some columns
head(select(surveys,plot_id,species_id,weight))
surveys_95 <- filter(surveys,year==1995)
head(filter(surveys,year!=1995))

select(surveys_95,species_id, weight)

surveys %>% filter(year==1995) %>% head
