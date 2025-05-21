# Thu May  1 10:45:03 2025 ------------------------------
#Packages needed to load:
library(meta)
library(metafor)
library(readxl)
library(writexl)
library(tidyverse)
library(metadat)
library(Matrix)
library(numDeriv)
install.packages("gridExtra")
library(gridExtra)
install.packages("ggrepel")
library(ggrepel)
library(ggplot2)
#Loading objects
load(file = "SMR_MA_obj")
save.image(file = "SMR_MA_obj")
#Easy access to meta-analyses
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
pooled_SMR_table_1.4 #Group 3

pooled_SMR_table_g4 <- metagen(TE = log_SMR_1,
                               seTE = SE_M2, 
                               studlab = Paper,
                               data = SMR_group4_table,
                               sm = "RR",
                               common = FALSE,
                               random = TRUE,
                               method.tau = "REML",
                               method.random.ci = "HK")
pooled_SMR_table_g4 #Group 4

pooled_SMR_SW <- metagen(TE = logSMR_1,
                         seTE = SE_M2, 
                         studlab = Paper,
                         data = SMR_table_SW.1,
                         sm = "RR",
                         common = FALSE,
                         random = TRUE,
                         method.tau = "REML",
                         method.random.ci = "HK")
pooled_SMR_SW #Surface workers

pooled_SMR_M <- metagen(TE = logSMR_1,
                        seTE = SE_M2, 
                        studlab = Paper,
                        data = SMR_table_M.1,
                        sm = "RR",
                        common = FALSE,
                        random = TRUE,
                        method.tau = "REML",
                        method.random.ci = "HK")
pooled_SMR_M #Miners

#Re-calculating group 3 MA without outliers
find.outliers(pooled_SMR_table_1.4)
#Re-calculating group 4 MA without outliers
find.outliers(pooled_SMR_table_g4)
#Re-calculating SW without outliers 
find.outliers(pooled_SMR_SW)
#Re-calculating M without outliers 
find.outliers(pooled_SMR_M)

#Influence analysis on group 3
group_3_inf <- InfluenceAnalysis(pooled_SMR_table_1.4, 
                                 random = TRUE)
#Baujat plot for group 3 (using different method)
baujat(pooled_SMR_table_1.4)
plot(group_3_inf, "baujat")

#Baujat plot for group 3 using dmetar
names(group_3_inf)
names(group_3_inf$BaujatPlot)
#Column names:
if ("data" %in% names(group_3_inf$BaujatPlot)) {
  if (is.data.frame(group_3_inf$BaujatPlot$data)) {
    print(colnames(group_3_inf$BaujatPlot$data))
  } else if (is.list(group_3_inf$BaujatPlot$data) && length(group_3_inf$BaujatPlot$data) > 0 && is.data.frame(group_3_inf$BaujatPlot$data[[1]])) {
    print(colnames(group_3_inf$BaujatPlot$data[[1]])) # If data is a list of data frames
  } else {
    cat("The 'data' component is not a data frame or a list of data frames.\n")
  }
} else {
  cat("The 'BaujatPlot' object does not have a 'data' component.\n")
}
output_str <- capture.output(str(group_3_inf$BaujatPlot))
head(output_str, n = 30) # Show the first 30 lines of the structure
sum(is.na(group_3_inf$BaujatPlot$data$x))
sum(is.na(group_3_inf$BaujatPlot$data$y))
baujat_data <- group_3_inf$BaujatPlot$data

#Re-rum following to get dmetar plot
plot(baujat_data$x, baujat_data$y,
     xlab = "Contribution to Heterogeneity (x)",
     ylab = "Influence (y)",
     main = "Baujat Plot (Manual)") 
print(group_3_inf$BaujatPlot)

library(ggplot2)
baujat_plot <- group_3_inf$BaujatPlot

#Creating PDF of group 3 Baujat plot
png('baujat_3.2.png', width = 900, height = 400)
print(baujat_plot)
dev.off()
