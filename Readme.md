# README.md
 The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set. 
 The goal is to prepare tidy data that can be used for later analysis.  

 One of the most exciting areas in all of data science right now is wearable computing. 
 Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users.
 The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. 
 A full description is available at the site where the data was obtained: 
        
 http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

 The data for the project can be found here: 
        
 https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

 This R script called run_analysis.R that does the following. 
 
 1. Merges the training and the test sets to create one data set.
 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
 3. Uses descriptive activity names to name the activities in the data set
 4. Appropriately labels the data set with descriptive variable names. 
 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

This README describe the step taken to produce the tidy data.

## Steps in producing the tidy data set 

1. Downloads required data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.
2. Manually unzip the file and copy the "UCI HAR Dataset" into the working folder.
3. Manually creates Output folder.
4. Create the feature dataset using features.txt.
5. Create the test dataset using X_test.txt, y_test.txt and subject_test.txt.
    * X_test contains the data using the feature dataset as columns.
    * y_test contains the activity labels.
    * subject_test contains the ids.
6. Create the train dataset using X_train.txt, y_train.txt and subject_train.txt.
    * X_train contains the data using the feature dataset as columns.
    * y_train contains the activity labels.
    * subject_train contains the ids.
7. Merge train and test dataset.
8. Arrange the merge data by id
9. Loads activity_labels.txt
10. Set the data activity row to using the activity labels
11. Create the mean and std dataset from the merge data as meansddata
12. Average of each variable for each activity and each subject and save it as tidydata
12. Saves the tidy dataset into tidy_dataset.txt