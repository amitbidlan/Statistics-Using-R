################ MultiCollinearity ###################

# In multiple regression two or more predictor variables might be correlated 
# with each other. This situation is referred as collinearity.

# There is an extreme situation, called multicollinearity, where collinearity 
# exists between three or more variables even if no pair of variables has a 
# particularly high correlation. This means that there is redundancy 
# between predictor variables.

# In the presence of multicollinearity, the solution of the regression model becomes unstable.

# For a given predictor (p), multicollinearity can assessed by computing a score 
# called the variance inflation factor (or VIF), which measures how much the variance 
# of a regression coefficient is inflated due to multicollinearity in the model.

# The smallest possible value of VIF is one (absence of multicollinearity).
# As a rule of thumb, a VIF value that exceeds 5 or 10 indicates a problematic 
# amount of collinearity.


################ Loading Required R packages ####################

# 1. tidyverse for easy data manipulation and visualization
# 2. caret for easy machine learning workflow
install.packages("tidyverse")
install.packages("caret")
library(tidyverse)
library(caret)


############### Preparing the data ######################

# Load the data
data("Boston", package = "MASS")
# Split the data into training and test set
set.seed(123)
training.samples <- Boston$medv %>%
  createDataPartition(p = 0.8, list = FALSE)
train.data  <- Boston[training.samples, ]
test.data <- Boston[-training.samples, ]

############### Building a regression model #############

# The following regression model include all predictor variables:
# Build the model
model1 <- lm(medv ~., data = train.data)
# Make predictions
predictions <- model1 %>% predict(test.data)
# Model performance
data.frame(
  RMSE = RMSE(predictions, test.data$medv),
  R2 = R2(predictions, test.data$medv)
)

######## Answers #########
##   RMSE   R2
## 1 4.99 0.67


################# Detecting multicollinearity ################

# The R function vif() [car package] can be used to detect multicollinearity 
# in a regression model:

car::vif(model1)

######### Answers ###########

##    crim      zn   indus    chas     nox      rm     age     dis     rad 
##    1.87    2.36    3.90    1.06    4.47    2.01    3.02    3.96    7.80 
##     tax ptratio   black   lstat 
##    9.16    1.91    1.31    2.97

# In our example, the VIF score for the predictor variable tax is very high 
# (VIF = 9.16). This might be problematic.


################ Dealing with multicollinearity ###################

# In this section, we’ll update our model by removing the the predictor 
# variables with high VIF value:

# Build a model excluding the tax variable
model2 <- lm(medv ~. -tax, data = train.data)
# Make predictions
predictions <- model2 %>% predict(test.data)
# Model performance
data.frame(
  RMSE = RMSE(predictions, test.data$medv),
  R2 = R2(predictions, test.data$medv)
)

############# Answers ###############

##   RMSE    R2
## 1 5.01 0.671

# It can be seen that removing the tax variable does not affect very much the 
# model performance metrics.


################## Discussion ####################

# Multicollinearity problems consist of including, in the model, different variables 
# that have a similar predictive relationship with the outcome. This can be assessed 
# for each predictor by computing the VIF value.

# Any variable with a high VIF value (above 5 or 10) should be removed from the model. 
# This leads to a simpler model without compromising the model accuracy, which is good.

# Note that, in a large data set presenting multiple correlated predictor variables, 
# you can perform principal component regression and partial 
# least square regression strategies.





