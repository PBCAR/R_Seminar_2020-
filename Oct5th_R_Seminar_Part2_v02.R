####################################################################################################################
################################## == Taking up homework (Finished -- Checked X2) == ##################################
####################################################################################################################
#
### Welcome to part two of the PBCAR R Bootcamp! Last time we left off, we introduced you to RStudio, and 
#     got you acquainted with the theory behind programming in R! Today, we'll calculate some
#     descriptive statistics, visualize some data, and learn some more fun stuff! 
#
### Before we begin, you may notice some overlap in content between me and Kyla. This was done intentionally as 
#     we wanted certain things in this lecture to be emphasized more than others. We felt that the overlapped
#     material was crucial to performing an efficient, reproducable analysis in R, and we wanted to show you
#     how to apply them in multiple contexts. 
#   
###  We'll begin by taking up your assigned 'homework'. First, we'll load the tidyverse and read in the data
#       we were using in part 1 of the bootcamp. Then, we'll merge them together and store our merged data into
#       an object called 'pbcar.df.all'.

library(tidyverse)

pbcar.df.og <- read.csv(file = "C:/Users/dezia/Downloads/PBCAR.DF.csv")

pbcar.df.additional <- read.csv(file = "C:/Users/dezia/Downloads/PBCAR.DF2.csv")

pbcar.df.all <- merge(x = pbcar.df.og,
                      y = pbcar.df.additional,
                      by =  c('ID','age_group'))  

head(pbcar.df.all, 10)

### If you recall, you had 3 goals in your homework assignment:
#
#       1.) Rename the 'cudit' and 'gad' columns to 'cudit_1' and 'gad_1'
#
#       2.) Arrange the columns in the following order; 
#     
#          ['ID', 'age_group', 'drinks_1', 'drinks_2', 'cudit_1', 'cudit_2', 'gad_1', 'gad_2']
#
#      3.) Sort the data frame's rows in ascending order according to the 'ID' column. 
#
### Let's go ahead and take-up our answers! 
#
### To rename the the 'cudit' and 'gad' columns, we simply pass 'pbcar.df.all' through the
#       'colnames()' function, select the fifth and sixth items in the the character vector that
#       'colnames()' spits out, and then assign a new character vector to these 
#       specified entries with your desired column names. 

colnames(pbcar.df.all)

colnames(pbcar.df.all)[5:6] <- c("cudit_1",  
                                 "gad_1")

colnames(pbcar.df.all)

### Now let's address the second and third issue. We can manually reorder of the columns by explicitly
#         writing them using the 'select()' function. We'll pass the 'pbcar.df.all' object through 
#         'select()' as our first argument, and every other argument onwards is simply the name of the columns
#         that you wish to select from the data frame separated by commas. The order in which we specify the 
#         column names is the order in which they will appear where the first name is the left-most column and the 
#         last name corresponds to the right-most column. 
#
### To properly order the rows of 'pbcar.df.all', we'll need the 'arrange()' function.
#         ;arrange()' allows us to order the rows of our data frame according to the contents of a given 
#         column. We first pass our data frame (the 'selected' version of 'pbcar.df.all') through the arrange
#         function, and then we specify the column which we will use to ascendingly order our data frame. 
#         In our case, that would be the 'ID' column. This resolves the third and final issue.
#
#
# Let's resolve the last two issues, reassign the data frame to 'pbcar.all.df' and view our data frame.

pbcar.df.all <- pbcar.df.all %>% 
  
  select(.data = .,    # Resolves the second issue
         ID,
         age_group,
         drinks_1,
         drinks_2,
         cudit_1,
         cudit_2,
         gad_1,
         gad_2) %>%
                       
  arrange(.data = .,   
          ... = .$ID)  # The '... =' argument is where you 
                       #      specify the column you wish to
                       #      order the rows of your data frame
                       #      by. 

View(pbcar.df.all)

