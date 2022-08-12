
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~ Introduction to RStudio ~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# ACUPUNCTURE RCT DESCRIPTION
# A randomized, controlled trial was conducted to 
# determine the effect of acupuncture therapy vs. 
# no acupuncture therapy on headache, health status, 
# days off sick, and resource use in patients with 
# chronic headaches. These measures were assessed at 
# randomization, 3 months post-randomization, and 1 
# year post-randomization. 401 patients were enrolled 
# in the trial at 36 sites. 

# TRIAL RESULTS
# Overall, the results of the trial were positive. 
# Investigators found that the use of acupuncture 
# therapy lead to significant reduction in the 
# headache score and components of the health 
# status instrument. 

# REFERENCE
# Andrew J Vickers, Rebecca W Rees, Catherine E Zollman, 
# Rob McCarney, Claire M Smith, Nadia Ellis, Peter Fisher 
# and Robbert Van Haselen, 2004 Mar 27;328(7442):744

# DATA DICTIONARY (subset from over 90 variables collected)
#
# id              patient ID code
# age             Age
# sex             female (1) vs. male (0)
# migraine        diagnosis ; migraine (1) vs. tension-type (0)
# chronicity	  number of years of headache disorder
# acupuncturist	  acupuncturist id code
# practice_id	  gp practice id
# group	          treatment group; acupuncture (1) vs. control (0)
# pk1	          headache severity score baseline
# pk2	          headache severity score 3 month 
# pk5	          headache severity score 1 year
# f1  	          headache frequency baseline
# f2	          headache frequency 3 month
# f5	          headache frequency 1 year

# load the Site 18 Acupuncture dataset: 
url <- "https://raw.githubusercontent.com/scgrambow/crp241/master/datasets/site18_data.csv"
site18_data <- read.csv(url)

# Check: Was the data read in correctly?
# - How many observations are in the data set? Variables?
str(site18_data)

# Some variable naming and manipulations
#
# First, change categorical variables to factors
#
# group variable
# Recall that group is numeric with
# 0 = control
# 1 = acupuncture
table(site18_data$group)

# Create Factor version of group -- f.group
site18_data$f.group <- factor(site18_data$group,
                              levels = c(1,0),
                              labels = c("Treat","Control"))
table(site18_data$f.group)

# check coding
table(site18_data$f.group,site18_data$group)

# migraine variable
# Recall migraine is numeric with
# 0 = tension type 
# 1 = migraine type
table(site18_data$migraine)

# Create Factor version of group -- f.migraine
site18_data$f.migraine <- factor(site18_data$migraine,
                              levels = c(1,0),
                              labels = c("Migraine","Tension"))
table(site18_data$f.migraine)

# check coding
table(site18_data$f.migraine,site18_data$migraine)

# sex variable
# Recall sex is numeric with
# 0 = male 
# 1 = female
table(site18_data$sex)

# Create Factor version of group -- f.migraine
site18_data$f.sex <- factor(site18_data$sex,
                                 levels = c(1,0),
                                 labels = c("Female","Male"))
table(site18_data$f.sex)

# check coding
table(site18_data$f.sex,site18_data$sex)

# now lets move on to calculating summary measures
# Calculate summary measures for chronicity in overall sample: 

# Option 1: Use the summary function
# - To select the chronicity variable out of 
#   the data frame, use the $ after the name
#   of the data frame, followed by the name
#   of the chronicity variable
summary(site18_data$chronicity)

# Option 2: Calculate summary measures 
#           individually using measure-
#           specific functions
mean(site18_data$chronicity)      # Mean/Average
median(site18_data$chronicity)    # Median
var(site18_data$chronicity)       # Variance
sd(site18_data$chronicity)        # Standard Deviation
IQR(site18_data$chronicity)       # Interquartile Range

# Calculate summary measures for chronicity by treatment group
# First do this using site18_data data frame
by(site18_data$chronicity,site18_data$f.group,summary)

# Calculate summary measures for chronicity by treat group
# Alternate method -- by subsetting the data by treat group
# and calculating summaries within each group
acupunc <- subset(site18_data,group==1)   # Treatment = Acupuncture
control <- subset(site18_data,group==0)   # Control = No Acupuncture

# Check: Were the subsets created correctly?
# - How many observations are in the data 
#   set? Variables?
str(acupunc)
str(control)

# Calculate group specific summary measures:
# using summary() function
summary(acupunc$chronicity)
summary(control$chronicity)

# using individual functions for each measure
# For Treatment Group:
mean(acupunc$chronicity)      
median(acupunc$chronicity)    
var(acupunc$chronicity)       
sd(acupunc$chronicity)        
IQR(acupunc$chronicity)    

# For Control Group:
mean(control$chronicity)      
median(control$chronicity)    
var(control$chronicity)       
sd(control$chronicity)        
IQR(control$chronicity)


# Create a histogram of chronicity in the 
# overall sample:
# - A histogram is essentially a bar graph 
#   that groups the values of a continuous 
#   variable into bins and plots the freq 
#   of each bin (or number of data values 
#   that fall into each bin). 
# - Now have 3 data sets in the workspace; 
#   which one should be used here?

# Standard Output:
hist(site18_data$chronicity)

# With more informative titles/labels:
hist(site18_data$chronicity,
     main="Histogram of Chronicity in Overall Sample",
     xlab="Chronicity")

# Create side-by-side box plots of chronicity 
# by treatment group:
# - A box plots plots horizontal lines at the 
#   min, first quartile, median, third quartile, 
#   and max of the data values. A box is drawn
#   around the first and third quartiles, and 
#   lines are extended out to the max and min. 
#   Potential outliers may be indicated by dots. 

# Standard Output using tilda (~) notation
# think of ~ as meaning 'by'.  Here the data
# to be plotted is in a single variable 'chronicity'
# and is differentiated by 'group'.
boxplot(site18_data$chronicity ~ site18_data$group,
        names = c('Control','Treatment'),
        main="Histogram of Chronicity in Overall Sample",
        xlab="Treatment Arm",
        ylab="Years of Headache Disorder")

# using f.group
boxplot(site18_data$chronicity ~ site18_data$f.group,
        main="Chronicity by Treatment Group",
        xlab="Treatment Arm",
        ylab="Years of Headache Disorder")

# Alternate approach to obtaining side by side boxplots
# if data to be compared is in different columns/variables
# using ',' notation 
# note this uses the data frames created by subsetting
# on group
boxplot(acupunc$chronicity,control$chronicity,
        names = c("Treatment","Control"),
        main="Chronicity by Treatment Group",
        ylab="Chronicity",
        xlab="Treatment Group"
        )

# One important descriptive stat that is often 
# overlooked is the number of missing values 
# for each variable in a data set.
summary(site18_data)

# How many values are missing for the variable 
# headache severity at 1 year?
# summary shows that pk2 (NAs = 9) and pk5 (NAs = 12)
# have missing values

# Suppose we wanted to calculate the mean 
# head severity at 1 year in the overall 
# sample. How should we handle the missing 
# values?
mean(site18_data$pk5)
mean(site18_data$pk5,na.rm=TRUE)

# So far, only discussed calculating summary
# measures for continuous variables. Suppose
# we wanted to calculate summary measures 
# for the categorical variable group: 

# Calculate frequncies for group using factor version of group: 
table(site18_data$f.group)

# we can also create 2 x 2 tables -- group by migraine
table(site18_data$f.group,site18_data$f.migraine)

# can also use factor version for 2 x2 proportions
prop.table(table(site18_data$f.group,site18_data$f.migraine))

# END OF PROGRAM
# --------------