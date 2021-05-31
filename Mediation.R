################## Baron & Kenny Approach to mediation #############


## Mediation ##

# A mediated effect is also called an indirect effect. It occurs when the 
# independent variable's effect on the dependent variable is — as the name 
# says — mediated by another variable: A mediator.

### Some important considerations when thinking about mediation are:
# 1. A mediator must be endogenous: This means that the mediator cannot be the 
# treatment nor the study conditions. The mediator itself must be dependent on the 
# exogenous variables, which often are the treatment or the study conditions 
# in experimental research.

# 2. A mediator must reveal more insight into how the independent variable 
# impacts the dependent variable: A mediator reveals something about the process.

### Conclusion ###

# So a mediation helps us find out how an independent variable influences a dependent variable. 
# By running a mediation analysis, we are testing hypotheses about the process 
# of how the independent variable impacts the dependent variable.


## Simple Idea ##
# Baron & Kenny Method #

# Step 1. Regress Y on X
# Step 2. Regress X on M
# Step 3. Regress Y on M and X


df=iris
set.seed(12334)


# Step #1: The total effect

# The total effect describes the total effect that the independent variable (iv) sepal 
# length has on the dependent variable (dv) likelihood to be pollinated by a bee. 
# Basically, we want to understand whether there is a relationship between the two variables. 

df$random1=runif(nrow(df),min=min(df$Sepal.Length),max=max(df$Sepal.Length))
df$mediator=df$Sepal.Length*0.35+df$random1*0.65
df$random2=runif(nrow(df),min=min(df$mediator),max=max(df$mediator))
df$dv=df$mediator*0.35+df$random2*0.65
fit.totaleffect=lm(dv~Sepal.Length,df)
summary(fit.totaleffect)

# This will yield the results below. As you can see, the total effect of sepal length 
# on our dv is significant (p<.05), and the coefficient (.12984) is very close to 
# the expected 12.25% (remember the 35% × 35% from above).

# So now we have a significant total effect. Let’s proceed to step 2.

# Step #2: The effect of the IV onto the mediator.

fit.mediator=lm(mediator~Sepal.Length,df)
summary(fit.mediator)

# This will yield the following results below. As you can see, the total effect 
# of sepal length on our dv is significant (p<.05), and the coefficient (.30429) 
# is close to the expected 35% from above.

# Now we have a significant effect of the independent variable “sepal length” 
# onto the mediator “attractiveness of the bloom to the bee.”

# Step #3: The effect of the mediator on the dependent variable

fit.dv=lm(dv~Sepal.Length+mediator,df)
summary(fit.dv)

#### Note several things about this output: #####

# The mediator has a significant effect (p<.05) on the dv. With the result from step #2, 
# we can now already say that there is a mediation. Again, the coefficient (.37194) 
# is very close to the expected 35%.

# Statistically, we have all the support we need to assume a mediation in the data. H
# owever, it is good practice to calculate the entire model in one. Mediation is a mini 
# structural equation model (SEM), so if we wanted, we could use SEM-packages for R like 
# “lavaan” to estimate the whole mediation. However, that would be quite complex. 
# Thankfully, there are much easier ways to get the job done. That’s what step #4 is about.

########### Step #4: Causal Mediation Analysis #########

# Let’s load up the necessary R packages.
install.packages("mediation") 
library(mediation)

# This loads (and installs) the Mediation package, which takes the regression models we 
# just estimated, combines them and estimates the whole mediation. So let’s run the command.
results = mediate(fit.mediator, fit.dv, treat='Sepal.Length', mediator='mediator', boot=T)
summary(results)


############### Results  ########################

# ACME stands for average causal mediation effects.

# ADE stands for average direct effects. It describes the direct effect of the 
# IV on the DV. Again, this is not new information. We have calculated this effect
# in step #3: the direct effect of the IV on the DV when controlling for the mediator.

# Total Effect stands for the total effect (direct + indirect) of the IV onto the DV. 
# This also isn’t new information. We calculated this in step #1. We can also get it 
# by simply adding the ACME (.1132) and the ADE (.0167) to receive the total effect of .1298. 
# We also already knew that the total effect was significant from step #1.


# Prop. Mediated describes the proportion of the effect of the IV on the DV that goes through 
# the mediator. It’s calculated by dividing the ACME (.113) by the total effect (.13) to 
# receive .87. This piece of information is a nice tidbit, but not necessarily the focus 
# of our interest.