### Perfect! We can see that 'pbcar.df.all' has been successfully wrangled & cleaned!
#     If your solution doesn't match ours' or if you were unable to figure out a
#     solution, please don't be discouraged. I applaud you for trying and encourage
#     to keep at it. Learning R is frustrating, that's for sure. The more you practice,
#     the more exposure you'll get to the language, and the better of an R programmer 
#     you'll become. 
#
### That concludes taking up the homework. Let's move onto the actual content!

#####
#####
#####
####################################################################################################################
######################## == Descriptive stats on unstratified data (Finished -- Checked X2) == ########################
####################################################################################################################

### So I'll be leading the first half of this seminar, and I'll start by calculating some
#       descriptive statistics on the 'pbcar.df.all' data set.  
#
### To begin, let's go ahead and load the 'psych' package. This package aggregates 
#       several functions specialized for working with psychometric data, which is usually
#       the type of data we work with at the centre. 

library(psych)

### Now, let's take the 'pbcar.df.all' object and assign it to a new object called 'pbcar.df'. 

pbcar.df <- pbcar.df.all

### We'll calculate some descriptive stats on the  pbcar dataset using
#         two different functions:
#
#       1.) summary() -- offered by base R, this function calculates mean, 
#                        median, mode, maxes, mins, and the 1st and 3rd quartiles 
#                        for continuous data. For discrete data, it calculates 
#                        absolute number of counts (called 'Length')
#                        for unique values, the atomic class, 
#                        and the mode. 
#                        
#       2.) describe() -- offered by the 'psych' package, this function calculates the
#                         number of observations, mean, standard deviation, median,
#                         trimmed mean, median absolute difference, mins, maxes, range, skew,
#                         kurtosis, and standard error for each column in a data frame regardless
#                         of whether it is continuous or discrete data. 
#
# We'll apply each of these functions to the pbcar data set without statifying by 'age_group'. 

describe(pbcar.df)
summary(pbcar.df)

### Looking at the output in our console, we can see that both the 'summary()' and 
#    'describe()' functions output our descriptive stats in tables. 
#     We can also see why it was important for us to rename and reorder
#     our columns -- they make comparing related variables much easier, as their
#     stats are adjacent. 
#
### The one way we can improve our analysis is by stratifying by age groups. This 
#    means that we apply a function/calculation across each level of a discrete 
#    variable. In our case, we will stratify by our 'age_group'.
#
### Since we have two separate functions we use to calculate our descriptive stats, we'll
#     have to use two different approaches to stratify our stats: the easy way, and the 
#     (slightly) harder way.
#
## Before we get into that, let's go ahead and factor our 'age_group' variable like we did
#        last time. 

pbcar.df$age_group <- factor(x = pbcar.df$age_group,
                             levels = c('teen','young adult','adult'))
#####
#####
#####
####################################################################################################################
########################## == Descriptive stats on stratified data (Finished -- Checked X2) == ########################
####################################################################################################################

# Now, to stratify our descriptive stats by 'age_group'.
#
# We'll start by using the 'describeBy()' function from the 'psych'
#   package. This function calculates the exact same descriptive stats as 'describe()'
#   across all levels of a specified grouping variable. We first pass
#   our data through an 'x =' argument, and then we specify what our grouping variable
#   is by passing the content of its columns through the 'group =' argument. 
#
# We'll assign the output of 'describeBy()' to an object called 'describe.list'. 
#   That's literally all we need for stratifying our calculations determined by 
#   'describe()'. 

describe.list <- 
  describeBy(x = pbcar.df,               # 'x =' argument specifies the data frame
                                         #
             group = pbcar.df$age_group) # 'group =' specifies the the column which
                                         #    contains group levels

### Let's do the same thing, but this time we'll use the 'summary()' function. Since there
#     isn't a separate group-level function, or argument in the original 'summary()' function 
#     to stratify our calculations, 
#     we'll have to do some additional data wrangling. That's what makes it the harder way.

