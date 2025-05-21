# Sat Apr 26 13:59:11 2025 ------------------------------
#Packages needed to load:
library(meta)
library(metafor)
library(readxl)
library(writexl)
library(tidyverse)
library(metadat)
library(Matrix)
library(numDeriv)
#Loading objects
load(file = "SMR_MA_obj")
save.image(file = "SMR_MA_obj")
#Relevant table
SMR_group4_table
#Relevant meta-analysis 
pooled_SMR_table_g4 <- metagen(TE = log_SMR_1,
                               seTE = SE_M2, 
                               studlab = Paper,
                               data = SMR_group4_table,
                               sm = "RR",
                               common = FALSE,
                               random = TRUE,
                               method.tau = "REML",
                               method.random.ci = "HK")
pooled_SMR_table_g4 #view pooled result
#Forest plot of group 4 (basic layout)
forest_group4 <- forest(pooled_SMR_table_g4,
                        sortvar = log_SMR_1, 
                        comb.random = TRUE,#Use random effects mode
                        comb.common = FALSE,
                        print.random = TRUE,
                        print.common = FALSE,
                        prediction = TRUE,
                        print.tau2 = FALSE,
                        leftcols = c("Paper_names", "No..deaths",
                                     "Expected_deaths"),
                        leftlabs = c("Paper","Observed deaths",
                                     "Expected deaths"),
                        rightlabs = c("SMR", "95% CI", "Weight"))

#New formatting (no p value and determining column gaps)
forest_group4.1 <- forest(pooled_SMR_table_g4,
                          sortvar = log_SMR_1,
                          comb.random = TRUE,#Use random effects mode
                          comb.common = FALSE,
                          print.random = TRUE,
                          print.common = FALSE,
                          prediction = FALSE,
                          print.tau2 = FALSE,
                          leftcols = c("Paper_names", "No..deaths",
                                       "Expected_deaths"),
                          leftlabs = c("Paper","Observed deaths",
                                       "Expected deaths"),
                          rightlabs = c("SMR", "95% CI", "Weight"),
                          colgap.forest = unit(6, "mm"), 
                          overall = TRUE,
                          overall.hetstat = TRUE,
                          print.I2 = TRUE,       
                          print.I2.ci = FALSE,    
                          print.Q = FALSE,         
                          print.pval.Q = FALSE)

#Exporting PNG image
png('forest_4.1.png', width = 900, height = 400)
dev.off()
