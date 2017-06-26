#Code Book

##Overview


##Source Data
The data was downloaded from the following site as a .zip file on 6/21/17 at 16:27 EDT.
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

##Transforms
Data from test/subject_test.txt was merged with data from train/subject_train.txt 
along the subject ID column.

An additional column was created "activity.type" by referencing activity_labels.txt. 
The originial column was receoved in the output tiddata dataframe.


Column names were asigned to the variables using the features.txt and then further 
modified based on the information in features_infro.txt.

The following modifications to the column names:
1) Y, X, and Z variables were appended with "axis"
2) mean() and std() were replaced with MeanOf and StDevOf
3) Time variables were marked as such, previously starting with "t"
4) Frequency variables were marked as such, previously starting with "f"
5) "Acc" was unabbreiated to "Acceleration"
6) All dashes ("-") were removed
