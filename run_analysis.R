### Assignment Project to do the following
   #read test and train data, 
   #append them together, 
   #add column names 
   #add row ids of subject and activities
   #create subset with mean and std measurements (columns) alone
   #create second dataset that groups by subject and activity providing mean for every measure
        ## Author: Arun Prasad, arunprasadrv@yahoo.com

### House keeping - working dir etc Assuming all the workoutput will be in "assignment" folder
                rm(list=ls())
                setwd("./assignment")
                getwd()

##Reading TEST data X
        filename <- "./UCI HAR Dataset/test/X_test.txt"
        #Reading data X separated with multiple spaces
        dataX <- read.table(filename, sep = "" , header = F , #nrows = 100,
                           na.strings ="", stringsAsFactors= F)
                dim(dataX)  #2947  561
                dataX[1,550:561]
                str(dataX)
        
        #4. Appropriately labels the data set with descriptive variable names.       
        #Reading variable names from features - i.e. column names of the data_x
        featuresfile <- "./UCI HAR Dataset/features.txt"
        features <- read.table(featuresfile, sep="", header = F, na.strings ="", stringsAsFactors= F)
                head(features)
                tail(features)
                str(features)
                
        #changing the names of the dataX columns to features vector measurements
        names(dataX) <- features[,2]
                names(dataX) 
                str(dataX)
                
        #Reading activity "y" values 
        yfile <- "./UCI HAR Dataset/test/y_test.txt"
        y_id <- read.table(yfile, sep="", header = F, na.strings ="", stringsAsFactors= F)
                class(y_id)
                y_id$V1[1:10]  #y_id[1:10,1]
                unique(y_id)

        #3. Uses descriptive activity names to name the activities in the data set
        #Reading the activity description file
        activitydescfile <- "./UCI HAR Dataset/activity_labels.txt"
        activitydesc <- read.table(activitydescfile, sep="", header = F, na.strings ="", stringsAsFactors= F)
                activitydesc
                
        #Naming activitydesc in the y_id data frame to add description field
        activity<-merge(y_id, activitydesc, by="V1")
        names(activity)<-c("acty_id","acty_desc")
                head(activity)
                tail(activity)
                
        #Reading subject_id values and assigning identifier subject_id column
        subjectfile <- "./UCI HAR Dataset/test/subject_test.txt"
        subject_tst_id <- read.table(subjectfile, sep="", header = F, na.strings ="", stringsAsFactors= F)
                class(subject_tst_id)
                unique(subject_tst_id)
        
        #Append the activity y column into the test dataset X
        test_dataX <- cbind(subject_id=subject_tst_id[,1],activity,dataX)
                names(test_dataX)
                
        #Remove all intermediate data except test_dataX
        rm(activitydesc,activitydescfile,activity,subject_tst_id,subjectfile,
           y_id,yfile,dataX,features,featuresfile,filename)


##Reading TRAINING data X
        filename <- "./UCI HAR Dataset/train/X_train.txt"
        #Reading data X separated with multiple spaces
        dataX <- read.table(filename, sep = "" , header = F , #nrows = 100,
                            na.strings ="", stringsAsFactors= F)
                dim(dataX)  #7352  561
                dataX[1,550:561]
                str(dataX)
        
        #4. Appropriately labels the data set with descriptive variable names.
        #Reading variable names from features - i.e. column names of the data_x
        featuresfile <- "./UCI HAR Dataset/features.txt"
        features <- read.table(featuresfile, sep="", header = F, na.strings ="", stringsAsFactors= F)
                head(features)
                tail(features)
                str(features)
        
        #changing the names of the dataX columns to features vector measurements
        names(dataX) <- features[,2]
                names(dataX) 
                str(dataX)

        #3. Uses descriptive activity names to name the activities in the data set       
        #Reading activity "y" values 
        yfile <- "./UCI HAR Dataset/train/y_train.txt"
        y_id <- read.table(yfile, sep="", header = F, na.strings ="", stringsAsFactors= F)
                dim(y_id)
                y_id$V1[1:10]  #y_id[1:10,1]
                unique(y_id)
        
        #Reading the activity description file
        activitydescfile <- "./UCI HAR Dataset/activity_labels.txt"
        activitydesc <- read.table(activitydescfile, sep="", header = F, na.strings ="", stringsAsFactors= F)
                activitydesc
        
        #Naming activitydesc in the y_id data frame to add description field
        activity<-merge(y_id, activitydesc, by="V1")
        names(activity)<-c("acty_id","acty_desc")
                head(activity)
                tail(activity)
        
        #Reading subject_id values and assigning identifier subject_id column
        subjectfile <- "./UCI HAR Dataset/train/subject_train.txt"
        subject_trn_id <- read.table(subjectfile, sep="", header = F, na.strings ="", stringsAsFactors= F)
                dim(subject_trn_id)
                unique(subject_trn_id)
                unique(test_dataX$subject_tst_id) #verifying if subject ids are unique between train and test
        
        #Append the activity y column into the test dataset X
        train_dataX <- cbind(subject_id=subject_trn_id[,1],activity,dataX)
                names(train_dataX)
                head(train_dataX[,1:6])
                tail(train_dataX[,1:6])
        
        #Remove all intermediate data except test_dataX and train_dataX
        rm(activitydesc,activitydescfile,activity,subject_trn_id,subjectfile,y_id,yfile,dataX,
           features,featuresfile,filename)
        
        
#1. Merging training and test dataset
        all_dataX <- rbind(train_dataX,test_dataX)
                names(all_dataX)
                head(all_dataX[,1:6])
                tail(all_dataX[,1:6])
        
#2. Extracts only the measurements on the mean and standard deviation for each measurement.
                names(all_dataX)[grep("mean()|std()",names(all_dataX))]
        subset_dataX <- all_dataX[,c(1:3,grep("mean()|std()",names(all_dataX)))]
                names(subset_dataX)        
        
#5. creates a second, independent tidy data set with the average of each variable for each activity and each subject.
                library(dplyr)
        second_dataX <- subset_dataX %>% group_by(subject_id,acty_desc) %>% summarise_each(funs(mean))
                View(second_dataX)
                
# Writing the tidy dataset from step 5 using write.table()
                write.table(second_dataX,"tidy_data_ap.txt",row.names = FALSE)
                
                