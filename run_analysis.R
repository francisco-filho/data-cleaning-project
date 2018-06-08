#install.packages(c("tidyr", "dplyr"))
#library(tidyr)
library(dplyr)

if (!file.exists("data")){
    dir.create("data")
    download.file(
        "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
        "data/har.zip"
    )
    unzip("data/har.zip", exdir = "data")
}

# 1. Merges the training and the test sets to create one data set.
features_file       <- "data/UCI HAR Dataset/features.txt"
activity_label_file <- "data/UCI HAR Dataset/activity_labels.txt"
train_fileX         <- "data/UCI HAR Dataset/train/X_train.txt"
train_fileY         <- "data/UCI HAR Dataset/train/y_train.txt"
subject_train_file  <- "data/UCI HAR Dataset/train/subject_train.txt"
test_fileX          <- "data/UCI HAR Dataset/test/X_test.txt"
test_fileY          <- "data/UCI HAR Dataset/test/y_test.txt"
subject_test_file   <- "data/UCI HAR Dataset/test/subject_test.txt"

features        <- read.csv(features_file, header=F, stringsAsFactors = F, sep="")
activities      <- read.csv(activity_label_file, header=F, col.names=c("ActivityCode", "Activity"), sep="")
trainsetX       <- read.csv(train_fileX, header = F, col.names = features[,2], sep="")
trainsetY       <- read.csv(train_fileY, header = F, col.names = c("ActivityCode"), sep="")
trainSubject    <- read.csv(subject_train_file, header = F, col.names=c("Subject"))
trainset        <- bind_cols(trainSubject, trainsetY, trainsetX)
testsetX        <- read.csv(test_fileX, header = F, col.names = features[,2], sep="")
testsetY        <- read.csv(test_fileY, header = F, col.names= c("ActivityCode"), sep="")
testSubject     <- read.csv(subject_test_file, header = F, col.names=c("Subject"))
testset         <- bind_cols(testSubject, testsetY, testsetX)
allset          <- bind_rows(trainset, testset)

# 2. Extracts only the measurements on 
#    the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
allset <- allset %>% 
    left_join(activities) %>% 
    select(Subject, Activity, contains(".mean."), contains(".std."))


# 4. Appropriately labels the data set with descriptive variable names.
n <- names(allset)
n <- gsub("\\.mean", "Mean", n)
n <- gsub("\\.std", "Std", n)
n <- gsub("Acc", "Accelerometer", n)
n <- gsub("Gyro", "Gyroscope", n)
n <- gsub("\\.", "", n)
names(allset) <- n

# This is the final set
allset

# 5. From the data set in step 4, creates a second, 
#    independent tidy data set with the average of each variable 
#    for each activity and each subject.
avgset <- allset %>% 
    group_by(Subject, Activity) %>% 
    summarise_all(funs(mean))

avgset

"abcd" %>% 
    gsub(pattern="a", replacement = "1") %>% 
    gsub(pattern="d", replacement = "9")


#dim(trainset)
#dim(testset)
#trainset[1, ]
#testset[1, ]
# quantidade de features = quantidade de campos
#length(features[,1])
#length(trainset[1,])