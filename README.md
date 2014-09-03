GCD_CourseProject
=================
This is a submission to Course Project for Getting and Cleaning Data (coursera)

The data for the Project is available at:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
Details of the dataset are available [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).  

Outputs of the project:  
1) file "tidy.txt" with first data set  
2) file "tidier.txt" with second (tidy) data set  
3) file "README.md" with explanation on how the script work  
4) file "CodeBook.md" which describes the variables, the data, and all transformations with raw data 
5) file "run_analysis.R" which contains R script for performing the analysis.    

##Steps of analysis  

1.The dataset was downloaded unzipped and read into corresponding training and test data frames.  
2.Some of the labels were added to the dataframes with more descriptive names.   
3.`Train` and `test` data frames are merged into one data frame `df`  
4. Descriptive activity names are added to name the activities in the data set.
5. Only mean and and standard deviation measurements are filtered into data set `df_mer`
6. An independent dataset `tidy` is created with average of each variable for each activity and each subject and written to `tidy.txt`
7.To make data set more descriptive its melted and given appropriate lables resulting in dataset `tidier` , finally written to `tidier.txt`




