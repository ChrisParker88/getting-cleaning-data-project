setwd("E:\\Work\\Programming\\Data Science\\Coursera\\getting_cleaning_data\\course_project")

fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
file <- "HAR_dataset.zip"

#Download file if it does not exist
if(!file.exists(file)) {
  print("Downloading file...")
  download.file(fileURL, file)
}

#Unzip dataset, create folders if they do not exist
datafolder <- "UCI HAR Dataset"
resultsfolder <- "results"
if(!file.exists(datafolder)) {
  print("Unzipping file...")
  unzip(file, list = FALSE, overwrite = TRUE)
}
if(!file.exists(resultsfolder)) {
  print("Creating results folder...")
  dir.create(resultsfolder)
}

#Read .txt file and convert to data.frame
gettable <- function(filename, cols = NULL) {
  print(paste("Getting table:", filename))
  filepath <- paste(datafolder,filename,sep="/")
  data <- data.frame()
  if(is.null(cols)) {
    data <- read.table(filepath, sep="",stringsAsFactors=FALSE)
  }
  else {
    data <- read.table(filepath, sep="", col.names=cols)
  }
  data
}
#Create features dataframe with descriptive column names
features <- gettable("features.txt", c("Index", "Feature"))

#Read data and build individual dataframes
readData <- function(type, features) {
  print(paste("Reading data...", type))
  subject_data <- gettable(paste(type, "/", "subject_", type, ".txt", sep=""), "subject_id")
  x_data <- gettable(paste(type, "/", "X_", type, ".txt", sep=""), features$Feature)
  y_data <- gettable(paste(type, "/", "y_", type, ".txt", sep=""), "activity")
  return(cbind(subject_data, y_data, x_data))
}

#Create test & train dataframes
test <- readData("test", features)
train <- readData("train", features)

#Save resulting data files
saveResults <- function(data, name) {
  print(paste("Saving results: ", name, ".csv", sep=""))
  fileName <- paste(resultsfolder, "/", name, ".csv", sep="")
  write.csv(data, fileName)
}

# 1. Merge training and testing data sets into one
library(plyr)
data <- rbind(train, test)
data <- arrange(data, subject_id)

# 2. Extract only the measurements on the mean and stdev for each measurement
mean_std <- data[, c(1, 2, grep("std", colnames(data)), grep("mean", colnames(data)))]
saveResults(mean_std, "mean_std")

# 3. Use descriptive activity names to name the activities in the data set
activity_labels <- gettable("activity_labels.txt", c("Index", "Activity"))

# 4. Appropriately label the data set with descriptive variable names
data$activity <- factor(data$activity, levels=activity_labels$Index, labels=activity_labels$Activity)
#saveResults(data, "data")

# 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject
tidy <- ddply(mean_std, .(subject_id, activity), .fun=function(x){ colMeans(x[,-c(1:2)])})
colnames(tidy)[-c(1:2)] <- paste(colnames(tidy)[-c(1:2)], "_mean", sep="")
saveResults(tidy,"tidy")
write.table(tidy, "tidy_data.txt", row.name=FALSE)
