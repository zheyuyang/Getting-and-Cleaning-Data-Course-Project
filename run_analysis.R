## Download data and unzip. 

## 1. Merges the training and the test sets to create one data set.
## Test sets. 
## 2947*1 
subject_test <- read.table("C:/Users/Zoe/Desktop/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt")
## 2947*561 
x_test <- read.table("C:/Users/Zoe/Desktop/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")
## 2947*1
y_test <- read.table("C:/Users/Zoe/Desktop/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/Y_test.txt")

## Training sets. 
## 7352*1
subject_train <- read.table("C:/Users/Zoe/Desktop/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt")
## 7352*561
x_train <- read.table("C:/Users/Zoe/Desktop/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt")
## 7352*1
y_train <- read.table("C:/Users/Zoe/Desktop/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/Y_train.txt")

## Piece together all datasets.
## 10299*561
x <- rbind(x_train, x_test)
## 10299*1
y <- rbind(y_train, y_test)
## 10299*1
subject <- rbind(subject_train, subject_test)
## 10299*563
data <- cbind(subject, y, x)
head(data)
tail(data)


## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 561 features for test and train datasets. 
features <- read.table("C:/Users/Zoe/Desktop/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/features.txt")
## Feature names are in column 2. 
feature_name <- features[,2]
class(feature_name)
feature_name <- as.character(feature_name)
colnames(data)
## Replace column names in the merged dataset. 
colnames(data) <- c("subject", "activity", feature_name)
colnames(data)

## Keep only columns that named with mean() and std().
## Function grep(value = FALSE) returns a vector of the indices of the elements of x that yielded a match.
## 46.
mean_col <- grep("mean()", colnames(data))
## 33.
std_col <- grep("std()", colnames(data))
## 79.
keep_col <- sort(c(mean_col, std_col))
## 10299*81
keep_data <- data[, c(1,2,keep_col)]
colnames(keep_data)
## Eliminate column named with meanFreq().
## Function grepl returns T/F for each element. 
remove_col <- grepl("Freq", colnames(keep_data))
keep_data <- keep_data[ ,!remove_col]
## 10299*68
colnames(keep_data)


## 3. Uses descriptive activity names to name the activities in the data set.
## 6 activity labels(WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING).
activities <- read.table("C:/Users/Zoe/Desktop/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt")
head(activities)
## Create activities labels. 
activities_labels <- levels(activities$V2)
activities_labels[1] <- "WALKING"
activities_labels[2] <- "WALKING_UPSTAIRS"
activities_labels[3] <- "WALKING_DOWNSTAIRS"
activities_labels[4] <- "SITTING"
activities_labels[5] <- "STANDING"
activities_labels[6] <- "LAYING"
## Replace number with activity name in the dataset. 
keep_data$activity <- factor(keep_data$activity, labels = activities_labels)


## 4. Appropriately labels the data set with descriptive variable names. 
colnames(keep_data)
names(keep_data) <- gsub("^t", "time", names(keep_data))
names(keep_data) <- gsub("^f", "frequency", names(keep_data))
names(keep_data) <- gsub("BodyBody", "Body", names(keep_data))
names(keep_data) <- gsub("-mean", "Mean", names(keep_data))
names(keep_data) <- gsub("-std", "StdDev", names(keep_data))
names(keep_data) <- gsub("Acc", "Accelerometer", names(keep_data))
names(keep_data) <- gsub("Gyro", "Gyroscope", names(keep_data))
names(keep_data) <- gsub("Mag", "Magnitude", names(keep_data))


## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
library(plyr)
tidy_data <- aggregate(.~subject + activity, keep_data, mean)
tidy_data <- tidy_data[order(tidy_data$subject, tidy_data$activity), ]
write.table(tidy_data, file = "C:/Users/Zoe/Desktop/tidydata.txt", row.name = FALSE)



