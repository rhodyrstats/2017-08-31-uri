download.file("https://raw.githubusercontent.com/rhodyrstats/2017-08-31-uri/gh-pages/data/test.csv",
              "test.csv")
test <- read.csv("test.csv", 
                 na.strings = "na")
test
