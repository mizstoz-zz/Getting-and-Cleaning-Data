# The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set. 
# The goal is to prepare tidy data that can be used for later analysis.  
#
# One of the most exciting areas in all of data science right now is wearable computing. 
# Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users.
# The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. 
# A full description is available at the site where the data was obtained: 
#        
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
#
# The data for the project can be found here: 
#        
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
#
# This R script called run_analysis.R that does the following. 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

library(plyr)

#Read txt and retun result as dataset
readsourcedata <- function (filename, cols = NULL)
{
        if(is.null(cols))
        {
                return (read.table(paste("UCI HAR Dataset", filename, sep="/"), sep="", stringsAsFactors=FALSE))
        }
        else 
        {
                return (read.table(paste("UCI HAR Dataset", filename, sep="/"), sep="", stringsAsFactors=FALSE, col.names= cols))
        }
}

#Read source data and build dataset
createdataset <- function(type, features)
{
        subject_data <- readsourcedata(paste(type,"/","subject_",type,".txt",sep=""),"id")
        y_data <- readsourcedata(paste(type,"/","y_",type,".txt",sep=""),"activity")
        x_data <- readsourcedata(paste(type,"/","X_",type,".txt",sep=""),features$V2)
        return (cbind(subject_data,y_data,x_data))
}

# 1. Merges the training and the test sets to create one data set.
# Create feature dataset
features <- readsourcedata("features.txt")

# Load the data and create the test dataset
test <- createdataset("test", features)

# Load the data and create the test dataset
train <- createdataset("train", features)

# Merge train and test dataset.
mergedata <- rbind(train, test)

# Arrange the merge data by id
mergedata <- arrange(mergedata, id)

#2. Extracts only the measurements on the mean and standard deviation for each measurement. 
meansddata <- mergedata[,c(1,2,grep("std", colnames(mergedata)), grep("mean", colnames(mergedata)))]

#3. Uses descriptive activity names to name the activities in the data set
activity_labels <- readsourcedata("activity_labels.txt")

#4. Appropriately labels the data set with descriptive variable names. 
meansddata$activity <- factor(meansddata$activity, levels=activity_labels$V1, labels=activity_labels$V2)

#5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
tidydata <- ddply(meansddata, .(id, activity), .fun=function(x){ colMeans(x[,-c(1:2)]) })
colnames(tidydata)[-c(1:2)] <- paste(colnames(tidydata)[-c(1:2)], "_mean", sep="")

# Create the tidy dataset as output
write.table(tidydata,paste("Output/tidy dataset.txt" ,sep=""),row.names = FALSE)