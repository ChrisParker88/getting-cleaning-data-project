##Codebook.md

###Description

Information on the data set obtained, as well as on the variables i nthe Course Project for the Getting and Cleaning Data Course offered by the Johns Hopkins University through Coursera.

###Source of data

[The data is obtained from the UCI Machine Learning Repository.](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

[The data for this project can be found here.](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

###Data set information

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details.

###Atttibutes for each record

*Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
*Triaxial Angular velocity from the gyroscope. 
*A 561-feature vector with time and frequency domain variables. 
*Its activity label.
*An identifier of the subject who carried out the experiment.

###Steps followed by the run_analysis.R code to meet project requirements

####Preparation work

*Set working directory
*Download zipped file if it does not exist
*Unzip file and create folders if they do not exist
*Read .txt file and convert to data.frame using 'gettable' function
*Create features dataframe with descriptive column names
*Read data and build individual dataframes
*Create test & train dataframes
*A function for saving resulting data files


####Task 1: Merge training and testing data sets into one

Following files are read into data tables:

*features.txt
*activity_labels.txt
*subject_train.txt
*x_train.txt
*y_train.txt
*subject_test.txt
*x_test.txt
*y_test.txt

Train and test data combined.

####Task 2: Extract only the measurements on the mean and stdev for each measurement

Subset binded train and tests data with columns that list standard deviation and mean values for every observation.

####Task 3: Use descriptive activity names to name the activities in the data set

Use 'gettable' function to get a data set of activity labels from "activity_labels.txt" file.

####Task 4: Appropriately label the data set with descriptive variable names

Create factor from activity_labels data table created in Task 3 and replace the activity column in the main data table with these labels.

####Task 5: Create a second, independent tidy data set with the average of each variable for each activity and each subject

Create a tidy data set with only the average of each variable for each subject ID and activity.