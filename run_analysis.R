## Checking if file/folder exists and downloading data if it does not exist
   filename <- "getdata_projectfiles_UCI HAR Dataset.zip"
   if (!file.exists(filename)){
        fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(fileURL, filename, method="curl")
   }  
   if (!file.exists("UCI HAR Dataset")) { 
        unzip(filename) 
   }


## Setting up the environment
   library(data.table)
   library(dplyr)
   library(reshape2)


## Reading feature and activity_labels data sets
   feature <- read.table("./features.txt")
   activity_labels <- read.table("./activity_labels.txt", col.names = c("code","activity"))


## Reading the training data set
   subject_train <- read.table("./train/subject_train.txt", col.names = "subject")
   y_train <- read.table("./train/y_train.txt", col.names = "code")
   x_train <- read.table("./train/X_train.txt", col.names = feature[,2])


## Reading the testing data set
   subject_test <- read.table("./test/subject_test.txt", col.names = "subject")
   y_test <- read.table("./test/y_test.txt", col.names = "code")
   x_test <- read.table("./test/X_test.txt", col.names = feature[,2])


#########################################################################################################
## TASK 1: MERGE THE TRAINING AND THE TEST SETS TO CREATE ONE DATA SET
#########################################################################################################

## Merge the training and the test sets to create one data set
   subject <- rbind(subject_test, subject_train)
   y <- rbind(y_test, y_train)
   x <- rbind(x_test, x_train)
   complete_data <- cbind(subject, y , x)


#########################################################################################################
## TASK 2: EXTRACT ONLY THE MEASUREMENTS ON THE MEAN AND STANDARD DEVIATION FOR EACH MEASUREMENT
#########################################################################################################

## Create a subset of the complete data set with only mean and the standard deviation measurements for each subject/activity
   subset <- select(complete_data, subject, code, matches("mean|std"))


#########################################################################################################
## TASK 3: USE DESCRIPTIVE ACTIVITY NAMES TO NAME THE ACTIVITIES IN THE DATA SET
#########################################################################################################

## Changing activity code in the subset data with the descriptive activity name
   subset[,2] <- factor(subset[,2], levels = activity_labels[,1], label = activity_labels[,2])

## Renaming column 2 from "code" to "activity"
   colnames(subset)[2] <- "activity"


#########################################################################################################
## TASK 4: APPROPRIATELY LABEL THE DATA SET WITH DESCRIPTIVE VARIABLE NAMES
#########################################################################################################

## Cleaning up the column names from the feature data set

   subset[,2] <- tolower(subset[,2])  #lowercase activity names
   names(subset) <-  gsub("t(?=[A-Z])", "Time", names(subset), perl=TRUE)  # replacing "t" with "time"
   names(subset) <-  gsub("f(?=[A-Z])", "Freq", names(subset), perl=TRUE)  # replacing "f" with "freq"
   names(subset) <-  gsub("-", ".", names(subset))  #replacing "-" with "."
   names(subset) <-  gsub("\\()", "", names(subset))  #getting rid of "()"


###########################################################################################################################
## TASK 5: CREATES A SECOND, INDEPENDENT TINY DATA SET WITH THE AVERAGE OF EACH VARIABLE FOR EACH ACTIVITY AND EACH SUBJECT
###########################################################################################################################

## Pass the subset data through the melt function and set the id variables to "subject" and "activity."  
## This will allow us to organize the data in the next step by "subject" and "activity"
   sub_melt <- melt(subset, id.vars = c("subject", "activity"))

## Now that the data is melted it can be reshaped in various ways
## Use the dcast function to shape the data by subject(primary) and activity(secondary) in rows and the mean of each of their measure variables 
   tinydata <- dcast(sub_melt, subject + activity ~..., mean) 

## Write the tiny data set to a cvs file
   write.csv(tinydata, "tinydata.csv")
