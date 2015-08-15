
## Course Project for Coursera "Getting and Cleaning Data" (Course Code: getdata-031)

### Assumptions
1. Script file and data should be placed in the R working directory

2. Submission Location : https://github.com/DhiruPranav/Getdata-CleanData

4. Names of the files submitting as per the naming instructions of the course are
 1. run_analysis.R script file to perform the cleaning and prepare tidy data set
 2. README.md.
 3. CodeBook.md. 
 4. TidyDataSet.txt  this is the output of the script file.


### Logic used to do the cleaning.

followed the instructions given by coursera assignment page as much as possible
The script follwed the following steps

#### Step 1: Load all the supporting files in to memory.
Here I loaded the supporting files activity_labels.txt, features.txt etc.. into data frames, are done. 
I refer these frames in the following steps
	
#### Step 2: Merge the training and the test sets to get a single data set and perform the remaining steps in on a single data set instead of 2 seperately.
- Loading the train data first and test second.
Train data should come first when we do the merging.
We got the following 3 data sets for further processing.

 - **df_subject_merge** for the Subjects
 - **df_y_merge** for the ActivityCode
 - **df_X_merge** for the measurements of the variables.


#### Step 3: Extract only the mean and standard deviation for each measurement
-Using the names provided in the features file, find the measurement names for mean and standard deviation and use the grep command to get those measures.
- df_X_merge_small contains the dataset with the required measurements
- df_X_merge_final is then produced using cbind(). This is the final dataset, which includes the SubjectNo, ActivityCode, ActivityName, and the samller data set

#### Step 4: Use descriptive activity names to name the activities in the data set as per the instructions
- df_X_merge_final is merged with the activity labels. 
since we added the activity name, we do not need the code any more and delete the column from data set.

#### Step 5: Appropriately label the data set with descriptive variable names
- The columns of df_X_merge_final are given more appropriate names, which are taken from the *features.txt* file.
-Adding custom names instead of the names from original data set


#### Step 6: Create a second, independent tidy data set with the average of each variable, for each activity, and each subject
- The value in each cell is now the mean of each variable, per activity per subject.


### Description of the Output
- The output from run_analysis.R is a tidy data set, in an output file named "**TidyDataSet.txt**". 
- The output file is *space-delimited*.
- The output file contains a total of 181 lines (1 header + 30 Subjects x 6 Activities each)


## Resources
- Markdown Cheatsheet, [https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet)
- [http://markdown-here.com/livedemo.html](http://markdown-here.com/livedemo.html) 
