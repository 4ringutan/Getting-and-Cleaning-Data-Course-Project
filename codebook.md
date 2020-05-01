Step 0. The link for the file was assigned to a variable "fileURL. The
zip file was downloaded with download.file and renamed. The zip file was
then unzipped.

Step 1. Data files were read with read.table. The train and the tests
were merged with rbind. Three datasets were produced: DS1 = training and
testing data DS2 = activity code for training and testing data DS3 =
subject id for training and testing data

Step 2. Only the mean and standard deviations were extracted from DS1
and assigned to DS1.

Step 3. The variables from DS1, DS2 and DS3 were given descriptive names

Step 4. The activity code was converted to it’s appropriate activity
from the “activity\_labels”

Step 5. A new dataset was created with the average of each variable for
each activity and subject
