# Tue May 20 12:08:42 2025 ------------------------------
#Loading relevant packages
library(styler)
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
#Uploading middle income table
middle_income <- read.table(file="middle_income.csv",
                           header=TRUE, sep=",")
middle_income #Observing table
str(middle_income)
#Adding log column 
middle_income$log_SMR <- log(middle_income$SMR)
#Adding SE column
SE_middle_income <- c(0.082, 0.0653, NA, 0.5)
middle_income$SE <- SE_middle_income
#Adding log CI for Chen 2012
SE_log_LCI <- c(NA, NA, 1.5412, NA)
middle_income$logLCI <- SE_log_LCI
SE_log_UCI <- c(NA, NA, 1.6273, NA)
middle_income$logUCI <- SE_log_UCI

#Completing meta-analysis
pooled_middle_income <- metagen(TE = log_SMR,
                                seTE = SE, 
                                lower = logLCI,
                                upper = logUCI,
                                studlab = Paper,
                                data = middle_income,
                                sm = "RR",
                                common = FALSE,
                                random = TRUE,
                                prediction = TRUE,
                                method.tau = "REML",
                                method.random.ci = "HK")
pooled_middle_income

#High income (repeat process)
high_income <- read.table(file="high_income.csv",
                            header=TRUE, sep=",")
str(high_income)
high_income
#Adding log column 
high_income$log_SMR <- log(high_income$SMR)
#Adding SE column
SE_high_income <- c(0.1622, 0.1667, 0.2887, 0.3536, 0.3162, 0.0825)
high_income$SE <- SE_high_income
#Meta-analysis
pooled_high_income <- metagen(TE = log_SMR,
                                seTE = SE, 
                                studlab = Paper,
                                data = high_income,
                                sm = "RR",
                                common = FALSE,
                                random = TRUE,
                                prediction = TRUE,
                                method.tau = "REML",
                                method.random.ci = "HK")
pooled_high_income
