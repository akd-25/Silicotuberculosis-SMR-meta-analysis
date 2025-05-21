# Thu Apr 24 11:41:01 2025 ------------------------------
#Loading packages that were not previously loaded
library(metadat)
library(Matrix)
library(numDeriv)
load(file = "SMR_MA_obj") #Loading objects

#Viewing pooled SMR values
pooled_SMR_table_1.4 #Pooled group 3
pooled_SMR_table_g4 #Pooled group 4
pooled_SMR_SW #Pooled surface workers
pooled_SMR_M #Pooled miners

#Creating Forest Plots of SMR MA 
#Group 3 Forest Plot
?meta::forest #Available arguments
SMR_table_1.4
forest_group3 <- meta::forest(pooled_SMR_table_1.4,
             sortvar = log_SMR_1,  #Sorting by SMR
             layout = "JAMA",
             comb.random = TRUE,#Use random effects model
             comb.common = FALSE,
             overall = TRUE,
             print.random = TRUE,
             print.common = FALSE,
             prediction = TRUE,
             print.tau2 = FALSE,
             leftcols = c("Paper_names", "SMR_1", "log_SMR_1", "SE_M2"),
             leftlabs = c("Paper", "SMR", "log(SMR)", "SE"))
            
forest_group3

# Thu Apr 24 18:46:53 2025 ------------------------------
#Testing layout change
forest_group3.1 <- meta::forest(pooled_SMR_table_1.4,
             sortvar = SMR_1,  #Sorting by SMR
             comb.random = TRUE,#Use random effects model
             comb.common = FALSE,
             prediction = TRUE,
             print.tau2 = FALSE,
             leftcols = c("Paper", "SMR_1", "SE_M2"),
             leftlabs = c("Paper", "SMR", "SE"))
#Trying a slightly different function
forest_group3.2 <- forest(pooled_SMR_table_1.4,
       sortvar = SMR_1,  #Sorting by SMR
       layout = "JAMA",
       overall = TRUE,
       comb.random = TRUE,#Use random effects model
       comb.common = FALSE,
       print.random = TRUE, #Display pooled random effect
       print.common = FALSE,
       prediction = TRUE,
       print.tau2 = FALSE,
       leftcols = c("Paper_names", "SMR_1", "SE_M2"),
       leftlabs = c("Paper", "SMR", "SE"))

# Fri Apr 25 09:29:00 2025 ------------------------------
load(file = "SMR_MA_obj")
#Trouble shooting 
print(pooled_SMR_table_1.4)
meta::forest(pooled_SMR_table_1.4, layout = "JAMA") #Observing minimal layout
par(mar = c(7,4,4,2)+0.1) #Increasing horizontal plot margins
pooled_SMR_table_1.4$TE.random
pooled_SMR_table_1.4$seTE.random
pooled_SMR_table_1.4$lower.random
pooled_SMR_table_1.4$upper.random
pooled_SMR_table_1.4$pred.lower.random
pooled_SMR_table_1.4$pred.upper.random

#Changing elements of this code
forest_group3 <- meta::forest(pooled_SMR_table_1.4,
                              sortvar = log_SMR_1,  #Sorting by SMR
                              layout = "meta",
                              comb.random = TRUE,#Use random effects model
                              comb.common = FALSE,
                              overall = TRUE,
                              print.random = TRUE,
                              print.common = FALSE,
                              prediction = TRUE,
                              print.tau2 = FALSE,
                              leftcols = c("Paper_names", "SMR_1", "log_SMR_1", 
                                           "SE_M2"),
                              leftlabs = c("Paper", "SMR", "log(SMR)", "SE"),
                              showweights = TRUE)

