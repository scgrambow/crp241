
# CRP241 Script file for the bp log data transform example
# in class on 09.01.22 (Datasets)

# We are performing a transformation of the BMI variable in the 
# bpdata data frame (or dataset). We first load the data from 
# the web -- below is the URL where it is stored on the web 
# in a publicly available web folder.


# the code below creates a variable called 'url' and sets
# the value of the variable to the web url where the csv
# data file containing the data is located
url <- "http://www.duke.edu/~sgrambow/crp241data/bpdata2022.csv"

# Next we create a data frame called 'bpdata2022' and we use
# the read.csv function in combination with the url variable
# to pull the data in from the web. If we simply type the name 
# of the data frame, we will see a listing of the variables 
# and data values.

bpdata2022 <- read.csv(url)
bpdata2022

# The first thing we do is take a look at the structure 
# of the dataset using the 'str' or structure 
# function. This will provide a compact summary 
# of the dataset including number of observations (n=13),
# number of variables (n=6), variable names, variable types,
# and the first data values for each variable.

str(bpdata2022)

# we see that there are two missing values denoted as 'NA'

# Now we want to calculate the new variable ln(bmi), 
# the natural log of bmi. We create a new variable in the 
# bpdata2022 data frame called ‘ln_BMI’ based on the existing BMI 
# variable. The appropriate syntax shown below references the data 
# frame name and new variable name and then uses the assignment 
# symbol ‘<-’ to indicate that we want to assign the log of the 
# BMI variable to this new variable.

bpdata2022$ln_BMI <- log(bpdata2022$BMI)

# We can now visually inspect the modified data frame by listing 
# the data frame as we did above. As you can see, R has automatically 
# changed the missing values (blanks) to NA.

bpdata2022


## End of File