### But before we can do this data wrangling, we'll need to learn about one more new data
#     structure: lists.
#
### Lists -- a 1-dimensional structure that can simultaneously store multiple
#            data structures of various atomic classes.
#
# Let's make a list! To do so, we'll use the 'list()' function. This function's arguments
#   are whatever data structures you want to store in the list, separated by commas. We'll
#   assign our list to object called 'example.list'. and then, we'll visualize it in our 
#   console. 

example.list <- list(1:10,                               # Object 1 -- integer vector
                     matrix(LETTERS),                    # Object 2 -- character matrix
                     'IsThisEnough2ConvinceYou?',        # Object 3 -- character string
                     pbcar.df.all,                       # Object 4 -- data frame 
                     list(1,'a',2,'b',3,'c',4,'d',5,'e') # Object 5 -- list of 10 items
                     )                                 
example.list

### Voila! We've made a list! Okay, let's get back to the main issue: 
#
#     Stratifying the descriptive stats output by the 'summary()' function
#     by our 'age_group' variable, 

### The first thing we'll need to use is the 'aggregate()' function.
#
# 'aggregate()' does manually, what'describeBy()' does automatically; it applies a 
#    a function across every column in a data frame, while stratifying for a grouping
#    variable. How does it know what our grouping variable is? Well, we supply it
#    with a list containing the contents of our grouping variable. 'aggregate()' then
#    determines the number of unique levels in your so-called 'group list', and 
#    applies your specified function to each column for how ever many group levels you have.
#   
# The output of the 'aggregate()' function is a list. In our case, 
#    we would have a list of summary stats for each column, calculated across all three of our
#    age groups. Let's see it in action!

pbcar.df %>%    
  
  aggregate(x = .,                  # 'x =' is used to specify your data frame  
            by = list(.$age_group), # 'by =' is used to specify your group list 
            FUN = summary)          # 'FUN =' is used to specify your desired function

### Cool! we have our list of stats stratified by age groups! But our output is a list...
#     Using a data frame would be more efficient. Let's go ahead and convert this list into
#     a data frame!
#
# To do so, we'll first convert each item in the 'aggregate' list into a data frame. Then, 
#   we'll combine those multiple small data frames into a single large data frame. 
#
# We must first use the 'lapply()' function. This function applies a function across every
#   item in a list. The function we wanna apply across our list is the 'as.data.frame()'
#   function. This will convert each item in our list of stats into a data frame. 
#
# Finally, we'll join each data frame together by passing our list through the 'data.frame()' function, and assign 
#   the output to an object called 'summary.df'.

summary.df <- pbcar.df %>%    
  
                  aggregate(x = .,                  # 'x =' is used to specify your data frame  
                            by = list(.$age_group), # 'by =' is used to specify your factor list 
                            FUN = summary)  %>%     # 'FUN =' is used to specify your desired function
                                                    
                  lapply(X =.,                      # 'X =' is used to specify your list 
                         FUN = as.data.frame) %>%   # 'FUN =' is used to specify your desired function
                                                    
                  data.frame(.)                     # Used to unify our data frames

### Let's explore what 'describe.list' and 'summary.df' look like.

describe.list

View(summary.df)

### Great! You're all on your way to become R experts! Let's go ahead and learn how to recode columns :) 

#####
#####
#####
####################################################################################################################
########################### == Recoding columns (Finished -- Checked X2) == ###########################################
####################################################################################################################

