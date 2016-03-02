#Readme.md
---------------------------------------
Assignment Project to do the following:
   read test and train data, 
   append them together, 
   add column names 
   add row ids of subject and activities
   create subset with mean and std measurements (columns) alone
   create second dataset that groups by subject and activity providing mean for every measure

Files:
-------
Please find the file outputs
1. run_analysis.R - this is the file that has the script for reading and performing the said objective
2. Codebook.md - this file lists all the variables and their definition as a result of executing the script
3. Readme.md - this file lists all the relevant information on the submission of the assignment
4. tidy_data_ap.txt - this file is the output tidy dataset delimited by space


Script flow:
------------
1. Reads the test data set named X_test.txt
2. Adds names to all the 561 columns by reading the features.txt file
3. Reads the activity ids from the y_test.txt file
4. Using the activity_labels.txt file, looksup the activity description for each activity id
5. Reads the subject_test.txt for the subject id
6. Appends to the dataset, the subject id, activity id and activity description columns
7. Does 1 through 6 steps for training dataset using corresponding training files
8. Creates global dataset appending training and testing data thus far created
9. Subsets this set to a smaller set with selected columns with measures of mean and std alone
10. Creates a table with mean of observations grouped by subject and activity description
11. writes this tidy dataset into the assignment directory


Assumption:
------------
Assumed that all files will be in "assignment" directory and then you could execute this code
Create "assignment" directory from the current working directory and copy the script and data files
dplyr package is assumed to be installed or else, please install using install.packages("dplyr") command

Author:
----------
Arun Prasad, arunprasadrv@yahoo.com
