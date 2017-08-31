#get portal data
download.file("https://ndownloader.figshare.com/files/2292169",
              "data/portal_data_joined.csv")
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
row_last <- surveys[nrow(surveys),]