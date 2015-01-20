# Getting and Cleaning Data - Course Project (Jan 2015) by Dirk Mischke

# 1. Merge the training and the test sets to create one data set

# Starting with the "test" files
features <- read.table("~/Documents/Coursera/Data Science/Getting and Cleaning Data/UCI HAR Dataset/features.txt", header = FALSE, sep = "")
subjects_test <- read.table("~/Documents/Coursera/Data Science/Getting and Cleaning Data/UCI HAR Dataset/test/subject_test.txt", header = FALSE, sep = "")
X_test <- read.table("~/Documents/Coursera/Data Science/Getting and Cleaning Data/UCI HAR Dataset/test/X_test.txt", header = FALSE, sep = "")
Y_test <- read.table("~/Documents/Coursera/Data Science/Getting and Cleaning Data/UCI HAR Dataset/test/Y_test.txt", header = FALSE, sep = "")

# Get Column names from features and integrate them with X_test
features1 <- select(features, V2)
features2 <- unlist(features1, recursive = TRUE, use.names = FALSE)
df <- as.character(features2)
X_test_f <- rbind(df, X_test)
write.table(X_test_f, file = "X_test_f.txt", sep = "", row.names = FALSE) # This
    # creates a text file, where the first row consists of the default column 
    # names (V1, V2,...), so I had to delete the first row in order to get the 
    # headers right when reading in the data again. (the same happens with the 
    # "train" file)
X_test <- read.table("~/Documents/Coursera/Data Science/Getting and Cleaning Data/UCI HAR Dataset/test/X_test_f.txt", header = TRUE, sep = "")

# Give all three data.frames a common variable for later merging

subjects_test$num <- c(1:2947)
X_test$num <- c(1:2947)
Y_test$num <- c(1:2947)
test_com <- merge(subjects_test, X_test, by = "num")
test_com <- rename(test_com, Subjects = V1)
test_com <- merge(Y_test, test_com, by = "num")
test_com <- rename(test_com, Activity = V1)
# 2. Extract only the measurements on the mean and standard deviation for each measurement
test_complete <- select(test_com, Subjects, Activity, matches(".mean", ignore.case = FALSE), matches(".std"))

# Now the same for the "train" files
subjects_train <- read.table("~/Documents/Coursera/Data Science/Getting and Cleaning Data/UCI HAR Dataset/train/subject_train.txt", header = FALSE, sep = "")
X_train <- read.table("~/Documents/Coursera/Data Science/Getting and Cleaning Data/UCI HAR Dataset/train/X_train.txt", header = FALSE, sep = "")
Y_train <- read.table("~/Documents/Coursera/Data Science/Getting and Cleaning Data/UCI HAR Dataset/train/Y_train.txt", header = FALSE, sep = "")

# Intergrate column names in X_train
X_train_f <- rbind(df, X_train)
write.table(X_train_f, file = "X_train_f.txt", sep = "", row.names = FALSE)
X_train <- read.table("~/Documents/Coursera/Data Science/Getting and Cleaning Data/UCI HAR Dataset/train/X_train_f.txt", header = TRUE, sep = "")

# Create common variable for later merging
subjects_train$num <- c(1:7352)
X_train$num <- c(1:7352)
Y_train$num <- c(1:7352)
train_com <- merge(subjects_train, X_train, by = "num")
train_com <- rename(train_com, Subjects = V1)
train_com <- merge(Y_train, train_com, by = "num")
train_com <- rename(train_com, Activity = V1)
# 2. Extract only the measurements on the mean and standard deviation for each measurement
train_complete <- select(train_com, Subjects, Activity, matches(".mean", ignore.case = FALSE), matches(".std"))

# The final merging of "train" and "test" data sets

HAR_dataset <- rbind(train_complete, test_complete)

# 3. Use descriptive activity names to name the activities in the data set

HAR_dataset$Activity[HAR_dataset$Activity == "1"] <- "Walking"
HAR_dataset$Activity[HAR_dataset$Activity == "2"] <- "Walking_Upstairs"
HAR_dataset$Activity[HAR_dataset$Activity == "3"] <- "Walking_Downstairs"
HAR_dataset$Activity[HAR_dataset$Activity == "4"] <- "Sitting"
HAR_dataset$Activity[HAR_dataset$Activity == "5"] <- "Standing"
HAR_dataset$Activity[HAR_dataset$Activity == "6"] <- "Laying"

