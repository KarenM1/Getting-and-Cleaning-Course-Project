# Download the source file from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
# and unzip it, with thanks to lgreski Tutorial: Downloading files at https://github.com/lgreski/datasciencectacontent/blob/master/markdown/rprog-downloadingFiles.md()

setwd("C:/Users/kmassey/datasciencecoursera/Course Project")
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url,
              destfile='HAR.zip',
              mode="wb") # "wb" means "write binary," and is used for binary files
unzip(zipfile = "HAR.zip") # unpack the files into subdirectories 

#create a new directory and copy the test and train files to it
dir.create("runAnalysis")
targetdir <- c("C:/Users/kmassey/datasciencecoursera/Course Project/runAnalysis")
setwd("C:/Users/kmassey/datasciencecoursera/Course Project/UCI HAR Dataset/test")
filestocopy<-c("subject_test.txt","X_test.txt","y_test.txt")
file.copy(from=filestocopy, to=targetdir)
setwd("C:/Users/kmassey/datasciencecoursera/Course Project/UCI HAR Dataset/train")
filestocopy<-c("subject_train.txt","X_train.txt","y_train.txt")
file.copy(from=filestocopy, to=targetdir)
setwd("C:/Users/kmassey/datasciencecoursera/Course Project/runAnalysis")

# read the txt files into dataframes.

testFile<- read.table("X_test.txt", header = FALSE, sep = "") # data file for test data
trainFile<- read.table("X_train.txt", header = FALSE, sep = "") # data file for train data
testSubjects<- read.table("subject_test.txt", header = FALSE, sep = "") # subject file for test data
trainSubjects<-read.table("subject_train.txt", header = FALSE, sep = "") # subject file for train data
testActivityLabels<- read.table("y_test.txt", header = FALSE, sep = "") # activity identifiers for test data
trainActivityLabels<-read.table("y_train.txt", header = FALSE, sep = "") # activity identifiers for train data
activityLabels<- read.table("activity_labels.txt", header = FALSE, sep = "") # readable names for activities mapped to identifiers
featuresVariables<- read.table("features.txt", header = FALSE, sep = "", stringsAsFactors = FALSE) # variable names to use as 
# column names in a later step, using stringsAsFactors=FALSE to prevent info being loaded as Factor

# 1. Merge the training and the test sets to create one data set.

combinedData<-rbind(testFile,trainFile)
combinedSubjects<-rbind(testSubjects,trainSubjects)
combinedActivityLabels<-rbind(testActivityLabels,trainActivityLabels)

# add column names - this item responds to requirement #4 of the rubric: 
# 4. Appropriately label the data set with descriptive variable names. 

colnames(combinedData)<-c(featuresVariables[,2])
names(combinedSubjects)<-"subjectid"
names(combinedActivityLabels)<-"activity"

# add subject and activity columns to the combined data set, turns out this is not needed, but keeps the larger data set in sync 
# with the subset that is created below as meanStd and combinedMeanStd
combinedData<-cbind(combinedSubjects,combinedActivityLabels,combinedData)

# 2. Extract only the measurements on the mean and standard deviation for each measurement.

#load dplyr
library(dplyr)
meanStd<-combinedData[,grepl("mean|std",colnames(combinedData))] 

# add subject and ativity columns to the combined data set
combinedMeanStd<-cbind(combinedSubjects,combinedActivityLabels,meanStd)

# 3. Use descriptive activity names to name the activities in the data set

combinedMeanStd$activity<-gsub("1",activityLabels[1,2],combinedMeanStd$activity)
combinedMeanStd$activity<-gsub("2",activityLabels[2,2],combinedMeanStd$activity)
combinedMeanStd$activity<-gsub("3",activityLabels[3,2],combinedMeanStd$activity)
combinedMeanStd$activity<-gsub("4",activityLabels[4,2],combinedMeanStd$activity)
combinedMeanStd$activity<-gsub("5",activityLabels[5,2],combinedMeanStd$activity)
combinedMeanStd$activity<-gsub("6",activityLabels[6,2],combinedMeanStd$activity)

# 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject.

# Group the data in the combined set by activity per subject
groupedData<-group_by(combinedMeanStd,subjectid,activity)

#create a new tidy data set that shows the mean of each variable for each activity per subject
tidySetofMeans<-summarize_all(groupedData,mean)
write.csv(tidySetofMeans,"tidySetofMeans.csv")
