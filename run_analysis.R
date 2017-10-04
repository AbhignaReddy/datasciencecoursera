setwd("/Coursera/Getting and Cleaning Data/UCI HAR Dataset/test")
test_set<- read.table("./X_test.txt",header=FALSE)
test_set_names<-read.table("./y_test.txt",header=FALSE)
activity_labels<-read.table("./activity_labels.txt",header=FALSE)
subject<-read.table("./subject_test.txt",header=FALSE)
test_set_names<-merge(test_set_names,activity_labels,by.x="V1",by.y="V1")
test_set_names<-rename(test_set_names,c("V2"="Activity"))
features<-read.table("./features.txt",header=FALSE)
colnames(test_set)<-features$V2
test_set$Activity<-test_set_names$Activity
test_set$Subject<-subject$V1


setwd("/Coursera/Getting and Cleaning Data/UCI HAR Dataset/train")
train_set<-read.table("./X_train.txt", header = FALSE)
train_set_names<-read.table("./y_train.txt", header = FALSE)
activity_labels<-read.table("./activity_labels.txt",header=FALSE)
subject<-read.table("./subject_train.txt",header=FALSE)
train_set_names<-merge(train_set_names,activity_labels,by.x="V1",by.y="V1")
train_set_names<-rename(train_set_names,c("V2"="Activity"))
features<-read.table("./features.txt",header=FALSE)
colnames(train_set)<-features$V2
train_set$Activity<-train_set_names$Activity
train_set$Subject<-subject$V1

data_set<- rbind(test_set,train_set)

data_set_mean<-subset(data_set,select=grep("[Mm]ean", names(data_set), value=TRUE))
data_set_std<-subset(data_set,select=grep("[Ss]td", names(data_set), value=TRUE))
data_set_mean_std<-cbind(data_set_mean,data_set_std)
data_set_mean_std<-cbind(data_set_mean_std,data_set$Activity)
data_set_mean_std<-rename(data_set_mean_std,c("data_set$Activity"="Activity"))
data_set_mean_std<-cbind(data_set_mean_std,data_set$Subject)
data_set_mean_std<-rename(data_set_mean_std,c("data_set$Subject"="Subject"))
data_melt<-melt(data_set_mean_std,id=c("Activity","Subject"))
data_cast<-dcast(data_melt,Activity + Subject ~ variable, mean)
