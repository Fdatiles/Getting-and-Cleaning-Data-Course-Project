library(dplyr)
library(stringi)

# Read 'raw' data
features  <- read.table("UCI HAR Dataset/features.txt")
act_lbls  <- read.table("UCI HAR Dataset/activity_labels.txt", stringsAsFactors = TRUE)
sub_test  <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = c('Subject'))
X_test    <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features[,2])
y_test    <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = c('Activity'))
sub_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = c('Subject'))
X_train   <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features[,2])
y_train   <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = c('Activity'))

# Merge into a single dataframe
MergedDF <- data.frame(rbind(sub_train, sub_test), rbind(y_train, y_test), rbind(X_train, X_test))

# Select columns with 'mean' or 'std'
TidyDF <- select(MergedDF, Subject, Activity, contains("mean"), contains('std'))

# Turn the activities into factors with meaningful labels
TidyDF[,2]  <- act_lbls[TidyDF[,2], 2]

# Rework variable names
names(TidyDF) <- stri_replace_all_regex(
    names(TidyDF),
    pattern = c("(^t|\\.t)", "^f", "Acc", "Gyro", "BodyBody", "Mag",
                "Body", "mean", "std", "Freq\\(\\)", "angle", "(G|g)ravity", "[.]{2,}"),
    replacement = c("Time.", "Freq.", "Acceleration.", "Gyro.", "Body", ".Magnitude",
                    "Body.", "Mean.", "STD", "Frequency", "Angle.", "Gravity.", "."),
    vectorize_all = FALSE)

# Create final dataframe with averages by group
SummarisedTidyDF = TidyDF %>% group_by(Activity, Subject) %>% summarise_all(mean)
write.table(SummarisedTidyDF, file = 'SummarisedTidyData.txt', row.names = FALSE)