# Fri Apr 25 12:38:32 2025 ------------------------------
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
SMR_table_1.4 #Relevant table
#Relevant meta-analysis 
pooled_SMR_table_1.4 <- metagen(TE = log_SMR_1,
                                seTE = SE_M2, 
                                lower = log_CI_L,
                                upper = log_CI_U,
                                studlab = Paper,
                                data = SMR_table_1.4,
                                sm = "RR",
                                common = FALSE,
                                random = TRUE,
                                prediction = TRUE,
                                method.tau = "REML",
                                method.random.ci = "HK")
pooled_SMR_table_1.4
#Forest plot of group 3 (basic layout)
forest_group3 <- forest(pooled_SMR_table_1.4,
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
                        rightlabs = c("SMR", "95% CI", "Weight"))

#New formatting (no p value and determining column gaps)
forest_group3.1 <- forest(pooled_SMR_table_1.4,
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
png('forest_3.5.png', width = 900, height = 400)
dev.off()
#Creating funnel plot to observe publication bias
funnel_group3 <- funnel(pooled_SMR_table_1.4,
            studlab = FALSE)
pooled_SMR_table_1.4$studlab <- paper_names
#Exporting funnel plot
png('funnel_group3.png', width = 900, height = 400)
dev.off() 
