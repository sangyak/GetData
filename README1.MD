## Introduction
This assignment uses data from
the http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
, where data collected from the accelerometers from the Samsung Galaxy S smartphone.

* Data is first downloaded and unzipped from the following source
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

* Next all data in the train and test sets are read into R

* Data is then merges all the train data together and all the test data together
  (subject, activity, and the measurements)

* Next the 2 data sets are merged to create a master data set called all

* A summary file, text file tiny_data.txt is created to summarize the mean measurement values by subject and activity. I also included Description of the activity.