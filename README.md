# GetData_010_CourseProject

## Analysis of the UCI HAR dataset

In this repo you will find the run_analysis.R file with the code to work on the original HAR data and
the CodeBook explaining the variable names and their values.

## The run_analysis.R 

- First I read-in the file "features" with the original variable names,
  then the subject-, X- and Y-test files.

- My first task was to integrate the variable names in the X_test file.
  I made a character vector out of the 'features' file, which I then rbinded to the X_test file.
  To get the new row with the variable names as headers I safed the X_test file and reopend it with
  'headers = TRUE'.

- To merge the three 'test' files I gave all of them a new column, which I could use later as the
  'merge( by = )' command.
  
- In the merge process I also eliminated the columns, that were not necessary for this course project.
  This completed the merging for the 'test' data.frames.
  
- I repeated the same process for the 'train' files and was then ables to merge the 'test' and the 'train'
  data.frames to the tidy data.frame 'HAR_dataset'
  
- The final work was to integrate descriptive names for the values in the 'Activity' column and for the variable
  names.
  
## The CodeBook

I ended up with 81 variables, of which 79 are measurements or calculations from measurements.
I gave the variable names by mainly relying on the 'feature_info' file in the original dataset.
However, my understanding of the technical part of the study is not very deep. This may have 
resulted in names that represent not the exact scientific reality of those numbers. And I am not
certain about the units in the measurements. The information I implemented is partly from the discussion forum.

Renaming the variables took me much longer than I anticipated. And I am not convinced that the
'more descriptive' names really give you a better understanding of the study.
In my opinion, when you are working with this study material it is easier to read the introduction
than to work with those long variable names. If you understand the study, you will most likely have
no difficulty understanding the abbreviated variable names. But, of course, it was a good excersise
in R.
  


