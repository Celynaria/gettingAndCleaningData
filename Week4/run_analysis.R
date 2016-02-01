## Read Feature and activities files
activities <- read.table(file = "./UCI HAR Dataset/activity_labels.txt")
features <- read.table(file = "./UCI HAR Dataset/features.txt")

## Read train dataset
Xtrain <- read.table(file = "./UCI HAR Dataset/train/X_train.txt")
Ytrain <- read.table(file = "./UCI HAR Dataset/train/y_train.txt")
SubjectTrain <- read.table(file = "./UCI HAR Dataset/train/subject_train.txt")

## Read test dataset
Xtest <- read.table(file = "./UCI HAR Dataset/test/X_test.txt")
Ytest <- read.table(file = "./UCI HAR Dataset/test/y_test.txt")
SubjectTest <- read.table(file = "./UCI HAR Dataset/test/subject_test.txt")

# Create data frame of train and test dataset then combind them
dftrain <- cbind.data.frame(SubjectTrain, Ytrain, Xtrain)
dftest <- cbind.data.frame(SubjectTest, Ytest, Xtest)
df <- rbind.data.frame(dftrain, dftest)

# rename colums
colnames(df)[1] <- "Subject.ID"
colnames(df)[2] <- "Activity"
colnames(df)[3:563] <- as.character(x = features$V2)

# extract only mean() and standard() diviation
column_needed <- c("Subject.ID","Activity",names(df)[grep(pattern = "[Mm]ean[(]|[Ss]td[(]", x = names(df))])
filtered_df <- df[column_needed]

# This is a nice trick recommended by Luis SandinoWeek in discussions forum of this course.
# Just matching indexes of 2 vectors
filtered_df$Activity <- activities[[2]][filtered_df[["Activity"]]]

## rename columns again for better descriptive name
# replacing them one by one to avoid confusion.
names <- gsub(pattern ="-" ,replacement = "." ,x = colnames(filtered_df))
names <- gsub(pattern ="mean[(][)]" ,replacement = "Mean" ,x = names)
names <- gsub(pattern ="std[(][)]" ,replacement = "StandardDiviation" ,x = names)
names <- gsub(pattern ="^f" ,replacement = "Frequency." ,x = names)
names <- gsub(pattern ="^t" ,replacement = "Time." ,x = names)
names <- gsub(pattern ="Acc" ,replacement = "Acceleration" ,x = names)
names <- gsub(pattern ="Mag" ,replacement = "Magnitude" ,x = names)
colnames(filtered_df) <- names

## Create independent tidy data (mean of each variable by subject id and activities)
tidy <- aggregate.data.frame(x = filtered_df[3:68], by = list(filtered_df$Subject.ID,filtered_df$Activity), FUN = mean)
colnames(tidy) <- names

## Output file
write.table(x = tidy, file = "tidyDataset.txt", row.names = FALSE)
## END of file.



