## HEADER ####
## who:
## what:
## when last edited:

## CONTENTS ####



## 2.1 ####
my_vector <- c(11.3, 11.2, 10.4, 10.4, 8.7, 
               10.8, 10.5, 10.3, 9.7, 11.2)

my_vector[6]

## 2.2 ####
## Vectors ####
# Try this

my_vector <- c(11.3, 11.2, 10.4, 10.4, 
               8.7, 10.8, 10.5, 10.3, 9.7, 11.2)

# Return all values
my_vector        # Typical way
my_vector[ ]     # Blank index implies all index values
my_vector[1:10] # Returns all index values explicitly

# Return the first 3 values
1:3 # Reminder of the function of the colon operator ":"
my_vector[ 1:3] # Notice consecutive indices can use the ":" operator

# Return 5th and 9th values
my_vector[ c(5, 9)] # Notice we have to place non-consecutive index values in the c() function


## 2.3 ####
# Try this

my_matrix <- matrix(data = c(2,3,4,5,6,6,6,6),
                    nrow = 2, byrow = T)

my_matrix # notice how the arguments arranged the data

# Flash challenge: make a matrix with the same data vector above to look like...
#      [,1] [,2]
# [1,]    2    6
# [2,]    3    6
# [3,]    4    6
# [4,]    5    6

# "Slicing" out a row or column
my_matrix[1,  ] # Slice out row 1
my_matrix[ , 3] # Slice out column 3

# Matrix columns and rows often have names
names(my_matrix) # No names yet

nrow(my_matrix) # Returns number of rows (useful for large matrices)
rownames(my_matrix) # No row names; 2 rows, need two names

rownames(my_matrix) <- c("dogs", "cats")
my_matrix # Now the rows have names!
rownames(my_matrix) # Get them this way too!

# Flash challenge: Name the columns of my_matrix "a", "b", "c", "d" with colnames()

colnames(my_matrix) <- c("a", "b", "c", "d")

# Should look like this:
#      a b c d
# dogs 2 3 4 5
# cats 6 6 6 6

# You can also slice out matrix portions by name
my_matrix["dogs", c("b", "d")]

# Finally, functions act on values, not the index
mean(my_matrix["dogs", c("b", "d")])

## 3 ####
# Try this
help(which) # Notice how the x argument is required to be a LOGICAL vector?

# Make a NUMERIC vector
vector_a <- c(3, 4, 5, 4, 3, 4, 5, 6, 6, 7)

# Use a boolean phrase to ask which elements of vector_a are greater than 5
vector_a > 5 # Interesting... it is a LOGICAL vector!

# which() will return the index values of TRUE values
# In other words, WHICH values in vector_a are greater than 5?
# What VALUES in vector_a are > 5?
vector_a[which(vector_a > 5)]

# This also works on vectors of other types
# Consider a character vector
char_vec <- c("wheat", "maize", "wheat", "maize", "wheat", "wheat")

# Which elements are equivalent to "wheat"?
# <- 
# =
# ->
char_vec == "wheat"
which(char_vec == "wheat")

char_vec[ which(char_vec == "wheat")] # This works
char_vec[ char_vec == "wheat"]        # Same output

# Flash challenge: Explain in your own words why 
# the previous 2 lines of code have identical output?

## 4.1 ####
## OrchardSprays
## Understand the data - an important step

# Try this
# Load the OrchardSpray data using the data() function
data(OrchardSprays) # Should see OrchardSprays <promise> in the Global Env.

# Look at the data head()
head(OrchardSprays) # First 6 rows

# Look at variable types with str()
help(str) # Good function to see info about data object
str(OrchardSprays)

# First let's just look at the data
# Don't worry too much about the code for these graphs if you have not encountered it before
boxplot(decrease ~ treatment, data = OrchardSprays, 
        main = "The pattern fits the prediction",
        ylab = "Amount of sucrose consumed",
        xlab = "Lime sulpher treatment amount in decreasing order (H = control)")

# This is the experimental design
# Latin Square is kind of like Sudoku
# No treatment can be in row or column more than once
plot(x = OrchardSprays$colpos,  # NB use of $ syntax to access data
     y = OrchardSprays$rowpos, 
     pch = as.character(OrchardSprays$treatment),
     xlim = c(0,9), ylim = c(0,9),
     main = "The Latin Square design of treatments",
     xlab = "\"Column\" position",
     ylab = "\"Row\" position")