### Say we wanted to recode the levels of an existing discrete or continuous variable, 
#    & save our recoded data as a new column within the same data frame.
#
# We can do this with the 'mutate()' and 'case_when()' functions.'mutate()' creates
#   a new column, and 'case_when()' specifies 
#   multiple conditional statements on when to recode something. 'case_when()' is
#   a more efficient way of doing if-else statements in R. Let's see them 
#   in action together. 
#
# We'll name this new column 'age.ranges' and it'll store the newly-converted levels
#   of 'age_group'. When we're done creating the column, we'll append it to 'pbcar.df'
#   and store them in an object called 'pbcar.df.v02'.
#
# The first argument in 'mutate()' is where we pass our data frame, and the next argument
#   is where we declare the name of our new column. We'll call our new column 'age.ranges'.
#   We then specify how we want to recode our columns, and we do this using the 'case_when()'
#   function, which replaces the need for multiple if-else statements. Within the 'case_when()'
#   function, we input the conditions needed for our recoding. 
#
# For an example, the conditional statements are read as follows:
# 
#       "In the case when the 'age_group' column equals 'teen', recode it as 
#         '13 - 19 years' and assign it to a new column called 'age.ranges'." 
#
# Let's go ahead and run this code, and see our output. 

pbcar.df.v02 <- 
  pbcar.df %>% 
  
    mutate(.data = .,                                         # '.data =' specifies our data frame 
                                                              #
    age.ranges =                                              # This second position is where we name  
      case_when(age_group == 'teen'        ~ "13 - 19 years", #   the column that'll store our recoded data. 
                age_group == 'young adult' ~ "20 - 29 years", # 
                age_group == 'adult'       ~ "30 + years")    # This is where we specify our conditional 
          )                                                   #   statements for recoding 
                                                              #   data. Conditonals statements are 
                                                              #   declared using this format:
                                                              #
                                                              #   condition 1 ~ outcome if condition is met,
                                                              #   condition 2 ~ outcome if condition is met,
                                                              #   ...,
                                                              #   condition N ~ outcome if condition is met
          

View(pbcar.df.v02)

### Great! We've successfully recoded our data and we didn't have to use a single if-else statement, or
#      or a for-loop. Let's end off with some data visualization.
#####
#####
#####
####################################################################################################################
################################### == Waffle Plots (unchecked X2) == #################################################
####################################################################################################################
#
### We'll start by loading the 'waffle' package. Waffle plots visualize how many members belong 
#     to a specific group, and are suited for working with factors. Factor levels are colour-coded for ease 
#     of interpretation. We'll visualize our 'age.ranges' column using a waffle plot.
#
# From the 'pbcar.df.v02' date frame, we'll select the 'age.ranges' column and pass it through 
#   the 'table()' function. This function counts the how many of each factor level appears in
#   our data, and outputs that information as an integer vector. Each item in the vector
#   is named according to the level it represents. Finally, we'll pass this vector through
#   the 'waffle()' function and get our waffle plot. 
#   Let's get to visualizing!

library(waffle)

pbcar.df.v02 %>%     
  
  select(.data = .,        # The '.data =' argument is where you input your data frame
           age.ranges) %>% #   Positions beyond the first argument are simply column names 
                           #   separated by commas. 
                           #
  table(... = .) %>%       # The '... =' argument takes a vector of factor levels
                           #
  waffle(parts = .)        # The 'parts =' argument takes a numeric vector with
                           #   names assigned for each entry

### So we have our waffle plot, but it's looking a little plain... nobody likes plain waffles so let's go 
#     ahead and customize it.
#
# Let's do 5 things:
#
#      1.) Change the colors to something less ugly
#
#      2.) Flip our X- and Y-axes
# 
#      3.) Add a nice, descriptive title
#  
#      4.) Add a caption to make it clear what a single square represents
#
#      5.) Reposition our color legend
#
### To change the colours, we'll specify the 'colors =' argument in the 'waffle()' function. It takes 
#     a character vector of the colors we want. Let's go with something more vibrant, like
#     'red', 'green' , and 'blue'.

pbcar.df.v02 %>%     
  
  select(.data = .,        
         age.ranges) %>% 
  
  table(... = .) %>%       
  
  waffle(parts = ,
         colors = c('red','green','blue')) # 'colors =' specifies the colors of our plot

