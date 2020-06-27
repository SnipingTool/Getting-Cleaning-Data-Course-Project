library(dplyr)

# Reading feature labels and extracting indices of mean and std:
features <- read.table("UCI HAR Dataset\\features.txt")
indexMeanStd <- grep("mean|std", features$V2)

# Reading activity labels:
activities <- read.table("UCI HAR Dataset\\activity_labels.txt")

# Merging test data:
subjectTest <- read.table("UCI HAR Dataset\\test\\subject_test.txt")
activityTest <- read.table("UCI HAR Dataset\\test\\y_test.txt")
measurementsTest <- read.table("UCI HAR Dataset\\test\\X_test.txt")
meanstdTest <- select(measurementsTest, all_of(indexMeanStd)) #Extracting only mean and std values
test <- cbind(subjectTest, activityTest, meanstdTest)

# Merging train data:
subjectTrain <- read.table("UCI HAR Dataset\\train\\subject_train.txt")
activityTrain <- read.table("UCI HAR Dataset\\train\\y_train.txt")
measurementsTrain <- read.table("UCI HAR Dataset\\train\\X_train.txt")
meanstdTrain <- select(measurementsTrain, all_of(indexMeanStd)) #Extracting only mean and std values
train <- cbind(subjectTrain, activityTrain, meanstdTrain)

# Merging test & train:
mergedData <- rbind(train, test)

# Adding header to mergedData:
featurenames <- features[indexMeanStd, 2]
header <- c("SubjectID", "Activity", featurenames) #Descriptive variable names
colnames(mergedData) <- header

# Substituting the variable names with meaningful ones
names(mergedData) <- gsub("Acc", "Accelerometer", names(mergedData))
names(mergedData) <- gsub("Gyro", "Gyroscope", names(mergedData))
names(mergedData) <- gsub("BodyBody", "Body", names(mergedData))
names(mergedData) <- gsub("Mag", "Magnitude", names(mergedData))
names(mergedData) <- gsub("^t", "Time", names(mergedData))
names(mergedData) <- gsub("^f", "Frequency", names(mergedData))
names(mergedData) <- gsub("tBody", "TimeBody", names(mergedData))
names(mergedData) <- gsub("-mean()", "Mean", names(mergedData), ignore.case = TRUE)
names(mergedData) <- gsub("-std()", "STD", names(mergedData), ignore.case = TRUE)
names(mergedData) <- gsub("-freq()", "Frequency", names(mergedData), ignore.case = TRUE)
names(mergedData) <- gsub("gravity", "Gravity", names(mergedData))

# Sorting mergedData by subject name:
mergedData <- arrange(mergedData, mergedData$SubjectID, mergedData$Activity)

# Replacing activity number by respective descriptive name in mergedData:
mergedData$Activity <- activities[mergedData$Activity, 2]

# Creating tidy dataset by grouping mergedData by its subject ID and activity and then calculating mean:
tidydataset <- mergedData %>% group_by(SubjectID, Activity) %>% summarise_all(mean)
write.table(tidydataset, "tidydataset.txt", row.name=FALSE)