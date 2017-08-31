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