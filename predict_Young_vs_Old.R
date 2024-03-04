
#train the system on young  (Y) and old/aged (A) and then evaluate 

#age groups:
#21-30: 458 
#31-40: 85 
#41-50: 119 
#51-60: 119 
#61-70: 67 
#(71+ : 39)
#71-80: 31 
#81+ : 8 

#labels are 1 = Young or  -1/0 =  Aged
#Monte Carlo (MC) analysis 

set.seed(123)

rm(list = ls())     #to do a clear in r

library(tools)
library(e1071)
library(kernlab)
library(R.matlab)
library(matrixcalc)

printf <- function(...) invisible(print(sprintf(...)))

############################### Read in the data and set up the aggregate "x" matrix and the label-vector "y" (begin) ##############################

my_condition = 1   #test Y (21to30) vs. O (71plus)
#my_condition = 2   #test Y (31to40) vs. O (71plus)
#my_condition = 3   #test Y (41to50) vs. O (71plus)
#my_condition = 4   #test Y (51to60) vs. O (71plus)
#my_condition = 5   #test Y (61to70) vs. O (71plus)

#my_condition = 6   #test Y (21to30) vs. O (31to40)
#my_condition = 7   #test Y (21to30) vs. O (41to50)
#my_condition = 8   #test Y (21to30) vs. O (51to60)
#my_condition = 9   #test Y (21to30) vs. O (61to70)

#my_condition = 10   #test Y (31to40) vs. O (41to50)
#my_condition = 11   #test Y (31to40) vs. O (51to60)
#my_condition = 12   #test Y (31to40) vs. O (61to70)

#my_condition = 13   #test Y (41to50) vs. O (51to60)
#my_condition = 14   #test Y (41to50) vs. O (61to70)

#my_condition = 15   #test Y (51to60) vs. O (61to70)


Num_ROI = 42

shuffle = 0      #default is 0, make this 1 if you want to shuffle the ROIs

#num_feat=294   #i.e. 42 * 7  all features
#num_feat=210   #i.e. 42 * 5  stat features
num_feat=84    #i.e. 42 * 2  deviation-based features 

#num_feat=861   #i.e. ((42 ^2) - 42)/2  CC features
correlation_mode = 1    #1: PCC,   2: Reyni with quantiz bins being number of timepoints,  3: Reyni with quantiz bins via FD