# 4. Appropriately label the data set with descriptive variable names.

# tBodyAcc-XYZ = 3-axial_Body_Acceleration_in_time_domain
# tGravityAcc-XYZ = 3-axial_Gravity_Acceleration_in_time_domain
# tBodyAccJerk-XYZ = 3-axial_Body_Acceleration_Jerk_in_time_domain
# tBodyGyro-XYZ = 3-axial_Body_Gyration_in_time_domain
# tBodyGyroJerk-XYZ = 3-axial_Body_Gyration_Jerk_in_time_domain
# tBodyAccMag = Body_Acceleration_Magnitude_in_time_domain
# tGravityAccMag = Gravity_Acceleration_Magnitude_in_time_domain
# tBodyAccJerkMag = Body_Acceleration_Jerk_Magnitude_in_time_domain
# tBodyGyroMag = Body_Gyration_Magnitude_in_time_domain
# tBodyGyroJerkMag = Body_Gyration_Jerk_Magnitude_in_time_domain
# fBodyAcc-XYZ = 3-axial_Body_Acceleration_in_frequency_domain
# fBodyAccJerk-XYZ = 3-axial_Body_Acceleration_Jerk_in_frequency_domain
# fBodyGyro-XYZ = 3-axial_Body_Gyration_in_frequency_domain
# fBodyAccMag = Body_Acceleration_Magnitude_in_frequency_domain
# fBodyAccJerkMag = Body_Acceleration_Jerk_Magnitude_in_frequency_domain
# fBodyGyroMag = Body_Gyration_Magnitude_in_frequency_domain
# fBodyGyroJerkMag = Body_Gyration_Jerk_Magnitude_in_frequency_domain

