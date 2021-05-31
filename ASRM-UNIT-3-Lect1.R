##################  structural equation modeling ####################

# Structural equation modeling is a multivariate statistical analysis technique 
# that is used to analyze structural relationships. This technique is the combination 
# of factor analysis and multiple regression analysis, and it is used to analyze the 
# structural relationship between measured variables and latent constructs.

############# Lecture 1 ##################

# 1. Linear Model Implies a correlation Matrix

# Loading Data

library(MASS)
data(Boston)
head(Boston)

### Correlation ###
# Correlation is one of the most common statistics. Using one single value, it 
# describes the "degree of relationship" between two variables. Correlation ranges 
# from -1 to +1. Negative values of correlation indicate that as one variable increases 
# the other variable decreases.  Positive values of correlation indicate that as one 
# variable increase the other variable increases as well.  
# There are three options to calculate correlation in R, and we will introduce two of 
# them below.

install.packages("lavaan")
library(lavaan)
library(semPlot)
install.packages("semPlot")

####### Pearson Correlation #############

# Pearson's r measures the linear relationship between two variables, say X and Y. 
# A correlation of 1 indicates the data points perfectly lie on a line for which Y 
# increases as X increases. A value of -1 also implies the data points lie on a line; 
# however, Y decreases as X increases.


# The Pearson correlation has two assumptions:
# 1. The two variables are normally distributed.  We can test this assumption using
#   a. A statistical test (Shapiro-Wilk)
#   b. A histogram
#   c. A QQ plot

# 2. The relationship between the two variables is linear. If this relationship 
# is found to be curved, etc. we need to use another correlation test. 
# We can test this assumption by examining the scatterplot between the two variables.

# To calculate Pearson correlation, we can use the cor() function. The default method 
# for cor() is the Pearson correlation. Getting a correlation is generally only half the 
# story, and you may want to know if the relationship is statistically significantly 
# different from 0.

# H0: There is no correlation between the two variables: ρ = 0
# Ha: There is a nonzero correlation between the two variables: ρ ≠ 0


cor(Boston)
cor.test(Boston$crim,Boston$medv)

