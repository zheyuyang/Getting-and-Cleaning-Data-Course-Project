I Data Files Review

•	features_info.txt: Shows information about the variables used on the feature vector.

•	features.txt: List of all features.

•	activity_labels.txt: Links the class labels with their activity name.

•	train/X_train.txt: Training set.

•	train/y_train.txt: Training labels.

•	test/X_test.txt: Test set.

•	test/y_test.txt: Test labels.

•	train/subject_train.txt: Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

•	train/Inertial Signals/total_acc_x_train.txt: The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

•	train/Inertial Signals/body_acc_x_train.txt: The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

•	train/Inertial Signals/body_gyro_x_train.txt: The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second.


II Data Cleaning Review 

1.	Perform merge to have three datasets after reading in raw data:
•	Test data and test labels. 
•	Training data and training labels. 
•	Subject for test and training data.

2.	Merge all three datasets above together to form the dataset for analysis. 

3.	Read in the file for 561 features and replace column names with features. 

4.	Keep data for column names with Mean() and Std() only. 

5.	Read in the file for 6 activities, factorize the activity variable with description instead of number 1-6. 

6.	Provide a more clear and descriptive labeling for variable names.

7.	Summarize the data by subject and activity, and keep the average of each variable for each activity and each subject. 
