# Getting-and-Cleaning-Data-Course-Project
This is the final project for course [Getting and Cleaning Data](https://www.coursera.org/learn/data-cleaning).  The purpose of this assignment is to create a tiny data set through collecting, working with, and cleaning a data set.


## Data Source
The data used represents data collected from the accelerometers from the Samsung Galaxy S smartphone.  

A full description of the data is found [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). 

A link to the data for this project is found [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

## Data Analysis
Before working on the script the [data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) was downloaded and saved in a local RStudio folder.

The R script is titled [run_analysis.R](https://github.com/Sachi7/-Getting-and-Cleaning-Data-Course-Project/blob/master/run_analysis.R).  The assignment tasks and steps of the script are as followed:

#### Task 1: Merge the training and test sets to create one data set.
   1. The environment is set up.  The libraries needed are downloaded and the working directory is set.
   2. The desired data sets (train, test, activity labels, and feature) are read using read.table. Columms are named when appropriate.
   3. Data is merged using rbind, then cbind.
   
#### Task 2: Extract only the measurements on the mean and standard deviation for each measurement.
   
   4. Select function from dplyr is applied.  The subject column, activity column, and all measurement columns involving mean and standard deviation are selected as stated in the directions.  

#### Task 3: Use descriptive activity names to name the activities in the data set.

   5. The activity's column in the new data set is coded.  The corresponding code's descriptive activity is found in the activity_label data set.  The factor function is used to apply the desired substition.
   
#### Task 4: Appropriately label the data set with descriptive variable names.

   6. gsub is used to replace intial letters with a more descriptive name.  Ex. "t" is replaced with "Time".
   7. gsub used to correct syntax as outlined in the course's additional [power point](https://drive.google.com/file/d/0B1r70tGT37UxYzhNQWdXS19CN1U/view) resource
   
#### Task 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

   8. The data set is melted with the melt function.  Then, the dcast function is used to shape the data by subject(primary) and activity(secondary) in rows and the mean of each of their measure variables.  
   
### The goal of this script to create a tiny data set as specified in task 5.  An excerpt of the tiny data set can be found [here](https://github.com/Sachi7/-Getting-and-Cleaning-Data-Course-Project/blob/master/tinydata-excerpt).

