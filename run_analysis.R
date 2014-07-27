#download data and unzip
url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url,destfile="./wearable_data.zip",method="curl")
unzip("./wearable_data.zip") # text file created, how do i know its name?
list.files() #folder of data appears

#read all data into R
subject_test <- read.table("/Users/sangyakalia/Desktop/Coursera/UCI HAR Dataset/test/subject_test.txt"
                           ,sep="\t",col.names=c("subject"))
X_test <- read.table("/Users/sangyakalia/Desktop/Coursera/UCI HAR Dataset/test/X_test.txt")  
y_test<-read.table("/Users/sangyakalia/Desktop/Coursera/UCI HAR Dataset/test/y_test.txt"
                   ,sep="\t",col.names=c("activity"))  
subject_train <- read.table("/Users/sangyakalia/Desktop/Coursera/UCI HAR Dataset/train/subject_train.txt"
                           ,sep="\t",col.names=c("subject"))
X_train <- read.table("/Users/sangyakalia/Desktop/Coursera/UCI HAR Dataset/train/X_train.txt")  #need column names
y_train<-read.table("/Users/sangyakalia/Desktop/Coursera/UCI HAR Dataset/train/y_train.txt"
                   ,sep="\t",col.names=c("activity"))  
#read labels
activity_labels <- read.table("/Users/sangyakalia/Desktop/Coursera/UCI HAR Dataset/activity_labels.txt")
features <- read.table("/Users/sangyakalia/Desktop/Coursera/UCI HAR Dataset/features.txt")

#########################################
# Part 1 - Merge train and test
#########################################
#extract column names for X
features1<-as.character(features[,"V2"])
#add column names to X_test, X_train
colnames(X_test)<-features1
colnames(X_train)<-features1

#create 2 data sets, train and test using cbind
test<-cbind(subject_test,y_test,X_test)
train<-cbind(subject_train,y_train,X_train)
#add label to each data set before joining test and train (may not need this but i like it)
test$set<-"test"
train$set<-"train"

#now merge test and train data sets
all<-rbind(test,train)

#########################################
# Part 2 - Mean and sd for each measurement
#########################################
sapply(all, mean, na.rm=TRUE)
sapply(all, sd, na.rm=TRUE)

#########################################
# Part 3 - Descriptive activity labels
#########################################
#now merge to get activity labels
all<-merge(all,activity_labels,by.x="activity",by.y="V1")
#rename V2 column
names(all)[names(all) == 'V2'] <- 'activity_description'

#########################################
# Part 5 - Descriptive variable names
# This was done in part 1. Code to check is below
#########################################
names(all)

#########################################
# Part 6 - Average of each variable  
# for each activity and each subject.
#########################################
tiny_data<-aggregate(all, by=list(Subject=all$subject,Activity=all$activity,Description=all$activity_description), FUN=mean, na.rm=TRUE)
#tiny_data<-tiny_data[order(tiny_data$Subject,tiny_data$Activity),]
tiny_data<-tiny_data[,!(names(tiny_data) %in% c("activity","subject","activity_description","row.names"))]
View(tiny_data)

# create text file 
write.table(tiny_data, "/Users/sangyakalia/Desktop/Coursera/tiny_data.txt", row.names=FALSE)
