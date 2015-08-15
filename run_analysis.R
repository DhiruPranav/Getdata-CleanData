###############################################################
# Files submit:
# 1.This R script file entitled "run_analysis.R".
# 2.README.md.
# 3.CodeBook.md. Contains an explanation of the variables used.
# 4.Tidy Data Set "TidyDataSet.txt".
#
###############################################################
# Instructions to follow to run the script file
# 1. This R script file (Run_analysis.R) should be placed in the data folder and Data folder "UCI HAR Dataset" should be placed in the working directory. All paths are relative to working directory.
# 2. All the data source file names and file locations are as provided by the instructor.
# 3. My GitHub location: https://github.com/DhiruPranav/Getdata-CleanData
#
###############################################################
## Keep the current working directory
curwd=getwd()
##Change the working directory to the data folder where we save the script file and data.
setwd("UCI HAR Dataset")
### (1) Loading the supporting files.
# Load activity_labels.txt: Links the ActivityCode (Values: 1-6) with the ActivityName
DataFrame_actlab <- read.table(file = "activity_labels.txt", sep = " ", col.names = c("ActCode", "ActName"))

# Load features.txt: Provides the column names for the X dataset. Noted 561 features present.
DataFrame_features <- read.table(file = "features.txt", sep = " ", col.names = c("FeatureCode", "FeatureName"))


### Merge the training and the test sets to create one data set.
# Read in the training dataset.
DataFrame_subject_train <- read.table(file = "train/subject_train.txt", sep = " ", col.names = "SubjectNo")
DataFrame_y_train <- read.table(file = "train/y_train.txt", sep = " ", col.names = "ActCode")
DataFrame_X_train <- read.table(file = "train/X_train.txt", sep = "") 


# Read in the test dataset.
DataFrame_subject_test <- read.table(file = "test/subject_test.txt", sep = " ", col.names = "SubjectNo")
DataFrame_y_test <- read.table(file = "test/y_test.txt", sep = " ", col.names = "ActCode")
DataFrame_X_test <- read.table(file = "test/X_test.txt", sep = "")

# Merge the train and test subject datasets in to merge subject data set,merge Y Data set and Merge X data set.
DataFrame_subject_merge <- rbind(DataFrame_subject_train, DataFrame_subject_test)  
# make sure train dataset should come first.
DataFrame_y_merge <- rbind(DataFrame_y_train, DataFrame_y_test)  
DataFrame_X_merge <- rbind(DataFrame_X_train, DataFrame_X_test)

# Remove the original data sets from memory to improve response times
rm(DataFrame_subject_train)
rm(DataFrame_y_train)
rm(DataFrame_X_train)
rm(DataFrame_subject_test)
rm(DataFrame_y_test)
rm(DataFrame_X_test)




### Extract the measurements on the mean and standard deviation for each measurement as per the assignment instructions.
# Look for the column names of mean and standard deviation using "features_info.txt"
DataFrame_X_small <- DataFrame_X_merge[ , grep("Mean|mean|std()", DataFrame_features$FeatureName)]
# Adding Subject, Activity Labels, and Measurements, to get the compound data set with all the required columns in one data set
DataFrame_X_Final <- cbind(DataFrame_subject_merge, DataFrame_y_merge, DataFrame_X_small)


### Use descriptive activity names to name the activities in the data set.
# Merge DataFrame_actlab and DataFrame_y_merge. This matches the ActivityNames to the ActivityCodes in DataFrame_y_merge.
DataFrame_X_Final <- merge(x = DataFrame_actlab, y = DataFrame_X_Final, by.X = "ActCode", by.Y = "ActCode")
DataFrame_X_Final$ActCode <- NULL  # Delete the ActCode column. Not needed as we have ActName already.

# Tidying up DataFrame_X_Final.
# Move the SubjectNo to first column by reorder columns.
DataFrame_X_Final <- DataFrame_X_Final[ , c(2, 1, 3:88)]  
# Sort by SubjectNo and ActName, for more orderliness.
DataFrame_X_Final <- DataFrame_X_Final[order(DataFrame_X_Final$SubjectNo, DataFrame_X_Final$ActName), ]


### Modify the columns names to descptive names
# Add all the FeatureNames as the column name
colnames(DataFrame_X_Final)[3:88] <- as.character(DataFrame_features[grep("Mean|mean|std()", DataFrame_features$FeatureName), "FeatureName"])  


### As per the instructions we are creating a second, independent tidy data set with the average of each variable, for each activity, and each subject.
DataFrame_X_Final_out <- aggregate(DataFrame_X_Final[ ,3:88], list(SubjectNo=DataFrame_X_Final$SubjectNo, ActName=DataFrame_X_Final$ActName), mean)  # See how to use aggregate() here: http://davetang.org/muse/2013/05/22/using-aggregate-and-apply-in-r/
# Sort again by SubjectNo and ActName, for more orderliness in the output file.
DataFrame_X_Final_out <- DataFrame_X_Final_out[order(DataFrame_X_Final_out$SubjectNo, DataFrame_X_Final_out$ActName), ]
# Output the tidy data set.
write.table(DataFrame_X_Final_out, file="TidyDataSet.txt", sep=" ", row.names=F)

#Reset the R working directory back to old working directory

# Load the output data file in to R to validate the output
OutputDataFrame <- read.table(file="TidyDataSet.txt", sep=" ", header = T)
setwd(curwd)
OutputDataFrame

