# Getting and Cleaning Data Course Project

The data is about a Human Activity Recognition database with activities of 30 subjects obtained in the UCI Machine Learning Repository.

The data is composed of the following files:
- features.txt - Labels of all features - 561 variables described in the `features_info.txt` copied in the end of this file
- activity_labels - Labels of the 6 types of activities
- X_train.txt - Files with all measuring data for training, contains 561 variables described in the `features_info.txt`
- Y_train.txt - Contains the labels of the X_training data
- X_test.txt - Files with all measuring data for testing porposes
- Y_test.txt - Files with the labels of the X_test data
- subject_train, subject_test - anonymous id for test subjects

## Analysis

The analysis was conducted using base R and the library `dplyr` from the tidyverse.

We start creating the `data` directory and download the required file from the UCI Machine Learning Repository and then unziping it, then the following steps are performed.

- Read all the files need to the analysis to variables with `read.csv`, the `features.txt` file was the first file read because it was used as labels for the train and test files.
- After all files are loaded the `X_` files was joined with the `Y_`files with the function `bind_cols(trainSubject, trainSetY, trainsetX)`, the same was done to the test sets.
- With all columns binded the next step was append the test rows to the train rows with the function `bind_rows(trainset, testset)`
- All variables removed keeping only the varibales for them mean() and standard deviation and all variables received more descriptive names with the help of the `gsub()` function
- The first dataset was ready in the variable `allset`
- Next was create a set grouped by subject and activity averaging all values with the help of the excellent `dplyr` package and the result was put in the  `avgset` variable

Feature Selection (From the feature_info.txt file in the UCI dataset)
=================

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

The complete list of variables of each feature vector is available in 'features.txt'

