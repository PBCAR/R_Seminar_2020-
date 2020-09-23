################################################################################
############################### == Import our data == ##########################
################################################################################

### Okay, onto the second part of the seminar. Let's begin by loading the tidyverse. For
#         reference, the tidyverse is a group of packages that are specialized for handling
#         data from pre-processing, all the way to visualization. 

library(tidyverse)

### Now that we have the tidyverse loaded, let's import the 'PBCAR.DF.csv' data from our 
#       computer into R's global environment. This is the data we're mainly going to work with. 


pbcar.df.og <- read.csv(file = "C:/Users/dezia/Downloads/PBCAR.DF.csv") #  The 'file =' argument is where
                                                                        #      you specify the file path. 

### Let's examine the first and last 6 rows of our data set using the 'head()' and 'tail()' functions.
#        

head(x = pbcar.df.og) # The "x =" is where we assign our data object  
tail(x = pbcar.df.og) # The "x =" is where we assign our data object

#####
#####
#####
################################################################################
############################# == Atomic Classes == #############################
################################################################################

### Atomic classes -- The six basic types, or 'classes', of 'atoms' which comprise 
#                     most data in the R universe. These are the six basic data types that R
#                     can support. We're going to focus on 4 of these 6 types, because the 
#                     last 2 types are rarely encountered in our research and beyond the 
#                     scope of this seminar.

### 1.) Logicals -- Boolean values: TRUE or FALSE

typeof(T)
typeof(TRUE)

typeof(F)
typeof(FALSE)

### 2.) Integers -- Real numbers without decimal points AKA 
#                   whole numbers that exist on a number line 
#                   (ex. -2, -1, 0, 1, 2... etc).
#
# NOTE: True integers in R must be be written in the following
#       manner to be considered an integer type: 
#
#          xL,
#
#       where x is whatever integer value you desire.

typeof(-1L)

### 3.) Doubles -- Real decimal numbers (numbers that
#                  exist on a number line -- negative infinity to positive
#                  infinity, and everything in between).

typeof(1.4435)

### 4.) Characters --letters and words and... numbers (kind of)
#
# NOTE: For something to be considered a character in R, it must be enwrapped by single or 
#       double quotation marks (ex. "hello" or 'hello')

typeof('hello world')
typeof("hello world")
typeof("1.4435")
typeof("hello world1.4435")

#####
#####
#####
################################################################################
############################# == Data structures == ############################
################################################################################

### Since we've finished up with atomic classes, let's move onto data structures.
#         Data structures, simply put, are different ways of shaping our data.
#         Certain data structures are well-suited for some things, and poorly suited
#         for others. Let's examine 4 of the most common data structures in R.

### 1.) Vector -- a 1-dimensional structure that only support a single atomic class

### Let's assign the ID column from 'pbcar.df.og' to the object 'number.vec'.

number.vec <- pbcar.df.og$ID

number.vec

typeof(number.vec) 

### When we view the object in our console, we can see that it occupies only
#      a single dimension because of how there are neither rows nor columns.
#      We can also see that it consists entirely of integers -- a single atomic class.
#
### Just to be sure, let's check whether 'number.vec' is a vector using the 
#         'is.vector()' function. All we need to do is pass 'number.vec' through it.

is.vector(number.vec)

### 2.) Matrix -- a 2-dimensional (rows & columns) structure that only supports a single atomic class

### Let's make a matrix out of our 'number.vec' object. Given that this is a one-dimensional object
#         with 150 entries, our matrix will be 1 column x 150 rows. We will construct this matrix using
#         the 'matrix()' function, and assign 'number.vec' as an input to the 'data =' argument.  

matrix(data = number.vec)

### We can also specify the number of rows and columns in our matrix using the 'nrow =' and 
#         'ncol =' arguments, respectively. Let's set the number of rows = 15, and columns
#         = 10. Let's call this item, 'number.mat'.

number.mat <- matrix(data = number.vec, 
                     nrow = 15,
                     ncol = 10)

number.mat
typeof(number.mat)

### 3.) Data frame -- A 2-dimensional structure that can support multiple atomic classes

### Let's make a data frame out of 'number.vec' by passing it through the 'data.frame()' function.
#       We'll assign it to an object called 'sample.df.1'. It should be a simple 150 rows X 1 column
#       data frame. 

sample.df.1 <- data.frame(number.vec)

sample.df.1 

