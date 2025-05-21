# Sat Apr 26 14:01:01 2025 ------------------------------
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
SMR_table_M.1
#Relevant meta-analysis 
pooled_SMR_M <- metagen(TE = logSMR_1,
                        seTE = SE_M2, 
                        studlab = Paper,
                        data = SMR_table_M.1,
                        sm = "RR",
                        common = FALSE,
                        random = TRUE,
                        method.tau = "REML",
                        method.random.ci = "HK")
pooled_SMR_M #Viewing pooled results
#Creating forest plot
forest_M <- forest(pooled_SMR_M,
                    sortvar = logSMR_1, 
                    comb.random = TRUE,#Use random effects mode
                    comb.common = FALSE,
                    print.random = TRUE,
                    print.common = FALSE,
                    prediction = FALSE,
                    print.tau2 = FALSE,
                    leftcols = c("paper_names", "Obs",
                                 "Exp"),
                    leftlabs = c("Paper","Observed deaths",
                                 "Expected deaths"),
                    rightlabs = c("SMR", "95% CI", "Weight"))

#New formatting (no p value and determining column gaps)
forest_M.1 <- forest(pooled_SMR_M,
                          sortvar = logSMR_1,
                          comb.random = TRUE,#Use random effects mode
                          comb.common = FALSE,
                          print.random = TRUE,
                          print.common = FALSE,
                          prediction = FALSE,
                          print.tau2 = FALSE,
                          leftcols = c("paper_names", "Obs",
                                       "Exp"),
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
png('forest_M.1.png', width = 900, height = 400)
dev.off()