if(my_condition == 1){
num_Young_total = 458
num_Aged_total = 39

if(num_feat == 294){
Name_file1 = read.csv("Your_Path/Name_age_test_SVM_MCLOO_21to30_71plus_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:296,2:459]          #this is the full set of features
Name_data1_Aged = Name_file1[3:296,460:(460+39-1)]  #this is the full set of features
}

if(num_feat == 210){
Name_file1 = read.csv("Your_Path/Name_age_test_SVM_MCLOO_21to30_71plus_StatFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:212,2:459]          #stat features
Name_data1_Aged = Name_file1[3:212,460:(460+39-1)]  #stat features
}

if(num_feat == 84){
Name_file1 = read.csv("Your_Path/Name_age_test_SVM_MCLOO_21to30_71plus_DevFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:86,2:459]          #deviation-based features
Name_data1_Aged = Name_file1[3:86,460:(460+39-1)]  #deviation-based features
}

if(num_feat == 861){
if(correlation_mode == 1){
Name_file1 = read.csv("Your_Path/Name_age_test_SVM_MCLOO_21to30_71plus_CCFeats_test1_NoLabels.csv") 
Name_data1_Young = Name_file1[1:861,1:458]          # CC features
Name_data1_Aged = Name_file1[1:861,459:(459+39-1)]      # CC features
}
if(correlation_mode == 2){
Name_file1 = read.csv("Your_Path/mutual_info_anlaysis_1/hold_channel_pair_mutual_info_quantized_via_num_bins_timePoints_vectorized_version/RenyiCC_quantized_via_num_bins_timePoints_vectorized_21to30_71plus_NoLabels.csv") 
Name_data1_Young = Name_file1[1:861,1:458]          # CC features
Name_data1_Aged = Name_file1[1:861,459:(459+39-1)]      # CC features
}
if(correlation_mode == 3){
Name_file1 = read.csv("Your_Path/mutual_info_anlaysis_1/hold_channel_pair_mutual_info_quantized_via_num_bins_FD_vectorized_version/RenyiCC_quantized_via_num_bins_FD_vectorized_21to30_71plus_NoLabels.csv") 
Name_data1_Young = Name_file1[1:861,1:458]          # CC features
Name_data1_Aged = Name_file1[1:861,459:(459+39-1)]      # CC features
}
}
}

if(my_condition == 2){
num_Young_total = 85
num_Aged_total = 39

if(num_feat == 294){
Name_file1 = read.csv("Your_Path/Name_age_test_SVM_MCLOO_31to40_71plus_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:296,2:(num_Young_total + 1)]          #this is the full set of features
Name_data1_Aged = Name_file1[3:296,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #this is the full set of features
}

if(num_feat == 210){
Name_file1 = read.csv("Your_Path/Name_age_test_SVM_MCLOO_31to40_71plus_StatFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:212,2:(num_Young_total + 1)]          #stat features
Name_data1_Aged = Name_file1[3:212,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #stat features
}

if(num_feat == 84){
Name_file1 = read.csv("Your_Path/Name_age_test_SVM_MCLOO_31to40_71plus_DevFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:86,2:(num_Young_total + 1)]          #deviation-based features
Name_data1_Aged = Name_file1[3:86,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #deviation-based features
}

if(num_feat == 861){
Name_file1 = read.csv("Your_Path/Name_age_test_SVM_MCLOO_31to40_71plus_CCFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[1:861,1:(num_Young_total)]          #deviation-based features
Name_data1_Aged = Name_file1[1:861,(num_Young_total + 1):(num_Young_total + num_Aged_total)]  #deviation-based features
}
}

if(my_condition == 3){
num_Young_total = 119
num_Aged_total = 39

if(num_feat == 294){
Name_file1 = read.csv("Your_Path/Name_age_test_SVM_MCLOO_41to50_71plus_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:296,2:(num_Young_total + 1)]          #this is the full set of features
Name_data1_Aged = Name_file1[3:296,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #this is the full set of features
}

if(num_feat == 210){
Name_file1 = read.csv("Your_Path/Name_age_test_SVM_MCLOO_41to50_71plus_StatFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:212,2:(num_Young_total + 1)]          #stat features
Name_data1_Aged = Name_file1[3:212,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #stat features
}

if(num_feat == 84){
Name_file1 = read.csv("Your_Path/Name_age_test_SVM_MCLOO_41to50_71plus_DevFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:86,2:(num_Young_total + 1)]          #deviation-based features
Name_data1_Aged = Name_file1[3:86,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #deviation-based features
}

if(num_feat == 861){
Name_file1 = read.csv("Your_Path/Name_age_test_SVM_MCLOO_41to50_71plus_CCFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[1:861, 1:(num_Young_total)]          #deviation-based features
Name_data1_Aged = Name_file1[1:861, (num_Young_total + 1):(num_Young_total + num_Aged_total)]  #deviation-based features
}
}

if(my_condition == 4){
num_Young_total = 119
num_Aged_total = 39

if(num_feat == 294){
Name_file1 = read.csv("Your_Path/Name_age_test_SVM_MCLOO_51to60_71plus_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:296,2:(num_Young_total + 1)]          #this is the full set of features
Name_data1_Aged = Name_file1[3:296,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #this is the full set of features
}

if(num_feat == 210){
Name_file1 = read.csv("Your_Path/Name_age_test_SVM_MCLOO_51to60_71plus_StatFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:212,2:(num_Young_total + 1)]          #stat features
Name_data1_Aged = Name_file1[3:212,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #stat features
}

if(num_feat == 84){
Name_file1 = read.csv("Your_Path/Name_age_test_SVM_MCLOO_51to60_71plus_DevFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:86,2:(num_Young_total + 1)]          #deviation-based features
Name_data1_Aged = Name_file1[3:86,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #deviation-based features
}

if(num_feat == 861){
Name_file1 = read.csv("Your_Path/Name_age_test_SVM_MCLOO_51to60_71plus_CCFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[1:861,1:(num_Young_total)]          #deviation-based features
Name_data1_Aged = Name_file1[1:861,(num_Young_total + 1):(num_Young_total + num_Aged_total)]  #deviation-based features
}
}

if(my_condition == 5){
num_Young_total = 67
num_Aged_total = 39

if(num_feat == 294){
Name_file1 = read.csv("Your_Path/Name_age_test_SVM_MCLOO_61to70_71plus_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:296,2:(num_Young_total + 1)]          #this is the full set of features
Name_data1_Aged = Name_file1[3:296,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #this is the full set of features
}

if(num_feat == 210){
Name_file1 = read.csv("Your_Path/Name_age_test_SVM_MCLOO_61to70_71plus_StatFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:212,2:(num_Young_total + 1)]          #stat features
Name_data1_Aged = Name_file1[3:212,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #stat features
}

if(num_feat == 84){
Name_file1 = read.csv("Your_Path/Name_age_test_SVM_MCLOO_61to70_71plus_DevFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:86,2:(num_Young_total + 1)]          #deviation-based features
Name_data1_Aged = Name_file1[3:86,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #deviation-based features
}

if(num_feat == 861){
if(correlation_mode == 1){
Name_file1 = read.csv("Your_Path/Name_age_test_SVM_MCLOO_61to70_71plus_CCFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[1:861,1:(num_Young_total)]          #deviation-based features
Name_data1_Aged = Name_file1[1:861,(num_Young_total + 1):(num_Young_total + num_Aged_total)]  #deviation-based features
}
if(correlation_mode == 2){
Name_file1 = read.csv("Your_Path/mutual_info_anlaysis_1/hold_channel_pair_mutual_info_quantized_via_num_bins_timePoints_vectorized_version/RenyiCC_quantized_via_num_bins_timePoints_vectorized_61to70_71plus_NoLabels.csv") 
Name_data1_Young = Name_file1[1:861,1:(num_Young_total)]          
Name_data1_Aged = Name_file1[1:861,(num_Young_total + 1):(num_Young_total + num_Aged_total)]  
}
if(correlation_mode == 3){
Name_file1 = read.csv("Your_Path/mutual_info_anlaysis_1/hold_channel_pair_mutual_info_quantized_via_num_bins_FD_vectorized_version/RenyiCC_quantized_via_num_bins_FD_vectorized_61to70_71plus_NoLabels.csv") 
Name_data1_Young = Name_file1[1:861,1:(num_Young_total)]          
Name_data1_Aged = Name_file1[1:861,(num_Young_total + 1):(num_Young_total + num_Aged_total)]  
}
}
}


#Youns is (21-30: 458) and Aged is (31-40: 85)
if(my_condition == 6){
num_Young_total = 458
num_Aged_total = 85

if(num_feat == 294){
Name_file1 = read.csv("Your_Path/Name_age_test_SVM_MCLOO_21to30_31to40_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:296,2:(num_Young_total + 1)]        #this is the full set of features
Name_data1_Aged = Name_file1[3:296,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #this is the full set of features
}

if(num_feat == 210){
Name_file1 = read.csv("Your_Path/Name_age_test_SVM_MCLOO_21to30_31to40_StatFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:212,2:(num_Young_total + 1)]          #stat features
Name_data1_Aged = Name_file1[3:212,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #stat features
}

if(num_feat == 84){
Name_file1 = read.csv("Your_Path/Name_age_test_SVM_MCLOO_21to30_31to40_DevFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:86,2:(num_Young_total + 1)]          #deviation-based features
Name_data1_Aged = Name_file1[3:86,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #deviation-based features
}

if(num_feat == 861){
Name_file1 = read.csv("Your_Path/Name_age_test_SVM_MCLOO_21to30_31to40_CCFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[1:861,1:(num_Young_total)]          #deviation-based features
Name_data1_Aged = Name_file1[1:861,(num_Young_total + 1):(num_Young_total + num_Aged_total)]  #deviation-based features
}
}


#Youns is (21-30: 458) and Aged is (41-50: 119) 
if(my_condition == 7){
num_Young_total = 458
num_Aged_total = 119

if(num_feat == 294){
Name_file1 = read.csv("Your_Path/Name_age_test_SVM_MCLOO_21to30_41to50_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:296,2:(num_Young_total + 1)]        #this is the full set of features
Name_data1_Aged = Name_file1[3:296,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #this is the full set of features
}

if(num_feat == 210){
Name_file1 = read.csv("Your_Path/Name_age_test_SVM_MCLOO_21to30_41to50_StatFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:212,2:(num_Young_total + 1)]          #stat features
Name_data1_Aged = Name_file1[3:212,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #stat features
}

if(num_feat == 84){
Name_file1 = read.csv("Your_Path/Name_age_test_SVM_MCLOO_21to30_41to50_DevFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:86,2:(num_Young_total + 1)]          #deviation-based features
Name_data1_Aged = Name_file1[3:86,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #deviation-based features
}

if(num_feat == 861){
Name_file1 = read.csv("Your_Path/Name_age_test_SVM_MCLOO_21to30_41to50_CCFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[1:861,1:(num_Young_total)]          #deviation-based features
Name_data1_Aged = Name_file1[1:861,(num_Young_total + 1):(num_Young_total + num_Aged_total)]  #deviation-based features
}
}

#Youns is (21-30: 458) and Aged is (51-60: 119) 
if(my_condition == 8){
num_Young_total = 458
num_Aged_total = 119

if(num_feat == 294){
Name_file1 = read.csv("Your_Path/Name_age_test_SVM_MCLOO_21to30_51to60_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:296,2:(num_Young_total + 1)]        #this is the full set of features
Name_data1_Aged = Name_file1[3:296,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #this is the full set of features
}

if(num_feat == 210){
Name_file1 = read.csv("Your_Path/Name_age_test_SVM_MCLOO_21to30_51to60_StatFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:212,2:(num_Young_total + 1)]          #stat features
Name_data1_Aged = Name_file1[3:212,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #stat features
}

if(num_feat == 84){
Name_file1 = read.csv("Your_Path/Name_age_test_SVM_MCLOO_21to30_51to60_DevFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:86,2:(num_Young_total + 1)]          #deviation-based features
Name_data1_Aged = Name_file1[3:86,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #deviation-based features
}

if(num_feat == 861){
Name_file1 = read.csv("Your_Path/Name_age_test_SVM_MCLOO_21to30_51to60_CCFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[1:861,1:(num_Young_total)]          #deviation-based features
Name_data1_Aged = Name_file1[1:861,(num_Young_total + 1):(num_Young_total + num_Aged_total)]  #deviation-based features
}
}

#Young is (21-30: 458) and Aged is (61-70: 67) 
if(my_condition == 9){
num_Young_total = 458
num_Aged_total = 67

if(num_feat == 294){
Name_file1 = read.csv("Your_Path/Name_age_test_SVM_MCLOO_21to30_61to70_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:296,2:(num_Young_total + 1)]        #this is the full set of features
Name_data1_Aged = Name_file1[3:296,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #this is the full set of features
}

if(num_feat == 210){
Name_file1 = read.csv("Your_Path/Name_age_test_SVM_MCLOO_21to30_61to70_StatFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:212,2:(num_Young_total + 1)]          #stat features
Name_data1_Aged = Name_file1[3:212,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #stat features
}

if(num_feat == 84){
Name_file1 = read.csv("Your_Path/Name_age_test_SVM_MCLOO_21to30_61to70_DevFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:86,2:(num_Young_total + 1)]          #deviation-based features
Name_data1_Aged = Name_file1[3:86,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #deviation-based features
}

if(num_feat == 861){
Name_file1 = read.csv("Your_Path/Name_age_test_SVM_MCLOO_21to30_61to70_CCFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[1:861,1:(num_Young_total)]          #deviation-based features
Name_data1_Aged = Name_file1[1:861,(num_Young_total + 1):(num_Young_total + num_Aged_total)]   #deviation-based features
}
}

#Young is (31-40: 85) and Aged is (41-50: 119) 
if(my_condition == 10){
num_Young_total = 85
num_Aged_total = 119

if(num_feat == 294){
Name_file1 = read.csv("Your_Path/Name_age_test_SVM_MCLOO_31to40_41to50_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:296,2:(num_Young_total + 1)]        #this is the full set of features
Name_data1_Aged = Name_file1[3:296,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #this is the full set of features
}

if(num_feat == 210){
Name_file1 = read.csv("Your_Path/Name_age_test_SVM_MCLOO_31to40_41to50_StatFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:212,2:(num_Young_total + 1)]          #stat features
Name_data1_Aged = Name_file1[3:212,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #stat features
}

if(num_feat == 84){
Name_file1 = read.csv("Your_Path/Name_age_test_SVM_MCLOO_31to40_41to50_DevFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:86,2:(num_Young_total + 1)]          #deviation-based features
Name_data1_Aged = Name_file1[3:86,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #deviation-based features
}

if(num_feat == 861){
Name_file1 = read.csv("Your_Path/Name_age_test_SVM_MCLOO_31to40_41to50_CCFeats_test1_NoLabels.csv")  
Name_data1_Young = Name_file1[1:861,1:(num_Young_total)]          #deviation-based features
Name_data1_Aged = Name_file1[1:861,(num_Young_total + 1):(num_Young_total + num_Aged_total)]  #deviation-based features
}
}


#Young is (31-40: 85) and Aged is (51-60: 119) 
if(my_condition == 11){
num_Young_total = 85
num_Aged_total = 119

if(num_feat == 294){
Name_file1 = read.csv("Your_Path/Name_age_test_SVM_MCLOO_31to40_51to60_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:296,2:(num_Young_total + 1)]        #this is the full set of features
Name_data1_Aged = Name_file1[3:296,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #this is the full set of features
}

if(num_feat == 210){
Name_file1 = read.csv("Your_Path/Name_age_test_SVM_MCLOO_31to40_51to60_StatFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:212,2:(num_Young_total + 1)]          #stat features
Name_data1_Aged = Name_file1[3:212,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #stat features
}

if(num_feat == 84){
Name_file1 = read.csv("Your_Path/Name_age_test_SVM_MCLOO_31to40_51to60_DevFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:86,2:(num_Young_total + 1)]          #deviation-based features
Name_data1_Aged = Name_file1[3:86,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #deviation-based features
}

if(num_feat == 861){
Name_file1 = read.csv("Your_Path/Name_age_test_SVM_MCLOO_31to40_51to60_CCFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[1:861,1:(num_Young_total)]          #deviation-based features
Name_data1_Aged = Name_file1[1:861,(num_Young_total + 1):(num_Young_total + num_Aged_total)]  #deviation-based features
}
}


#Young is (31-40: 85) and Aged is (61-70: 67) 
if(my_condition == 12){
num_Young_total = 85
num_Aged_total = 67

if(num_feat == 294){
Name_file1 = read.csv("Your_Path/Name_age_test_SVM_MCLOO_31to40_61to70_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:296,2:(num_Young_total + 1)]        #this is the full set of features
Name_data1_Aged = Name_file1[3:296,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #this is the full set of features
}

if(num_feat == 210){
Name_file1 = read.csv("Your_Path/Name_age_test_SVM_MCLOO_31to40_61to70_StatFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:212,2:(num_Young_total + 1)]          #stat features
Name_data1_Aged = Name_file1[3:212,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #stat features
}

if(num_feat == 84){
Name_file1 = read.csv("Your_Path/Name_age_test_SVM_MCLOO_31to40_61to70_DevFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:86,2:(num_Young_total + 1)]          #deviation-based features
Name_data1_Aged = Name_file1[3:86,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #deviation-based features
}

if(num_feat == 861){
if(correlation_mode == 1){
Name_file1 = read.csv("Your_Path/Name_age_test_SVM_MCLOO_31to40_61to70_CCFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[1:861,1:(num_Young_total)]          
Name_data1_Aged = Name_file1[1:861,(num_Young_total + 1):(num_Young_total + num_Aged_total)] 
}

if(correlation_mode == 2){
Name_file1 = read.csv("Your_Path/mutual_info_anlaysis_1/hold_channel_pair_mutual_info_quantized_via_num_bins_timePoints_vectorized_version/RenyiCC_quantized_via_num_bins_timePoints_vectorized_31to40_61to70_NoLabels.csv") 
Name_data1_Young = Name_file1[1:861,1:(num_Young_total)]          
Name_data1_Aged = Name_file1[1:861,(num_Young_total + 1):(num_Young_total + num_Aged_total)] 
}

if(correlation_mode == 3){
Name_file1 = read.csv("Your_Path/mutual_info_anlaysis_1/hold_channel_pair_mutual_info_quantized_via_num_bins_FD_vectorized_version/RenyiCC_quantized_via_num_bins_FD_vectorized_31to40_61to70_NoLabels.csv") 
Name_data1_Young = Name_file1[1:861,1:(num_Young_total)]          
Name_data1_Aged = Name_file1[1:861,(num_Young_total + 1):(num_Young_total + num_Aged_total)] 
}
}
}

#Young is (41-50: 119) and Aged is (51-60: 119) 
if(my_condition == 13){
num_Young_total = 119
num_Aged_total = 119

if(num_feat == 294){
Name_file1 = read.csv("Your_Path/Name_age_test_SVM_MCLOO_41to50_51to60_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:296,2:(num_Young_total + 1)]        #this is the full set of features
Name_data1_Aged = Name_file1[3:296,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #this is the full set of features
}

if(num_feat == 210){
Name_file1 = read.csv("Your_Path/Name_age_test_SVM_MCLOO_41to50_51to60_StatFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:212,2:(num_Young_total + 1)]          #stat features
Name_data1_Aged = Name_file1[3:212,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #stat features
}

if(num_feat == 84){
Name_file1 = read.csv("Your_Path/Name_age_test_SVM_MCLOO_41to50_51to60_DevFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:86,2:(num_Young_total + 1)]          #deviation-based features
Name_data1_Aged = Name_file1[3:86,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #deviation-based features
}

if(num_feat == 861){
Name_file1 = read.csv("Your_Path/Name_age_test_SVM_MCLOO_41to50_51to60_CCFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[1:861,1:(num_Young_total)]          #deviation-based features
Name_data1_Aged = Name_file1[1:861,(num_Young_total + 1):(num_Young_total + num_Aged_total)]  #deviation-based features
}
}


#Young is (41-50: 119) and Aged is (61-70: 67) 
if(my_condition == 14){
num_Young_total = 119
num_Aged_total = 67

if(num_feat == 294){
Name_file1 = read.csv("Your_Path/Name_age_test_SVM_MCLOO_41to50_61to70_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:296,2:(num_Young_total + 1)]        #this is the full set of features
Name_data1_Aged = Name_file1[3:296,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #this is the full set of features
}

if(num_feat == 210){
Name_file1 = read.csv("Your_Path/Name_age_test_SVM_MCLOO_41to50_61to70_StatFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:212,2:(num_Young_total + 1)]          #stat features
Name_data1_Aged = Name_file1[3:212,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #stat features
}

if(num_feat == 84){
Name_file1 = read.csv("Your_Path/Name_age_test_SVM_MCLOO_41to50_61to70_DevFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:86,2:(num_Young_total + 1)]          #deviation-based features
Name_data1_Aged = Name_file1[3:86,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #deviation-based features
}

if(num_feat == 861){
Name_file1 = read.csv("Your_Path/Name_age_test_SVM_MCLOO_41to50_61to70_CCFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[1:861,1:(num_Young_total)]          #deviation-based features
Name_data1_Aged = Name_file1[1:861,(num_Young_total + 1):(num_Young_total + num_Aged_total)]  #deviation-based features
}
}


#Young is (51-60: 119) and Aged is (61-70: 67) 
if(my_condition == 15){
num_Young_total = 119
num_Aged_total = 67

if(num_feat == 294){
Name_file1 = read.csv("Your_Path/Name_age_test_SVM_MCLOO_51to60_61to70_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:296,2:(num_Young_total + 1)]        #this is the full set of features
Name_data1_Aged = Name_file1[3:296,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #this is the full set of features
}

if(num_feat == 210){
Name_file1 = read.csv("Your_Path/Name_age_test_SVM_MCLOO_51to60_61to70_StatFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:212,2:(num_Young_total + 1)]          #stat features
Name_data1_Aged = Name_file1[3:212,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #stat features
}

if(num_feat == 84){
Name_file1 = read.csv("Your_Path/Name_age_test_SVM_MCLOO_51to60_61to70_DevFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:86,2:(num_Young_total + 1)]          #deviation-based features
Name_data1_Aged = Name_file1[3:86,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #deviation-based features
}

if(num_feat == 861){
Name_file1 = read.csv("Your_Path/Name_age_test_SVM_MCLOO_51to60_61to70_CCFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[1:861,1:(num_Young_total)]          #deviation-based features
Name_data1_Aged = Name_file1[1:861,(num_Young_total + 1):(num_Young_total + num_Aged_total)]  #deviation-based features
}
}


#Young is (21-25: 340) and Aged is (26-30: 118)  
if(my_condition == 16){
num_Young_total = 340
num_Aged_total = 118

if(num_feat == 294){
Name_file1 = read.csv("Your_Path/Name_age_test_SVM_MCLOO_21to25_26to30_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:296,2:(num_Young_total + 1)]        #this is the full set of features
Name_data1_Aged = Name_file1[3:296,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #this is the full set of features
}

if(num_feat == 210){
Name_file1 = read.csv("Your_Path/Name_age_test_SVM_MCLOO_21to25_26to30_StatFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:212,2:(num_Young_total + 1)]          #stat features
Name_data1_Aged = Name_file1[3:212,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #stat features
}

if(num_feat == 84){
Name_file1 = read.csv("Your_Path/Name_age_test_SVM_MCLOO_21to25_26to30_DevFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:86,2:(num_Young_total + 1)]          #deviation-based features
Name_data1_Aged = Name_file1[3:86,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #deviation-based features
}

if(num_feat == 861){
Name_file1 = read.csv("Your_Path/Name_age_test_SVM_MCLOO_21to25_26to30_CCFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[1:861,1:(num_Young_total)]          #deviation-based features
Name_data1_Aged = Name_file1[1:861,(num_Young_total + 1):(num_Young_total + num_Aged_total)]  #deviation-based features
}
}


#Young is (31-35: 50) and Aged is (36-40: 35)
if(my_condition == 17){
num_Young_total = 50
num_Aged_total = 35

if(num_feat == 294){
Name_file1 = read.csv("Your_Path/Name_age_test_SVM_MCLOO_31to35_36to40_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:296,2:(num_Young_total + 1)]        #this is the full set of features
Name_data1_Aged = Name_file1[3:296,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #this is the full set of features
}

if(num_feat == 210){
Name_file1 = read.csv("Your_Path/Name_age_test_SVM_MCLOO_31to35_36to40_StatFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:212,2:(num_Young_total + 1)]          #stat features
Name_data1_Aged = Name_file1[3:212,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #stat features
}

if(num_feat == 84){
Name_file1 = read.csv("Your_Path/Name_age_test_SVM_MCLOO_31to35_36to40_DevFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:86,2:(num_Young_total + 1)]          #deviation-based features
Name_data1_Aged = Name_file1[3:86,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #deviation-based features
}

if(num_feat == 861){
Name_file1 = read.csv("Your_Path/Name_age_test_SVM_MCLOO_31to35_36to40_CCFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[1:861,1:(num_Young_total)]          #deviation-based features
Name_data1_Aged = Name_file1[1:861,(num_Young_total + 1):(num_Young_total + num_Aged_total)]  #deviation-based features
}
}


#Young is (61-65: 40) and Aged is (66-70: 27)
if(my_condition == 18){
num_Young_total = 40
num_Aged_total = 27

if(num_feat == 294){
Name_file1 = read.csv("Your_Path/Name_age_test_SVM_MCLOO_61to65_66to70_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:296,2:(num_Young_total + 1)]        #this is the full set of features
Name_data1_Aged = Name_file1[3:296,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #this is the full set of features
}

if(num_feat == 210){
Name_file1 = read.csv("Your_Path/Name_age_test_SVM_MCLOO_61to65_66to70_StatFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:212,2:(num_Young_total + 1)]          #stat features
Name_data1_Aged = Name_file1[3:212,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #stat features
}

if(num_feat == 84){
Name_file1 = read.csv("Your_Path/Name_age_test_SVM_MCLOO_61to65_66to70_DevFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:86,2:(num_Young_total + 1)]          #deviation-based features
Name_data1_Aged = Name_file1[3:86,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #deviation-based features
}

if(num_feat == 861){
Name_file1 = read.csv("Your_Path/Name_age_test_SVM_MCLOO_61to65_66to70_CCFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[1:861,1:(num_Young_total)]          
Name_data1_Aged = Name_file1[1:861,(num_Young_total + 1):(num_Young_total + num_Aged_total)]  
}
}


Name_data1_YoungAged = cbind(Name_data1_Young, Name_data1_Aged)
num_subj = dim(Name_data1_YoungAged)[2]

Name_data1_YoungAged_2 <- matrix(0, dim(Name_data1_YoungAged)[1], dim(Name_data1_YoungAged)[2])


################# shuffling portion (begin) #################
if(shuffle == 1){

subj_idx1 = 1

while(subj_idx1 <= num_subj)
{

shuffle_indices1 = sample.int(Num_ROI, Num_ROI)  # generate rand vector of integers from 1 to Num_ROI.

#cat("shuffle_indices1=")
#cat(shuffle_indices1)
#cat("\n")

shuffle_idx1 = 1
range3 = 1
range4 = (num_feat/Num_ROI)

while(shuffle_idx1 <= Num_ROI)
{
range1 = ((shuffle_indices1[shuffle_idx1])*((num_feat/Num_ROI))) + 1 - (num_feat/Num_ROI)
range2 = range1 + (num_feat/Num_ROI) - 1 
temp_ROI_of_subj = Name_data1_YoungAged[range1:range2, subj_idx1]

Name_data1_YoungAged_2[range3:range4, subj_idx1] = temp_ROI_of_subj

range3 = range3 + (num_feat/Num_ROI)
range4 = range3 + (num_feat/Num_ROI) - 1

shuffle_idx1 = shuffle_idx1 + 1
}

subj_idx1 = subj_idx1 + 1

}  #end of while loop from 1 to num_subj

} #end of if-condition for shuffle


if(shuffle == 0){
Name_data1_YoungAged_2 = Name_data1_YoungAged
}
################# shuffling portion (end) ################# 

num_for_test = (min(num_Aged_total, num_Young_total) - 1) * 2

y_label = c(rep(1, num_for_test/2), rep(-1, num_for_test/2))

# label = "1" means young
# label = "0/-1" means old

total_loop1 = 1000
#total_loop1 = 100
#total_loop1 = 10
#total_loop1 = 1

idx_of_loop = 1
correct_Aged = 0
correct_Young = 0


while(idx_of_loop <= total_loop1){       # outer-most while-loop for leave-one-out analysis

Young_indices = sample.int(num_Young_total, num_Young_total)
Aged_indices = num_Young_total + sample.int(num_Aged_total, num_Aged_total)

train_indices = c(Young_indices[1:(min(num_Aged_total, num_Young_total) - 1)], Aged_indices[1: (min(num_Aged_total, num_Young_total) - 1)])

test_Young_idx = Young_indices[min(num_Aged_total, num_Young_total)]
test_Aged_idx = Aged_indices[min(num_Aged_total, num_Young_total)]

k2=1 

# make a matrix of zeros just to initiate "xmat1" for the training data
x_train_mat1 <- matrix(0, num_feat, length(train_indices))

while(k2 <= length(train_indices)){
k3=1
  while(k3 <= num_feat){
  x_train_mat1[k3, k2] = Name_data1_YoungAged_2[k3, (train_indices[k2])]
   k3 = k3 + 1
  }
 k2 = k2 + 1
}

######### Set up the training and test matrices for both the data and the labels (begin) #########

xtest_Young <- Name_data1_YoungAged_2[,test_Young_idx]
xtest_Aged <- Name_data1_YoungAged_2[,test_Aged_idx]

ylabel_Young = 1
ylabel_Aged = -1

######### Set up the training and test matrices for both the data and the labels (end) #########

############# Train the SVM with the training data ############# 

svp <- ksvm(t(x_train_mat1), y_label, type="C-svc", kernel='vanilladot', C=60, scaled=c())     #linear kernel

############# Predict labels on test data ############# 

class(xtest_Young) <- "numeric"      # convert the guy who is not "atomic" into "atomic" via this command
class(xtest_Aged) <- "numeric"      # convert the guy who is not "atomic" into "atomic" via this command

ypred_Young = predict(svp, t(xtest_Young))

ypred_Aged = predict(svp, t(xtest_Aged))


if(ypred_Young == ylabel_Young){ 
correct_Young = correct_Young + 1  }

if(ypred_Aged == ylabel_Aged){ 
correct_Aged = correct_Aged + 1  }

printf("idx_of_loop =%f", idx_of_loop) 
printf("test_Young_idx=%f  test_Aged_idx=%f", test_Young_idx, test_Aged_idx)
printf("ypred_Young=%f  ypred_Aged=%f", ypred_Young, ypred_Aged)
printf("correct_Young=%f  correct_Aged=%f", correct_Young, correct_Aged)
cat("\n")

rm(ypred_Young, svp, ypred_Aged, xtest_Young, xtest_Aged, x_train_mat1)   # remove these vars form memory so you can set it anew for the next subject

idx_of_loop = idx_of_loop + 1
 
}        # outer-most while-loop 

printf("my_condition=%d", my_condition)
printf("num_feat=%d", num_feat)
printf("num_subj=%d   num_for_test=%d", num_subj, num_for_test)
printf("num_Young_total=%d   num_Aged_total=%d", num_Young_total, num_Aged_total)