### Now let's make a 2 column X 150 row data frame using the 'age_group' column from 
#        'pbcar.df.og' and 'number.vec'. We'll assign this data frame to an object 
#         called 'sample.df.2'. 

sample.df.2 <- data.frame(pbcar.df.og$age_group,
                          number.vec)

sample.df.2

### Let's examine some other attributes of data frames that we can play
#     around with. Specifically, let's change the column names, and then
#     the row names. 
#
### We'll change the column name by first passing our data frame, 'sample.df.2' through
#       the 'colnames()' function. 
#
# Then we create a character vector where we specify our desired column
#       names in the order they occur in 'sample.df.2'.

colnames(sample.df.2) <- c('new_agebins',
                           'new_ids')

colnames(sample.df.2)

### Changing row names is essentially the same as column names. Let's
#         assign a new set of numbers as row names.

rownames(sample.df.2) <- 101:250

rownames(sample.df.2)

### Now, let's introduce a semi-new way of selecting columns. When columns have unique names, we can subset them using
#         their name. The quick way of doing it is one we've already seen, but it follows this format:
#
#             data.frame.name$column.name

sample.df.2$new_ids
sample.df.2$new_agebins

### 4.) Factors -- A structure that assigns an order 
#                  to categorical data  -- useful for
#                  statistical computing in R.

### Let's explore factors. To do this, let's assign the 'age_group' column from
#       'pbcar.df.og' to a new object called 'data'

data <- pbcar.df.og$age_group

data 

### This object, 'data', has 3 unique entries: 'teen', 'young adult', and
#         'adult'. Clearly, it's age-binned data.
#
### Okay, now let's see if 'data' is a factor using the 'is.factor()' function.

is.factor(data)

### Hmm, not yet. Let's assign a factor to this data, using the 'factor()' function.
#       We'll pass the 'data' object through the 'factor()' function, and then 
#       assign the function's output to an object called 'factor_data'.

factor_data <- factor(x = data) # The 'x =' argument is where you input your categorical data vector

factor_data

### So we can see that the unique values in 'factor_data' have been categorized as 'Levels'.
#       'Levels' are the term we use to describe the unique values of a categorical variable
#       once they've been transformed into factor. Looking closer, we see that the levels 
#       have been ordered alphabetically. 
#

### Since the levels of our factor are age-bins, and they don't lend
#        themselves to being ordered alphabetically,let's arrange them in the right order. 
#
# We'll still use'the 'factor()' function, except this time, we'll specify a second
#       argument, 'levels ='.

new_order_data <- factor(x = factor_data,
                         levels = c("teen",        # The 'levels =' argument is where you input a vector of your
                                                   #      factor levels in your desired order. 
                                    "young adult",
                                    "adult"))

new_order_data

#####
#####
#####
################################################################################
############################# == Wrangling Data == #############################
################################################################################

### Now, let's get to working with real data. 
#
# Let's view the full 'pbcar.df.og' dataframe in its own R window.

View(pbcar.df.og) 

# We can see that the data frame currently has 6 columns (5 integers and 1 factor) and 150 rows. 
#       Each row represents a single participant, where each participant has a unique ID and is 
#       assigned to an age-group. The remaining 4 variables are as described:
#
#       A.) We have 'drinks_1' and 'drinks_2', which measure frequency of alcohol consumption
#                    at two consecutive time points, 
#
#       B.) 'cudit', which measures cannabis use disorder at time point 1, 
#       
#       c.) 'gad', which measures anxiety scores at time point 1. 
#
# The current format of the data is referred to as the 'wide' format. We'll get into different
#       formats very shortly. 
#
# Let's assign 'pbcar.df.og' to an object, 'wide.data'.

wide.data <- pbcar.df.og

