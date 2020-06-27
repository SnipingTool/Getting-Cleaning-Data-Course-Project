# Getting & Cleaning Data Course Project

This readme file contains description of the files in this repository.

## Dataset
[HAR Using Smartphones](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

## CodeBook
It includes the details of all the variables including their name, purpose and any transformations that were applied on them to obtain a tidy dataset.

## run_analysis.R
The steps applied on the original dataset are as follows:
+ The feature names file was read and stored
+ The files for subject numbers, activity_labels and measurements were read and stored
+ The indices of the features that were mean or standard deviation were extracted from the feature names list
+ A subset of the measurements dataset was made based on the indices calculated. This was done for both train and test measurement data
+ The subject, activity and measurements (mean & std only) were merged to form a single dataset for each training and testing
+ The training and testing datasets were then merged
+ A header was assigned to the merged data and the column names were changed to be more meaningful
+ The activity numbers were replaced by their respective descriptive name e.g. walking, sitting etc.
+ An independent tidy dataset was created from the merged dataset by grouping the merged dataset according to the subject and activity and then 
  finding the mean of each measurement for each group
