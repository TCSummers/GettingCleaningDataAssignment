
##create test dataset
test1<-read.table("/Users/tylersummers/Desktop/Coursera/R/UCI HAR Dataset/test/subject_test.txt");
  names(test1)<-c("subject");
  ##subject identifiers

test2<-read.table("/Users/tylersummers/Desktop/Coursera/R/UCI HAR Dataset/test/y_test.txt");
  names(test2)<-c("activity");
  ##activity labels

test3<-read.table("/Users/tylersummers/Desktop/Coursera/R/UCI HAR Dataset/test/X_test.txt");
    ##acceleration
  names3<-read.table("/Users/tylersummers/Desktop/Coursera/R/UCI HAR Dataset/features.txt");
      ##field names for acceleration data
  names(test3)<-names3$V2 ##apply names to test3
  test3 <- test3[ !duplicated(names(test3)) ] ##sourced approach from stackoverflow;
  test3<-select(test3, matches("*[Mm]ean*|*std*"));
      ##remove any rows not means or stdevs

testdata<-cbind(test1,test2,test3); ##combine all test data


##create train dataset
train1<-read.table("/Users/tylersummers/Desktop/Coursera/R/UCI HAR Dataset/train/subject_train.txt");
  names(train1)<-c("subject");
  ##subject identifiers

train2<-read.table("/Users/tylersummers/Desktop/Coursera/R/UCI HAR Dataset/train/y_train.txt");
  names(train2)<-c("activity");
  ##activity labels

train3<-read.table("/Users/tylersummers/Desktop/Coursera/R/UCI HAR Dataset/train/X_train.txt");
    ##acceleration data
  names(train3)<-names3$V2 ##apply names to test3;
  train3 <- train3[ !duplicated(names(train3)) ] ##sourced approach from stackoverflow;
  train3<-select(train3, matches("*[Mm]ean*|*std*"));
  ##remove any rows not means or stdevs
  
traindata<-cbind(train1,train2,train3);##combine all train data


##merge the datasets
dataset<-merge(traindata,testdata,all=TRUE);
  rm("names3","test1","test2","test3","testdata","train1","train2","train3","traindata");

##Label the activities in new column
dataset$activity.type[dataset$activity=="1"]<-"WALKING";
  dataset$activity.type[dataset$activity=="2"]<-"WALKING UPSTAIRS";
  dataset$activity.type[dataset$activity=="3"]<-"WALKING DOWNSTAIRS";
  dataset$activity.type[dataset$activity=="4"]<-"SITTING";
  dataset$activity.type[dataset$activity=="5"]<-"STANDING";
  dataset$activity.type[dataset$activity=="6"]<-"LAYING";

##Add descriptive variable names
names(dataset)<-sub("-Y$","Yaxis",names(dataset));##from features_info.txt
  names(dataset)<-sub("-X$","Xaxis",names(dataset));##from features_info.txt
  names(dataset)<-sub("-Z$","Zaxis",names(dataset));##from features_info.txt
  names(dataset)<-sub("mean\\(+\\)","MeanOf",names(dataset));##for natural language
  names(dataset)<-sub("std\\(+\\)","StDevOf",names(dataset));##for natural language
  names(dataset)<-sub("^t","Time",names(dataset));##from features_info.txt
  names(dataset)<-sub("^f","Freq",names(dataset));##from features_info.txt
  names(dataset)<-sub("Acc","Acceleration",names(dataset));##from features_info.txt
  names(dataset)<-sub("-","",names(dataset))
  
##create a tidy data frame
dupe<-c("activity")
  tidydata<-dataset[ , !(names(dataset) %in% dupe)];
  rm(dupe,dataset);##clean up extra steps

##add averages by activity
z<-data.frame(subject="Averages",t(colMeans(tidydata[1:2099,2:87])),activity.type="NA")#mean for each column
  names(z)<-names(tidydata);##set col names equal
  tidydata<-rbind(tidydata,z);##add new row of means
  

##add averages by subject
z<-data.frame(rowMeans(tidydata[1:10300,2:87]))##create subject averages
  names(z)<-"SubjectAverages"
  tidydata<-cbind(tidydata,z);
  rm(z);##clean up extra steps

##output
write.table(tidydata,file="TylersTidyData.txt",row.name=FALSE)

##sure hope that works!
