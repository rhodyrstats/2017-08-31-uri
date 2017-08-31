#get portal data
download.file("https://ndownloader.figshare.com/files/2292169",
              "data/portal_data_joined.csv")
#surveys <- read.csv("data/portal_data_joined.csv", 
#                    na.strings = c('missing','NA','na'))
surveys <- read.csv("data/portal_data_joined.csv")

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

