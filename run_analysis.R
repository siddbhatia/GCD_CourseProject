setwd("~/datasciencecoursera/GCD_CourseProject")
fileUrl<-"http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile = "UCI HAR Dataset.zip")
unzip("UCI HAR Dataset.zip")

X_train <- read.table("~/datasciencecoursera/GCD_CourseProject/UCI HAR Dataset/train/X_train.txt")
Y_train <- read.table("~/datasciencecoursera/GCD_CourseProject/UCI HAR Dataset/train/y_train.txt")
subject_train<-read.table("~/datasciencecoursera/GCD_CourseProject/UCI HAR Dataset/train/subject_train.txt")

X_test <- read.table("~/datasciencecoursera/GCD_CourseProject/UCI HAR Dataset/test/X_test.txt")
Y_test  <- read.table("~/datasciencecoursera/GCD_CourseProject/UCI HAR Dataset/test/y_test.txt")
subject_test <-read.table("~/datasciencecoursera/GCD_CourseProject/UCI HAR Dataset/test/subject_test.txt")

features<-read.table("~/datasciencecoursera/GCD_CourseProject/UCI HAR Dataset/features.txt")

activity_labels<-read.table("~/datasciencecoursera/GCD_CourseProject/UCI HAR Dataset/activity_labels.txt")


##4.Appropriately labels the data set with descriptive variable names. 
##Done once again at bottom for tidier data set
colnames(subject_test)<- c("subject")
colnames(subject_train)<- c("subject")
colnames(Y_test)<- c("activity_id")
colnames(Y_train)<- c("activity_id")
colnames(X_test)<-c(t(features)[2,])
colnames(X_train)<-c(t(features)[2,])
colnames(activity_labels)<-c("activity_id","activity_label")

## 1. Merges the training and the test sets to create one data set.
test<-cbind(X_test,Y_test,subject_test)
train<-cbind(X_train,Y_train,subject_train)

df<-rbind(test,train)

##3.Uses descriptive activity names to name the activities in the data set
df_merge<-merge(activity_labels,df,by.x="activity_id",by.y = "activity_id")

##2.Extracts only the measurements on the mean and standard deviation for each measurement.
nam<-c(as.vector((features[grepl("mean|std|Mean",features$V2),2])),"subject","activity_label")
df_mer<-df_merge[,nam]

##5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidy <- aggregate(df_mer, list(df_mer$"subject", df_mer$"activity_label"), FUN = mean, na.rm=TRUE)
colnames(tidy)[1] <- "Subject"
colnames(tidy)[2] <- "Activity"
tidy_ds<-tidy[,1:88]

write.table(tidy_ds,"tidy.txt",row.names = F)

# Create a second, independent tidy data set with the average of each variable for each activity and each subject.
# we will create a second data set by reshaping the first data set
# for reshaping we wil use two packages: reshape2 and plyr
library(reshape2)
library(plyr)
#Reshape the first data set in data frame
tidy_melted <- melt(tidy_ds, id = c("Subject", "Activity"))
#Calculate the mean(average) with the help of ddply function
tidier <- ddply(tidy_melted,.(Subject, Activity, variable),summarize,mean=mean(value))
#Change name "mean" with "average"
names(tidier)[4] <- "average"
#Write second data set to the file
write.table(tidier, file = "tidier.txt",row.names = F)

