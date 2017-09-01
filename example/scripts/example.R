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

surveys %>% filter(year==1995) %>% 
  select(species_id,weight) %>% head

#Challenge
#Get columns year, sex, and weight for individuals
#before 1995
surveys %>% filter(year < 1995) %>%
  select(year,sex,weight)

#get the data with an extra column
#but not changing the original data
surveys %>% mutate(weight_kg = weight/1000) %>%
  head

#more than one new column
#second column can be based on the first col
surveys %>% mutate(weight_kg = weight/1000,
                   weight_kg2 = weight_kg*2) %>%
  tail

surveys %>% filter(!is.na(weight)) %>% tally
surveys %>% filter(!is.na(weight)) %>% head

#Challenge
#make a new data frame that contains species_id
#and hindfoot_half, where this is half the 
#hindfoot length
#only include length <30 and no NA (in length)
surveys_w_half <- surveys %>%
  mutate(hind_half = hindfoot_length/2) %>%
  filter(hind_half < 30) %>%
  filter(!is.na(hind_half)) %>%
  select(species_id, hind_half)

#Split Apply Combine
surveys %>% group_by(sex) %>%
  summarise(mean_weight = mean(weight, na.rm=TRUE))

surveys %>% group_by(sex,species_id) %>%
  summarise(mean_weight = mean(weight, na.rm=TRUE)) %>%
  filter(!is.na(mean_weight)) %>%
  tail

surveys %>% group_by(sex,species_id) %>%
  summarise(mean_weight = mean(weight, na.rm=TRUE),
            min_weight = min(weight)) %>%
  filter(!is.na(mean_weight)) %>%
  tail

surveys %>% group_by(sex,species_id) %>%
  tally

#Challenge
#1. how many individuals were caught in each plot type?
plot_caught <- surveys %>% group_by(plot_type) %>%
  tally
#2. what are the min,mean, max hindfoot length for
#each species
surveys %>% group_by(species_id) %>%
  summarise(min_h = min(hindfoot_length,na.rm = TRUE),
            mean_h = mean(hindfoot_length,na.rm = TRUE),
            max_h = max(hindfoot_length,na.rm=TRUE)) %>%
  filter(!is.na(mean_h))
#3. what was the heaviest species measured each year
#include year, genus, species_id, weight
surveys %>% group_by(year) %>%
  filter(weight == max(weight,na.rm = TRUE)) %>%
  select(year,genus,species_id,weight) %>%
  arrange(year)

surveys %>% group_by(year,genus,species_id) %>%
  summarize(mean_weight = mean(weight,na.rm=TRUE)) %>%
  group_by(year) %>%
  filter(mean_weight == max(mean_weight,na.rm=TRUE)) %>%
  select(year,genus,species_id,mean_weight) %>%
  arrange(year)

#Long v wide format
#wide = human readable
#long = computer readable
#data frame with mean weight of each genus for each plot
surveys_genus_weight <- surveys %>%
  filter(!is.na(weight)) %>%
  group_by(genus,plot_id) %>%
  summarise(mean_w = mean(weight))
#convert from long to wide
library(tidyr)
#in spread we have fill=0 because animals mass really was 0
#omit fill=0 to leave as NA
surveys_genus_weight_wide <- surveys_genus_weight %>%
  spread(genus,mean_w, fill=0)

surveys_genus_weight %>%
  spread(genus,mean_w, fill=0) %>%
  cor(use = "pairwise.complete")

surveys_genus_weight_long <- surveys_genus_weight_wide %>%
  gather(genus,mean_weight,-plot_id)

#challenge
#1. Make a wide data frame with
  #year as column
  #plot_id as row
  #number of genera (genuses :) as value
  #hint: check out the n_distinct function
surveys_ngen_plot_year <- surveys %>% group_by(year,plot_id) %>%
  summarise(n_gen = n_distinct(genus))
surveys_ngen_plot_year %>% 
  spread(plot_id,year,)

#2. make the data frame long so each row is a unique plot_id and year



