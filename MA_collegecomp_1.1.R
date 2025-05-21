# Wed Apr 23 13:55:25 2025 ------------------------------
#Pooling SMRs using a)Random effects model, b) SE_M2
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
#Viewing results of pooled SMR data from SMR_table_1.4
pooled_SMR_table_1.4
save.image(file = "SMR_MA_obj")
#Pooling SMRs using a) Random effects model, b) SE_M2 for group 4
pooled_SMR_table_g4 <- metagen(TE = log_SMR_1,
                                seTE = SE_M2, 
                                studlab = Paper,
                                data = SMR_group4_table,
                                sm = "RR",
                                common = TRUE,
                                random = TRUE,
                                method.tau = "REML",
                                method.random.ci = "HK")
#Viewing results of pooled SMR data from pooled_SMR_table_g4
pooled_SMR_table_g4

#Pooling SMRs for just Surface Workers using a) Random effect model, b) SE_M2
pooled_SMR_SW <- metagen(TE = logSMR_1,
                               seTE = SE_M2, 
                               studlab = Paper,
                               data = SMR_table_SW.1,
                               sm = "RR",
                               common = TRUE,
                               random = TRUE,
                               method.tau = "REML",
                               method.random.ci = "HK")
pooled_SMR_SW 

#Pooling SMRs for miners using a) Random effect model, b) SE_M2
pooled_SMR_M <- metagen(TE = logSMR_1,
                         seTE = SE_M2, 
                         studlab = Paper,
                         data = SMR_table_M.1,
                         sm = "RR",
                         common = TRUE,
                         random = TRUE,
                         method.tau = "REML",
                         method.random.ci = "HK")
pooled_SMR_M

#Exporting all MA code
save(pooled_SMR_M, file = "pooled_SMR_M.RData")
save(pooled_SMR_SW, file = "pooled_SMR_SW.RData")
save(pooled_SMR_table_g4, file = "pooled_SMR_group4.RData")
save(pooled_SMR_table_1.4, file = "pooled_SMR_group3.RData")
