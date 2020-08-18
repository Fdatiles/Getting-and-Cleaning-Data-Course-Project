# Codebook

## The procedure

The script in `run_analysis.R` execute the following steps:

1.  Open the files `features.txt`, `Dataset/activity_labels.txt`
    `test/subject_test.txt`, `test/X_test.txt`, `test/y_test.txt`,
    `train/subject_train.txt`, `train/X_train.txt` and `train/y_train.txt`,
    using `read.table()`. The variable names are supplied by the first file.
2.  Merge test and train data into a single `data.frame`, named `MergedDF`,
    with 10299 rows and 563 columns.
    Its first two columns, named `Subject` and `Activity`, represent the
    subject id and the activity id, respectively, followed by the measured
    variables.
3.  Extract the variables involving the mean (which include `mean` in its name)
    or the standard deviation (which include `std`), obtaining `TidyDF`, with
    10299 rows and 88 columns.
4.  Turn the Activities column into a factor using the labels included at
    `Dataset/activity_labels.txt`, that is, `'WALKING', 'WALKING_UPSTAIRS', 'WALKING_DOWNSTAIRS', 'SITTING', 'STANDING', 'LAYING'`
5.  Rename the variables as compound names according to the following convention:
    * `Time`: in the time domain.
    * `Freq`: in the frequency domain.
    * `Body`: measuring the body.
    * `Gravity`: measuring gravity.
    * `Angle`: angle between vectors.
    * `Magnitude`: magnitude of the respective vector. 
    * `Acceleration`/`Jerk`/`Gyro`/`Gyro.Jerk`: the quantity being measured.
    * `X`/`Y`/`Z`: direction of the component being measured.
    * `Mean`/`STD`: the statistical parameter.
6.  Generate `SummarisedTidyDF` by grouping the data by activity and subject
    and calculating the average of each variable for each group, reducing the 
    dimensions to 180 rows and 88 columns.

## Final Data Structure

The resulting dataset `SummarisedTidyDF` is the one required in the assignment.
The units are not clearly stated in the original dataset since all quantities
were normalized, ranging between -1 and 1.