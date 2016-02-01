This is what run_analysis.R work.
===========
If you want to run this script, make sure you have "UCI HAR Dataset" folder in your working directory.
The run_analysis.R work as follow.

  1. Script will read 8 following files into working space
    * "./UCI HAR Dataset/activity_labels.txt"
    * "./UCI HAR Dataset/features.txt"
    * "./UCI HAR Dataset/train/X_train.txt"
    * "./UCI HAR Dataset/train/y_train.txt"
    * "./UCI HAR Dataset/train/subject_train.txt"
    * "./UCI HAR Dataset/test/X_test.txt"
    * "./UCI HAR Dataset/test/y_test.txt"
    * "./UCI HAR Dataset/test/subject_test.txt"

  2. Then combinding columns by train and test file groups into dftrain and dftest variables (did not combind activity_labels.txt and features.txt at this step).
  3. Combind row of dftrain and dftest.
  4. Then rename columns with the names inside features.txt.
  5. Extracting columns that contain mean and standard diviation in column names with simple regular expression "[Mm]ean[(]|[Ss]td[(]" (I intended to exclude meanFreq() column).
  6. Replacing activities number with actual descriptive text from activity_label.txt
  7. Rename other columns name to be more descriptive by replacing abbreviation "t" and "f", putting "." between words and replacing "-" with ".".
  8. using aggregate.data.frame function to group data frame by Subject ID and Activity then apply mean function to compute mean for each column.
  9. write output file "tidyDataset.txt" to working directory.
