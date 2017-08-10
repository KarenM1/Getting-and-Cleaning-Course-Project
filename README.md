# Getting-and-Cleaning-Course-Project
Final project for the Getting and Cleaning course 

The Coursera Getting and Cleaning Data course project provides an exercise in taking raw data and preparing a tidy data set for analysis.  The raw data are provided from this URL: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
and includes a folder called UCI HAR Dataset, which contains:
- folders test and train
- text files activity_labels.txt, features.txt, features_info.txt, and README.txt.  
- The test and train folders each contain:
- an Inertial Signals folder (not used in this analysis)
- text files subject_test.txt, X_test.txt, y_test.txt (in the test folder) and subject_train.txt, X_train.txt, and y_train.txt (in the train folder).  
        
The course project requirement is as follows:
Create one R script called run_analysis.R that does the following.
- Merges the training and the test sets to create one data set
- Extracts only the measurements on the mean and standard deviation for each measurement.
- Uses descriptive activity names to name the activities in the data set
- Appropriately labels the data set with descriptive variable names.
- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each   subject.
     
Results of the project include these items:

1.  An R script called run_analysis.R
2.  A tidy data set called tidySetofMeans
3.  A README file
4.  A code book

Analysis files used in this project, from the UCI HAR Dataset were these:
- X_test.txt - data file for test data
- X_train.txt - data file for train data
- subject_test.txt - subject ID file for test data
- subject_train.txt - subject ID file for train data
- y_test.txt - activity identifiers for test data
- y_train.txt - activity identifiers for train data
- activity_labels.txt - readable names for activities to be mapped to the identifiers
- features.txt - variable names for measurements gathered in the test and train data 

See the features.txt, features_info.txt, and READme.txt files in the UCI HAR Dataset for details on those text file contents.

See the CodeBook for this project for description of how data is extracted from the source files and combined in to the tidy data set tidySetofMeans.