HAR_dataset <- rename(HAR_dataset, X_axial_Body_Acceleration_in_time_domain_mean = tBodyAcc.mean...X)
HAR_dataset <- rename(HAR_dataset, Y_axial_Body_Acceleration_in_time_domain_mean = tBodyAcc.mean...Y)
HAR_dataset <- rename(HAR_dataset, Z_axial_Body_Acceleration_in_time_domain_mean = tBodyAcc.mean...Z)
HAR_dataset <- rename(HAR_dataset, X_axial_Gravity_Acceleration_in_time_domain_mean = tGravityAcc.mean...X)
HAR_dataset <- rename(HAR_dataset, Y_axial_Gravity_Acceleration_in_time_domain_mean = tGravityAcc.mean...Y)
HAR_dataset <- rename(HAR_dataset, Z_axial_Gravity_Acceleration_in_time_domain_mean = tGravityAcc.mean...Z)
HAR_dataset <- rename(HAR_dataset, X_axial_Body_Acceleration_Jerk_in_time_domain_mean = tBodyAccJerk.mean...X)
HAR_dataset <- rename(HAR_dataset, Y_axial_Body_Acceleration_Jerk_in_time_domain_mean = tBodyAccJerk.mean...Y)
HAR_dataset <- rename(HAR_dataset, Z_axial_Body_Acceleration_Jerk_in_time_domain_mean = tBodyAccJerk.mean...Z)
HAR_dataset <- rename(HAR_dataset, X_axial_Body_Gyration_in_time_domain_mean = tBodyGyro.mean...X)
HAR_dataset <- rename(HAR_dataset, Y_axial_Body_Gyration_in_time_domain_mean = tBodyGyro.mean...Y)
HAR_dataset <- rename(HAR_dataset, Z_axial_Body_Gyration_in_time_domain_mean = tBodyGyro.mean...Z)
HAR_dataset <- rename(HAR_dataset, X_axial_Body_Gyration_Jerk_in_time_domain_mean = tBodyGyroJerk.mean...X)
HAR_dataset <- rename(HAR_dataset, Y_axial_Body_Gyration_Jerk_in_time_domain_mean = tBodyGyroJerk.mean...Y)
HAR_dataset <- rename(HAR_dataset, Z_axial_Body_Gyration_Jerk_in_time_domain_mean = tBodyGyroJerk.mean...Z)
HAR_dataset <- rename(HAR_dataset, Body_Acceleration_Magnitude_in_time_domain_mean = tBodyAccMag.mean..)
HAR_dataset <- rename(HAR_dataset, Gravity_Acceleration_Magnitude_in_time_domain_mean = tGravityAccMag.mean..)
HAR_dataset <- rename(HAR_dataset, Body_Acceleration_Jerk_Magnitude_in_time_domain_mean = tBodyAccJerkMag.mean..)
HAR_dataset <- rename(HAR_dataset, Body_Gyration_Magnitude_in_time_domain_mean = tBodyGyroMag.mean..)
HAR_dataset <- rename(HAR_dataset, Body_Gyration_Jerk_Magnitude_in_time_domain_mean = tBodyGyroJerkMag.mean..)
HAR_dataset <- rename(HAR_dataset, X_axial_Body_Acceleration_in_frequency_domain_mean = fBodyAcc.mean...X)
HAR_dataset <- rename(HAR_dataset, Y_axial_Body_Acceleration_in_frequency_domain_mean = fBodyAcc.mean...Y)
HAR_dataset <- rename(HAR_dataset, Z_axial_Body_Acceleration_in_frequency_domain_mean = fBodyAcc.mean...Z)
HAR_dataset <- rename(HAR_dataset, X_axial_Body_Acceleration_Jerk_in_frequency_domain_mean = fBodyAccJerk.mean...X)
HAR_dataset <- rename(HAR_dataset, Y_axial_Body_Acceleration_Jerk_in_frequency_domain_mean = fBodyAccJerk.mean...Y)
HAR_dataset <- rename(HAR_dataset, Z_axial_Body_Acceleration_Jerk_in_frequency_domain_mean = fBodyAccJerk.mean...Z)
HAR_dataset <- rename(HAR_dataset, X_axial_Body_Gyration_in_frequency_domain_mean = fBodyGyro.mean...X)
HAR_dataset <- rename(HAR_dataset, Y_axial_Body_Gyration_in_frequency_domain_mean = fBodyGyro.mean...Y)
HAR_dataset <- rename(HAR_dataset, Z_axial_Body_Gyration_in_frequency_domain_mean = fBodyGyro.mean...Z)
HAR_dataset <- rename(HAR_dataset, Body_Acceleration_Magnitude_in_frequency_domain_mean = fBodyAccMag.mean..)
HAR_dataset <- rename(HAR_dataset, Body_Acceleration_Jerk_Magnitude_in_frequency_domain_mean = fBodyBodyAccJerkMag.mean..)
HAR_dataset <- rename(HAR_dataset, Body_Gyration_Magnitude_in_frequency_domain_mean = fBodyBodyGyroMag.mean..)
HAR_dataset <- rename(HAR_dataset, Body_Gyration_Jerk_Magnitude_in_frequency_domain_mean = fBodyBodyGyroJerkMag.mean..)
HAR_dataset <- rename(HAR_dataset, X_axial_Body_Acceleration_in_time_domain_std = tBodyAcc.std...X)
HAR_dataset <- rename(HAR_dataset, Y_axial_Body_Acceleration_in_time_domain_std = tBodyAcc.std...Y)
HAR_dataset <- rename(HAR_dataset, Z_axial_Body_Acceleration_in_time_domain_std = tBodyAcc.std...Z)
HAR_dataset <- rename(HAR_dataset, X_axial_Gravity_Acceleration_in_time_domain_std = tGravityAcc.std...X)
HAR_dataset <- rename(HAR_dataset, Y_axial_Gravity_Acceleration_in_time_domain_std = tGravityAcc.std...Y)
HAR_dataset <- rename(HAR_dataset, Z_axial_Gravity_Acceleration_in_time_domain_std = tGravityAcc.std...Z)
HAR_dataset <- rename(HAR_dataset, X_axial_Body_Acceleration_Jerk_in_time_domain_std = tBodyAccJerk.std...X)
HAR_dataset <- rename(HAR_dataset, Y_axial_Body_Acceleration_Jerk_in_time_domain_std = tBodyAccJerk.std...Y)
HAR_dataset <- rename(HAR_dataset, Z_axial_Body_Acceleration_Jerk_in_time_domain_std = tBodyAccJerk.std...Z)
HAR_dataset <- rename(HAR_dataset, X_axial_Body_Gyration_in_time_domain_std = tBodyGyro.std...X)
HAR_dataset <- rename(HAR_dataset, Y_axial_Body_Gyration_in_time_domain_std = tBodyGyro.std...Y)
HAR_dataset <- rename(HAR_dataset, Z_axial_Body_Gyration_in_time_domain_std = tBodyGyro.std...Z)
HAR_dataset <- rename(HAR_dataset, X_axial_Body_Gyration_Jerk_in_time_domain_std = tBodyGyroJerk.std...X)
HAR_dataset <- rename(HAR_dataset, Y_axial_Body_Gyration_Jerk_in_time_domain_std = tBodyGyroJerk.std...Y)
HAR_dataset <- rename(HAR_dataset, Z_axial_Body_Gyration_Jerk_in_time_domain_std = tBodyGyroJerk.std...Z)
HAR_dataset <- rename(HAR_dataset, Body_Acceleration_Magnitude_in_time_domain_std = tBodyAccMag.std..)
HAR_dataset <- rename(HAR_dataset, Gravity_Acceleration_Magnitude_in_time_domain_std = tGravityAccMag.std..)
HAR_dataset <- rename(HAR_dataset, Body_Acceleration_Jerk_Magnitude_in_time_domain_std = tBodyAccJerkMag.std..)
HAR_dataset <- rename(HAR_dataset, Body_Gyration_Magnitude_in_time_domain_std = tBodyGyroMag.std..)
HAR_dataset <- rename(HAR_dataset, Body_Gyration_Jerk_Magnitude_in_time_domain_std = tBodyGyroJerkMag.std..)
HAR_dataset <- rename(HAR_dataset, X_axial_Body_Acceleration_in_frequency_domain_std = fBodyAcc.std...X)
HAR_dataset <- rename(HAR_dataset, Y_axial_Body_Acceleration_in_frequency_domain_std = fBodyAcc.std...Y)
HAR_dataset <- rename(HAR_dataset, Z_axial_Body_Acceleration_in_frequency_domain_std = fBodyAcc.std...Z)
HAR_dataset <- rename(HAR_dataset, X_axial_Body_Acceleration_Jerk_in_frequency_domain_std = fBodyAccJerk.std...X)
HAR_dataset <- rename(HAR_dataset, Y_axial_Body_Acceleration_Jerk_in_frequency_domain_std = fBodyAccJerk.std...Y)
HAR_dataset <- rename(HAR_dataset, Z_axial_Body_Acceleration_Jerk_in_frequency_domain_std = fBodyAccJerk.std...Z)
HAR_dataset <- rename(HAR_dataset, X_axial_Body_Gyration_in_frequency_domain_std = fBodyGyro.std...X)
HAR_dataset <- rename(HAR_dataset, Y_axial_Body_Gyration_in_frequency_domain_std = fBodyGyro.std...Y)
HAR_dataset <- rename(HAR_dataset, Z_axial_Body_Gyration_in_frequency_domain_std = fBodyGyro.std...Z)
HAR_dataset <- rename(HAR_dataset, Body_Acceleration_Magnitude_in_frequency_domain_std = fBodyAccMag.std..)
HAR_dataset <- rename(HAR_dataset, Body_Acceleration_Jerk_Magnitude_in_frequency_domain_std = fBodyBodyAccJerkMag.std..)
HAR_dataset <- rename(HAR_dataset, Body_Gyration_Magnitude_in_frequency_domain_std = fBodyBodyGyroMag.std..)
HAR_dataset <- rename(HAR_dataset, Body_Gyration_Jerk_Magnitude_in_frequency_domain_std = fBodyBodyGyroJerkMag.std..)

# And finally to bring the dataset into a text file

write.table(HAR_dataset, file = "HAR_dataset.txt", sep = "", row.names = FALSE)