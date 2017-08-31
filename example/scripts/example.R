download.file("https://ndownloader.figshare.com/files/2292169",
              "data/portal_data_joined.csv")
surveys <- read.csv("data/portal_data_joined.csv")

head(surveys)
dim(surveys)
nrow(surveys)
ncol(surveys)
names()