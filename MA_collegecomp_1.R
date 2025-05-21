# Wed Apr 23 13:07:49 2025 ------------------------------
#Loading relevant packages
library(styler)
library(meta)
library(metafor)
library(readxl)
library(writexl)
library(tidyverse)
#Loading updated SMR data table
SMR_table_10 <- read.table(file="SMR_table_9.txt",
                           header=TRUE, sep="\t")
#Viewing table
SMR_table_10
#Deleting Mari06, Fink87_M, Merl95 (group4)
SMR_table_1.1 <- SMR_table_10[!(SMR_table_10$Paper %in% 
                                  c("Fink87_M", "Mari06", "Merl95")), ]
#Viewing new table
SMR_table_1.1
glimpse(SMR_table_1.1)

#Saving objects 
save.image(file = "SMR_MA_obj")

#Loading table with alternate SE values
SMR_table_1.3<- read.table(file= "SMR_tab_1.32.txt",
                            header= TRUE, sep="\t") 
SMR_table_1.3 #Viewing table
glimpse(SMR_table_1.3)

#Deleting Mari06, Fink87_M, Merl95 (group4)
SMR_table_1.4 <- SMR_table_1.3[!(SMR_table_10$Paper %in% 
                                  c("Fink87_M", "Mari06", "Merl95")), ]
SMR_table_1.4
#This previous table was wrong (had not completed SE method)
SMR_table_1.3 <- read.table(file="SMR_table_1.4.txt",
                            header=TRUE, sep="\t")
SMR_table_1.3
glimpse(SMR_table_1.3)
#Deleting Mari06, Fink87_M, Merl95 (group4)
SMR_table_1.4 <- SMR_table_1.3[!(SMR_table_1.3$Paper %in% 
                                  c("Fink87_M", "Mari06", "Merl95")), ]
SMR_table_1.4

#Editing table 1.3 to work out pooled SMR for group 4 (Finkelstein etc.)
SMR_table_1.3
SMR_table_1.5 <- SMR_table_1.3[(SMR_table_10$Paper %in% 
                                   c("Fink87_M", "Mari06", "Merl95")), ]
SMR_table_1.5 #Viewing new table for group 4
SMR_group4_table <- SMR_table_1.5 #New name 
SMR_group4_table

#Loading new table of SW SMRs only
SMR_table_SW <- read.table(file = "SMR_SW.txt",
                           header=TRUE, sep="\t")
glimpse(SMR_table_SW)
SMR_table_SW$Obs <- as.double(SMR_table_SW$Obs) #Changing data type
SMR_table_SW
SMR_table_SW.1 <- SMR_table_SW[-c(7:12), ] #Deleting extra rows
SMR_table_SW.1

#Loading new table of miners' SMRs only
SMR_table_M <- read.table(file = "SMR_miners.txt",
                           header=TRUE, sep="\t")
glimpse(SMR_table_M)
SMR_table_M$Obs <- as.double(SMR_table_M$Obs) #Changing data type
SMR_table_M
SMR_table_M.1 <- SMR_table_M[-c(5:8), ] #Deleting extra rows
SMR_table_M.1

# Fri Apr 25 09:32:52 2025 ------------------------------

#Changing names of paper for presentation
paper_names <- c("Chen 2012", "Cocco 1994", "Hoshuyama 2006",
                 "McDonald 2001", "Ogawa 2003", "Roscoe 1995",
                 "Steenland 1995", "Vacek 2010", "Wyndham 1986",
                 "Zhang 2008")
#Adding column to table
SMR_table_1.4$Paper_names <- paper_names
pooled_SMR_table_1.4$Paper_names <- paper_names
SMR_table_1.4

# Sat Apr 26 12:32:18 2025 ------------------------------
#Changed McDonald observed deaths + CIs, changed Fink CIs
SMR_table_1.4 #Observing group3 table
SMR_table_1.4[6,4] <- 4.6 #Amending mistake
write.table(SMR_table_1.4, file = "Table 1.4.csv",
            sep = ",")
SMR_table_1.4[4,6] <- 0.187847049 #McDonald new log lower interval
SMR_table_1.4[4,7] <- 1.895120646 #mcDonald new log upper interval
SMR_table_1.4[4,9] <- 8 #Mc01 new observed deaths
SMR_table_1.4[4,10] <- 2.828427125 #Mc01 SE_M2_intm
SMR_table_1.4[4,11] <-0.353553391 #SE_M2
SMR_table_1.4[4,3] <- 1.206648943
SMR_table_1.4[4,4] <- 6.653351057

#Editing group 4 (Finkelstein)
SMR_group4_table
SMR_group4_table[1,6] <- 4.15618816 #Fink new log_CI_L
SMR_group4_table[1,7] <- 4.490569813 #Fink new log_CI_U
SMR_group4_table[1,3] <- 63.8277571 #Fink new LCI
SMR_group4_table[1,4] <- 89.1722429 #Fink new UCI

#Checking Miners table
SMR_table_M.1

#Editing SW table with McDonald information
SMR_table_SW.1
SMR_table_SW.1[3,5] <- 1.206648943
SMR_table_SW.1[3,6] <- 6.653351057
SMR_table_SW.1[3,8] <- 0.187847049
SMR_table_SW.1[3,9] <- 1.895120646

#Adding column for expected deaths for group 3
Expected_deaths <- c("", 11.5, 163,2,2.878,4.6,10.23,6.8,2.6,60.3)
SMR_table_1.4$Expected_deaths <- Expected_deaths                   
SMR_table_1.4

#Adding columns for expected deaths and paper names for group 4
Expected_deathsg4 <- c(1.83, 17.76, 1.25)
SMR_group4_table$Expected_deaths <- Expected_deathsg4
Paper_names_g4 <- c("Finkelstein 1986", "Marinaccio 2006", "Merlo 1995")
SMR_group4_table$Paper_names <- Paper_names_g4

#Adding column for paper names for SW group
paper_names_SW <- c("Cocco 1994", "Hoshuyama 2006", "McDonald 2001",
                    "Ogawa 2003", "Vacek 2010", "Zhang 2008")
SMR_table_SW.1$paper_names_SW <- paper_names_SW
SMR_table_SW.1

#Adding column for paper names for miners group
paper_names_M <- c("Cocco 1994", "Roscoe 1995", "Steenland 1995",
                   "Wyndham 1986")
SMR_table_M.1$paper_names <- paper_names_M
SMR_table_M.1

#Adding missing expected values to M and SW tables 
cocco_exp <- 11.5
steen_exp <- 10.23
hosh_exp <- 163
SMR_table_M.1[1,3] <- cocco_exp
SMR_table_M.1[3,3] <- steen_exp
SMR_table_SW.1[1,3] <- cocco_exp
SMR_table_SW.1
SMR_table_SW.1[2,3] <- hosh_exp


