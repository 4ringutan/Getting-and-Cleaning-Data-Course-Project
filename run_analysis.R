fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

download.file(fileURL, basename(fileURL), method = "curl") #downloads file to current directory

file.rename(basename(fileURL), paste0("projectfiles", ".zip")) #renames the zipfile

unzip("projectfiles.zip", files = NULL, exdir=".") #unzips zipfile

subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt") #read data files and label them
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt") #read data files and label them
X_test <- read.table("UCI HAR Dataset/test/X_test.txt") #read data files and label them
X_train <- read.table("UCI HAR Dataset/train/X_train.txt") #read data files and label them
y_test <- read.table("UCI HAR Dataset/test/y_test.txt") #read data files and label them
y_train <- read.table("UCI HAR Dataset/train/y_train.txt") #read data files and label them
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt") #read data files and label them
features <- read.table("UCI HAR Dataset/features.txt")  #read data files and label them

DS1 <- rbind(X_train, X_test) #merges training and test sets

DS2 <- rbind(y_train, y_test) #merges training and test labels

DS3 <- rbind(subject_train, subject_test) #merges subject data

relevant <- grep("mean()|std()", features[, 2]) #extracts the positions of only the mean and stds
DS1 <- DS1[,relevant] #applies those positions to the sets

features2 <- gsub("[()]", "", features[,2]) #gets rid of () and subsets the V2 column

names(DS1) <- features2[relevant] #labels DS1 variables 
names(DS2) <- 'activity' #labels DS2
names(DS3) <- 'subject' #labels DS3

DS4 <- cbind(DS3,DS2,DS1) #merges subject, activity and data

actlabs <- factor(DS4$activity) #encodes the dataset as a factor
levels(actlabs) <- activity_labels[,2]
DS4$activity <- actlabs #numbers to labels

library(reshape2)

meltDS4 <- melt(DS4,(id=c("subject","activity"))) 
newDS <- dcast(meltDS4, subject + activity ~ variable, mean) #makes a new dataset with only the mean
write.table(newDS, "tidy_data.txt", sep = ",")