### Now let's convert the 'wide.data' from wide to long format.
#
# NOTE: A.) Long format = each DATA POINT gets its own row
#                         (a single column to store all data points). 
#
#       B.) Wide format = each PARTICIPANT gets their own row
#                         (multiple columns storing different measurements for a single participant).
#
### Let's also introduce a crucial part of writing clean R code: the 'pipe operator'.
#
# The %>% symbol in the code chunk below is called the 'pipe operator'. It's used in the 
#       the following format:
#
#       data.frame %>% 
#
#       function_1(argument1 = .,
#                  argument2 = input2,
#                  ...
#                  argumentN = inputN) %>% 
#
#       function_2(argument1 = .,
#                  argument2 = input2,
#                  ...
#                  argumentN = inputN) %>% 
#
#       ... %>% 
#
#       function_N(argument1 = .,
#                  argument2 = input2,
#                  ...
#                  argumentN = inputN) 
#
# "This operator will forward a value, object, or the result of an expression, into the next 
#       function call/expression." 
#       (https://uc-r.github.io/pipe#:~:text=The%20principal%20function%20provided%20by,(data%2C%20variable%20%3D%3D%20numeric_value))
#
# The benfits of using the pipe operator is that it makes your code more readable. When 
#       used in a cascade of functions to clean/wrangle data, it executes each function sequentially, but does
#       not require the output of each function to be stored in R's memory. Thus, it frees up memory which
#       allows you to extend your analysis by not overwhelming R. 
#
# NOTE: when using the pipe operator, to forward the output of one function into the next one, 
#       place a period in the argument where you would assign data.
#
# Now, let's convert 'wide.data' to the long format. We'll do this using the 'gather()' function from the
#       tidyverse. This function 'gathers' all variable columns and their corresponding data into two columns.
#       One column will contain the name of the variable being measured and the other will store the corresponding measurement 
#       in the adjacent cell.
#
# This long data will be assigned to an object called 'long.data.og'. 

long.data.og <- wide.data %>% 
  
                  gather(data = .,             # The 'data =' argument is where you specify your wide data frame 
                                               #
                         key = variable,       # The 'key =' argument is where you name the column that will 
                                               #      store the names of the variables you want to gather
                                               #
                         value = measurement,  # The 'value =' argument is where you name the column that will
                                               #      store the corresponding values for the 'key' column 
                                               #
                         -ID,-age_group) %>%   # At this point, you can select which columns' you don't want 
                                               #      to be 'gathered'. You do this by 
                                               #      by specifying a minus sign followed by the column name
                                               #      from the wide data frame. 
    
                  as.data.frame(x = .) # This function converts the object into a data frame

# Let's take a look!

View(long.data.og)

### So we've successfully transformed data from wide to long format... but what about from long to wide format?
#          Let's transform 'long.data.og' back to wide format, and assign it to an object called 
#          'wide.data.remade'. 
#
# We're going to use the 'spread()' function which is a part of the tidyverse.
#         This function quickly and easily transforms data from long to wide format
#         by 'spreading' the entries in the 'variable' and 'measurement' columns
#         into their own columns, 

wide.data.remade <- long.data.og %>% 

                      spread(data = .,           # The 'data =' argument is where you specify your long data frame
                                                 #
                              key = variable,    # The 'key =' argument is where you specify the column which 
                                                 #     contains the column names for each variable 
                                                 # 
                            value = measurement) # The 'value =' argument is where you specify the column that 
                                                 #     stores the measurement for each variable

View(wide.data.remade)

### To end off, we'll go over how to merge two separate data sets that share identical columns
#
# Let's start by importing the second data set into R, and assigning it to the object 
#       'pbcar.df.additional'. Once we do, let's observe the data frame.

pbcar.df.additional <- read.csv(file = "C:/Users/dezia/Downloads/PBCAR.DF2.csv")

View(pbcar.df.additional)

### Examining the 'pbcar.df.additional' object, we can see that it shares the 'ID' and 'age_group',
#       columns that the 'pbcar.df.og' object also had. What makes 'pbcar.df.additional' unique is
#       that it has two columns which store each participants' 'cudit' and 'gad' scores at the second 
#       time point. 
#
# Given that both 'pbcar.dfs' have at least one column with identical entries, we can use R to
#       combine them, and work with a single data frame. We'll merge the two using the 'merge()'
#       function provided by base R, and assign it to an object called 'pbcar.df.all'. 

pbcar.df.all <- merge(x = pbcar.df.og,           # The 'x =' argument is where you specify your
                                                 #      the first data frame you wish to merge
                                                 #
                      y = pbcar.df.additional,   # The 'y =' argument is where you specify your
                                                 #      the second data frame you wish to merge
                                                 #
                      by =  c('ID','age_group')) # The 'by =' argument is where you specify the 
                                                 #      names of the shared columns between both
                                                 #      data frames IF they have identical column
                                                 #      names. 
                                                 

View(pbcar.df.all)

### That concludes seminar one. Kyla and I will post our lectures on the official PBCAR GitHub for you to access, and
#        use as informational resources to help you solve your take-home exercise (also on the PBCAR GitHub). See ya
#        on October 7th for part 2 :) 

#####
#####
#####
################################################################################
############################ == End of Seminar pt. 1 == ########################
################################################################################