### Nice! We did it, a red, green and blue waffle plot! Now let's flip our X- and Y-axis. We'll do
#     try this in 2 ways. First, let's specify the 'rows =' arguments. We'll set it equal to 15, 
#     meaning our subsequent waffle plot is gunna have 15 rows (and 10 columns). Let's see if it
#     gives us something pretty. 

pbcar.df.v02 %>%     
  
  select(.data = .,        
         age.ranges) %>% 
  
  table(... = .) %>%       
  
  waffle(parts = ,
         colors = c('red','green','blue'), # 'colors =' specifies the colors of our plot
         rows = 15)                        # 'rows =' specifies the number of rows in our plot

### Shape-wise, it's looking good! But in terms of how the the squares are arranged in a 
#     column-wise manner, it isn't very visually appealing. Looking at this figure alone, I wouldn't
#     be able to tell that the three age-bins are of equal size.
#
### Let's try a different argument, the 'flip =' argument. This argument takes a 'TRUE' or 'FALSE'
#     which tells R to JUST rotate the original figure 90 degrees counter-clockwise. 
#     Let's see how our figure looks after we apply this transformation. 

pbcar.df.v02 %>%     
  
  select(.data = .,        
         age.ranges) %>% 
  
  table(... = .) %>%       
  
  waffle(parts = ,
         colors = c('red','green','blue'),         # 'colors =' specifies the colors of our plot
         flip = T)                                 # 'flip =' specifies rotating the plot 90 DEG (CC)


### It's looking good! Let's add a title. A good title would be something 
#     like 'Age Composition of Sample Data'. To do this, we'll specify an additional argument
#     called 'title ='. 

pbcar.df.v02 %>%     
  
  select(.data = .,        
         age.ranges) %>% 
  
  table(... = .) %>%       
  
  waffle(parts = ,
         colors = c('red','green','blue'),         # 'colors =' specifies the colors of our plot
         flip = T,                                 # 'flip =' Rotates the plot 90 DEG (CC)
         title = 'Age Composition of Sample Data') # 'title =' specifies the title of our plot

### We're almost done! Now we'll add an X-axis label that tells us exactly how many participants
#     are represented by a single square. Since we have 150 participants in total, our label
#     will read '1 Square = 1 Participant'. We'll pass this text through the 'xlab =' argument,
#     and see what we get!


pbcar.df.v02 %>%     
  
  select(.data = .,        
         age.ranges) %>% 
  
  table(... = .) %>%       
  
  waffle(parts = ,
         colors = c('red','green','blue'),         # 'colors =' specifies the colors of our plot
         flip = T,                                 # 'flip =' rotates the plot 90 DEG (CC)
         title = 'Age Composition of Sample Data', # 'title =' specifies the title of our plot
         xlab = '1 Square = 1 Participant')        # 'xlab =' specifies the X-axis label of our plot

### To finish off, let's reposition the legend of our waffle plot. It looks awkward where it is now,
#     and would look much, much better at the bottom of the plot. How do we tell R to put it there?
#     It's easy, we just use the 'legend_pos =' argument and assign it a value of 'bottom'. Let's
#     finish our plot off. 

pbcar.df.v02 %>%     
  
  select(.data = .,        
         age.ranges) %>% 
  
  table(... = .) %>%       
  
  waffle(parts = ,
         colors = c('red','green','blue'),         # 'colors =' specifies the colors of our plot
         flip = T,                                 # 'flip =' rotates the plot 90 DEG (CC)
         title = 'Age Composition of Sample Data', # 'title =' specifies the title of our plot
         xlab = '1 Square = 1 Participant',        # 'xlab =' specifies the X-axis label of our plot
         legend_pos = 'bottom')                    # 'legend_pos' specifies the position of our legend

### Great! We have a tasty looking waffle plot! That does it for my section, I'm gunna pass it 
#     off to Kyla for her to dazzle you with some more R magic!
#
#####
#####
#####
####################################################################################################################
################################### == End of part 1 for Seminar 2 == ##############################################
####################################################################################################################