## 4.2 ####
## Practice selecting parts a data frame

# Select the rows of the dataset for treatment "D"

# (Pseudocode steps to solve) 
# Break it down to make small steps easy to read

# 01 Boolean phrase to identify rows where treatment value is "D"
# 02 which() to obtain index of TRUE in boolean vector
# 03 Exploit [ , ] syntax with data frame object to slice out rows

# 01 Boolean phrase
OrchardSprays$treatment # Just print variable to compare visually to boolean
OrchardSprays$treatment == "D" # logical vector - TRUE in "D" positions

# 02 which()
which(OrchardSprays$treatment == "D") # Index of TRUE values
my_selection <- which(OrchardSprays$treatment == "D") # Place index in a variable
my_selection # Just checking

# 03 Exploit [ , ] syntax with data frame object to slice out rows
OrchardSprays[my_selection, ]

# Flash challenge: Select and print all rows at "colpos" values of 2
myvar <- which(OrchardSprays$colpos == 2)
OrchardSprays[ myvar ,  ]

## 5 ####
help(aggregate)

# A few important things to note about how this function works:
# The "x" argument is a data object you input, but should only contain numeric values usually
# If a data.frame object is input as x, a data.frame object is the output
# The "by" argument must be a list() object and can be one or more indices
# The FUN argument is the name of the function that will act on the "x" argument data

# Let's try a few examples

## 1 calculate the mean of decrease by treatment in OrchardSprays

aggregate(x = OrchardSprays$decrease,
          # NB use of list() and naming it "treatment"
          by = list(treatment = OrchardSprays$treatment), 
          FUN = mean)

# we can "recycle" the code above to apply different functions
# standard deviation with sd()
aggregate(x = OrchardSprays$decrease,
          # NB use of list() and naming it "treatment"
          by = list(treatment = OrchardSprays$treatment), 
          FUN = sd)

# Range with range()
aggregate(x = OrchardSprays$decrease,
          # NB use of list() and naming it "treatment"
          by = list(treatment = OrchardSprays$treatment), 
          FUN = range)

# What if we want several summary statistics?

aggregate(x = OrchardSprays$decrease,
          # NB use of list() and naming it "treatment"
          by = list(treatment = OrchardSprays$treatment), 
          # NB use of function() 
          FUN = function(x) c(mean = mean(x), # Add naming
                              sd = sd(x), 
                              range = range(x)))

## Example of use of aggregate object
# Say you would like to graph a barplot of the MEAN of decrease by treatment
# and you would like to show STANDARD DEVIATION error bars

# Make data frame with summary values using aggregate()
my_mean <- aggregate(x = OrchardSprays$decrease,
                     by = list(treatment = OrchardSprays$treatment), 
                     FUN = mean)

my_sd <- aggregate(x = OrchardSprays$decrease,
                   by = list(treatment = OrchardSprays$treatment), 
                   FUN = sd)

my_mean
my_sd

# Tidy things up in a new data frame using data.frame()
# Take care of naming variables for clarity
help(data.frame) # Continue using help() as a good habit
new_data <- data.frame(treatment = my_mean$treatment,
                       mean = my_mean$x,
                       sd = my_sd$x)
new_data # Looks good

# There is a lot going on in the following code
# The point is to show what is possible

(bar_centers <- barplot(new_data$mean,#   use mean for barheight
                        ylim = c(0, 115),
                        ylab = "Mean solution decrease (+- 1 SD)",
                        xlab = "Treatment"))
# NB bar_centers holds the numerical position value of the bars...

help(arrows)  # Use to draw error bars
arrows(x0 = bar_centers, 
       x1 = bar_centers,
       y0 = new_data$mean , # start error bar at top of the bar!
       y1 = new_data$mean + new_data$sd, # end error bar here!
       angle = 90,
       length = 0.1)

# Last step: label the x axis
axis(side = 1,
     at = bar_centers,
     labels = new_data$treatment)

# Flash challenge: Draw a new barplot by recycling the code above
# This time, add error bars showing on both the top and the bottom of the mean values
