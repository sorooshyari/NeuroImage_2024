
#per-brain network analysis
#in order to only use a group of specific ROI at a time - that correspond to one of 7 networks - to predict into Y vs. O groups. 
#covers: combined, stat, deviation-based (aka paroxysmal) features

#age groups:
#group 1 - 21-30: 458 
#group 2 - 31-40: 85 
#group 3 - 41-50: 119 
#group 4 - 51-60: 119 
#group 5 - 61-70: 67 
#group 6 - (71+ : 39)
#group 7 - 71-80: 31 
#group 8 - 81+ : 8 


#train the system on young  and old and then evaluate : 
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


num_feat=7   #i.e. 42 * 7  all features
#num_feat=5   #i.e. 42 * 5  stat features
#num_feat=2    #i.e. 42 * 2  deviation-based features


network_mode = 7           #set network via this variable


if(network_mode == 1)           #for DMN
{
feat_start_idx = 1  
feat_end_idx = num_feat * 7
}

if(network_mode == 2)             #for SN
{
feat_start_idx = num_feat * 7 + 1 
feat_end_idx = num_feat * 13
}

if(network_mode == 3)            #for DAN
{
feat_start_idx = num_feat * 13 + 1  
feat_end_idx = num_feat * 20
}

if(network_mode == 4)              #for FPCN
{
feat_start_idx = num_feat * 20 + 1 
feat_end_idx = num_feat * 27
}

if(network_mode == 5)                #for AN
{
feat_start_idx = num_feat * 27 + 1 
feat_end_idx = num_feat * 33
}

if(network_mode == 6)                   #for VN
{
feat_start_idx = num_feat * 33 + 1 
feat_end_idx = num_feat * 37
}

if(network_mode == 7)                 #for MN
{
feat_start_idx = num_feat * 37 + 1 
feat_end_idx = num_feat * 42
}


shuffle = 0


if(my_condition == 1){
num_Young_total = 458
num_Aged_total = 39

if(num_feat == 7){
Name_file1 = read.csv("Your_PATH/Name_age_test_SVM_MCLOO_21to30_71plus_test1_NoLabels.csv")
Name_data1_Young = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), 2:459]          #this is the full set of features
Name_data1_Aged = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), 460:(460+39-1)]  #this is the full set of features
}

if(num_feat == 5){
Name_file1 = read.csv("Your_PATH/Name_age_test_SVM_MCLOO_21to30_71plus_StatFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), 2:459]            #stat features
Name_data1_Aged = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), 460:(460+39-1)]  #stat features
}

if(num_feat == 2){
Name_file1 = read.csv("Your_PATH/Name_age_test_SVM_MCLOO_21to30_71plus_DevFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), 2:459]             #deviation-based features
Name_data1_Aged = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), 460:(460+39-1)]  #deviation-based features
}

if(num_feat == 861){
Name_file1 = read.csv("Your_PATH/.csv") 
Name_data1_Young = Name_file1[1:861,1:458]          # CC features
Name_data1_Aged = Name_file1[1:861,459:(459+39-1)]      # CC features
}
}

if(my_condition == 2){
num_Young_total = 85
num_Aged_total = 39

if(num_feat == 7){
Name_file1 = read.csv("Your_PATH/Name_age_test_SVM_MCLOO_31to40_71plus_test1_NoLabels.csv")
Name_data1_Young = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), 2:(num_Young_total + 1)]          #this is the full set of features
Name_data1_Aged = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), (num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #this is the full set of features
}

if(num_feat == 5){
Name_file1 = read.csv("Your_PATH/Name_age_test_SVM_MCLOO_31to40_71plus_StatFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), 2:(num_Young_total + 1)]          #stat features
Name_data1_Aged = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), (num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #stat features
}

if(num_feat == 2){
Name_file1 = read.csv("Your_PATH/Name_age_test_SVM_MCLOO_31to40_71plus_DevFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), 2:(num_Young_total + 1)]          #deviation-based features
Name_data1_Aged = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), (num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #deviation-based features
}

if(num_feat == 861){
Name_file1 = read.csv("Your_PATH/Name_age_test_SVM_MCLOO_31to40_71plus_CCFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[1:861,1:(num_Young_total)]          #deviation-based features
Name_data1_Aged = Name_file1[1:861,(num_Young_total + 1):(num_Young_total + num_Aged_total)]  #deviation-based features
}
}

if(my_condition == 3){
num_Young_total = 119
num_Aged_total = 39

if(num_feat == 7){
Name_file1 = read.csv("Your_PATH/Name_age_test_SVM_MCLOO_41to50_71plus_test1_NoLabels.csv")
Name_data1_Young = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), 2:(num_Young_total + 1)]          #this is the full set of features
Name_data1_Aged = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), (num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #this is the full set of features
}

if(num_feat == 5){
Name_file1 = read.csv("Your_PATH/Name_age_test_SVM_MCLOO_41to50_71plus_StatFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), 2:(num_Young_total + 1)]          #stat features
Name_data1_Aged = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), (num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #stat features
}

if(num_feat == 2){
Name_file1 = read.csv("Your_PATH/Name_age_test_SVM_MCLOO_41to50_71plus_DevFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), 2:(num_Young_total + 1)]          #deviation-based features
Name_data1_Aged = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), (num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #deviation-based features
}

if(num_feat == 861){
Name_file1 = read.csv("Your_PATH/Name_age_test_SVM_MCLOO_41to50_71plus_CCFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[1:861, 1:(num_Young_total)]          #deviation-based features
Name_data1_Aged = Name_file1[1:861, (num_Young_total + 1):(num_Young_total + num_Aged_total)]  #deviation-based features
}
}

if(my_condition == 4){
num_Young_total = 119
num_Aged_total = 39

if(num_feat == 7){
Name_file1 = read.csv("Your_PATH/Name_age_test_SVM_MCLOO_51to60_71plus_test1_NoLabels.csv")
Name_data1_Young = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), 2:(num_Young_total + 1)]          #this is the full set of features
Name_data1_Aged = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), (num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #this is the full set of features
}

if(num_feat == 5){
Name_file1 = read.csv("Your_PATH/Name_age_test_SVM_MCLOO_51to60_71plus_StatFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), 2:(num_Young_total + 1)]          #stat features
Name_data1_Aged = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), (num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #stat features
}

if(num_feat == 2){
Name_file1 = read.csv("Your_PATH/Name_age_test_SVM_MCLOO_51to60_71plus_DevFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), 2:(num_Young_total + 1)]          #deviation-based features
Name_data1_Aged = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), (num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #deviation-based features
}

if(num_feat == 861){
Name_file1 = read.csv("Your_PATH/Name_age_test_SVM_MCLOO_51to60_71plus_CCFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[1:861,1:(num_Young_total)]          #deviation-based features
Name_data1_Aged = Name_file1[1:861,(num_Young_total + 1):(num_Young_total + num_Aged_total)]  #deviation-based features
}
}


if(my_condition == 5){
num_Young_total = 67
num_Aged_total = 39

if(num_feat == 7){
Name_file1 = read.csv("Your_PATH/Name_age_test_SVM_MCLOO_61to70_71plus_test1_NoLabels.csv")
Name_data1_Young = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), 2:(num_Young_total + 1)]          #this is the full set of features
Name_data1_Aged = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), (num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #this is the full set of features
}

if(num_feat == 5){
Name_file1 = read.csv("Your_PATH/Name_age_test_SVM_MCLOO_61to70_71plus_StatFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), 2:(num_Young_total + 1)]          #stat features
Name_data1_Aged = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), (num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #stat features
}

if(num_feat == 2){
Name_file1 = read.csv("Your_PATH/Name_age_test_SVM_MCLOO_61to70_71plus_DevFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), 2:(num_Young_total + 1)]          #deviation-based features
Name_data1_Aged = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), (num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #deviation-based features
}

if(num_feat == 861){
Name_file1 = read.csv("Your_PATH/Name_age_test_SVM_MCLOO_61to70_71plus_CCFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[1:861,1:(num_Young_total)]          #deviation-based features
Name_data1_Aged = Name_file1[1:861,(num_Young_total + 1):(num_Young_total + num_Aged_total)]  #deviation-based features
}
}


#Young is (21-30: 458) and Aged is (31-40: 85)
if(my_condition == 6){
num_Young_total = 458
num_Aged_total = 85

if(num_feat == 7){
Name_file1 = read.csv("Your_PATH/Name_age_test_SVM_MCLOO_21to30_31to40_test1_NoLabels.csv")
Name_data1_Young = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), 2:(num_Young_total + 1)]        #this is the full set of features
Name_data1_Aged = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), (num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #this is the full set of features
}

if(num_feat == 5){
Name_file1 = read.csv("Your_PATH/Name_age_test_SVM_MCLOO_21to30_31to40_StatFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), 2:(num_Young_total + 1)]          #stat features
Name_data1_Aged = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), (num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #stat features
}

if(num_feat == 2){
Name_file1 = read.csv("Your_PATH/Name_age_test_SVM_MCLOO_21to30_31to40_DevFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), 2:(num_Young_total + 1)]          #deviation-based features
Name_data1_Aged = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), (num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #deviation-based features
}

if(num_feat == 861){
Name_file1 = read.csv("Your_PATH/Name_age_test_SVM_MCLOO_21to30_31to40_CCFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[1:861,1:(num_Young_total)]          #deviation-based features
Name_data1_Aged = Name_file1[1:861,(num_Young_total + 1):(num_Young_total + num_Aged_total)]  #deviation-based features
}
}


#Youns is (21-30: 458) and Aged is (41-50: 119) 
if(my_condition == 7){
num_Young_total = 458
num_Aged_total = 119

if(num_feat == 7){
Name_file1 = read.csv("Your_PATH/Name_age_test_SVM_MCLOO_21to30_41to50_test1_NoLabels.csv")
Name_data1_Young = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), 2:(num_Young_total + 1)]        #this is the full set of features
Name_data1_Aged = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), (num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #this is the full set of features
}

if(num_feat == 5){
Name_file1 = read.csv("Your_PATH/Name_age_test_SVM_MCLOO_21to30_41to50_StatFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), 2:(num_Young_total + 1)]          #stat features
Name_data1_Aged = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), (num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #stat features
}

if(num_feat == 2){
Name_file1 = read.csv("Your_PATH/Name_age_test_SVM_MCLOO_21to30_41to50_DevFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), 2:(num_Young_total + 1)]          #deviation-based features
Name_data1_Aged = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), (num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #deviation-based features
}

if(num_feat == 861){
Name_file1 = read.csv("Your_PATH/Name_age_test_SVM_MCLOO_21to30_41to50_CCFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[1:861,1:(num_Young_total)]          #deviation-based features
Name_data1_Aged = Name_file1[1:861,(num_Young_total + 1):(num_Young_total + num_Aged_total)]  #deviation-based features
}
}

#Youns is (21-30: 458) and Aged is (51-60: 119) 
if(my_condition == 8){
num_Young_total = 458
num_Aged_total = 119

if(num_feat == 7){
Name_file1 = read.csv("Your_PATH/Name_age_test_SVM_MCLOO_21to30_51to60_test1_NoLabels.csv")
Name_data1_Young = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), 2:(num_Young_total + 1)]        #this is the full set of features
Name_data1_Aged = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), (num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #this is the full set of features
}

if(num_feat == 5){
Name_file1 = read.csv("Your_PATH/Name_age_test_SVM_MCLOO_21to30_51to60_StatFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), 2:(num_Young_total + 1)]          #stat features
Name_data1_Aged = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), (num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #stat features
}

if(num_feat == 2){
Name_file1 = read.csv("Your_PATH/Name_age_test_SVM_MCLOO_21to30_51to60_DevFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), 2:(num_Young_total + 1)]          #deviation-based features
Name_data1_Aged = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), (num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #deviation-based features
}

if(num_feat == 861){
Name_file1 = read.csv("Your_PATH/Name_age_test_SVM_MCLOO_21to30_51to60_CCFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[1:861,1:(num_Young_total)]          #deviation-based features
Name_data1_Aged = Name_file1[1:861,(num_Young_total + 1):(num_Young_total + num_Aged_total)]  #deviation-based features
}
}


#Young is (21-30: 458) and Aged is (61-70: 67) 
if(my_condition == 9){
num_Young_total = 458
num_Aged_total = 67

if(num_feat == 7){
Name_file1 = read.csv("Your_PATH/Name_age_test_SVM_MCLOO_21to30_61to70_test1_NoLabels.csv")
Name_data1_Young = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), 2:(num_Young_total + 1)]        #this is the full set of features
Name_data1_Aged = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), (num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #this is the full set of features
}

if(num_feat == 5){
Name_file1 = read.csv("Your_PATH/Name_age_test_SVM_MCLOO_21to30_61to70_StatFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), 2:(num_Young_total + 1)]          #stat features
Name_data1_Aged = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), (num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #stat features
}

if(num_feat == 2){
Name_file1 = read.csv("Your_PATH/Name_age_test_SVM_MCLOO_21to30_61to70_DevFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), 2:(num_Young_total + 1)]          #deviation-based features
Name_data1_Aged = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), (num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #deviation-based features
}

if(num_feat == 861){
Name_file1 = read.csv("Your_PATH/Name_age_test_SVM_MCLOO_21to30_61to70_CCFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[1:861,1:(num_Young_total)]          #deviation-based features
Name_data1_Aged = Name_file1[1:861,(num_Young_total + 1):(num_Young_total + num_Aged_total)]   #deviation-based features
}
}


#Young is (31-40: 85) and Aged is (41-50: 119) 
if(my_condition == 10){
num_Young_total = 85
num_Aged_total = 119

if(num_feat == 7){
Name_file1 = read.csv("Your_PATH/Name_age_test_SVM_MCLOO_31to40_41to50_test1_NoLabels.csv")
Name_data1_Young = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), 2:(num_Young_total + 1)]        #this is the full set of features
Name_data1_Aged = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), (num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #this is the full set of features
}

if(num_feat == 5){
Name_file1 = read.csv("Your_PATH/Name_age_test_SVM_MCLOO_31to40_41to50_StatFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), 2:(num_Young_total + 1)]          #stat features
Name_data1_Aged = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), (num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #stat features
}

if(num_feat == 2){
Name_file1 = read.csv("Your_PATH/Name_age_test_SVM_MCLOO_31to40_41to50_DevFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), 2:(num_Young_total + 1)]          #deviation-based features
Name_data1_Aged = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), (num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #deviation-based features
}

if(num_feat == 861){
Name_file1 = read.csv("Your_PATH/Name_age_test_SVM_MCLOO_31to40_41to50_CCFeats_test1_NoLabels.csv")  
Name_data1_Young = Name_file1[1:861,1:(num_Young_total)]          #deviation-based features
Name_data1_Aged = Name_file1[1:861,(num_Young_total + 1):(num_Young_total + num_Aged_total)]  #deviation-based features
}
}


#Young is (31-40: 85) and Aged is (51-60: 119) 
if(my_condition == 11){
num_Young_total = 85
num_Aged_total = 119

if(num_feat == 7){
Name_file1 = read.csv("Your_PATH/Name_age_test_SVM_MCLOO_31to40_51to60_test1_NoLabels.csv")
Name_data1_Young = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), 2:(num_Young_total + 1)]        #this is the full set of features
Name_data1_Aged = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), (num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #this is the full set of features
}

if(num_feat == 5){
Name_file1 = read.csv("Your_PATH/Name_age_test_SVM_MCLOO_31to40_51to60_StatFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), 2:(num_Young_total + 1)]          #stat features
Name_data1_Aged = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), (num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #stat features
}

if(num_feat == 2){
Name_file1 = read.csv("Your_PATH/Name_age_test_SVM_MCLOO_31to40_51to60_DevFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), 2:(num_Young_total + 1)]          #deviation-based features
Name_data1_Aged = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), (num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #deviation-based features
}

if(num_feat == 861){
Name_file1 = read.csv("Your_PATH/Name_age_test_SVM_MCLOO_31to40_51to60_CCFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[1:861,1:(num_Young_total)]          #deviation-based features
Name_data1_Aged = Name_file1[1:861,(num_Young_total + 1):(num_Young_total + num_Aged_total)]  #deviation-based features
}
}


#Young is (31-40: 85) and Aged is (61-70: 67) 
if(my_condition == 12){
num_Young_total = 85
num_Aged_total = 67

if(num_feat == 7){
Name_file1 = read.csv("Your_PATH/Name_age_test_SVM_MCLOO_31to40_61to70_test1_NoLabels.csv")
Name_data1_Young = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), 2:(num_Young_total + 1)]        #this is the full set of features
Name_data1_Aged = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), (num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #this is the full set of features
}

if(num_feat == 5){
Name_file1 = read.csv("Your_PATH/Name_age_test_SVM_MCLOO_31to40_61to70_StatFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), 2:(num_Young_total + 1)]          #stat features
Name_data1_Aged = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), (num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #stat features
}

if(num_feat == 2){
Name_file1 = read.csv("Your_PATH/Name_age_test_SVM_MCLOO_31to40_61to70_DevFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), 2:(num_Young_total + 1)]          #deviation-based features
Name_data1_Aged = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), (num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #deviation-based features
}

if(num_feat == 861){
Name_file1 = read.csv("Your_PATH/Name_age_test_SVM_MCLOO_31to40_61to70_CCFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[1:861,1:(num_Young_total)]          #deviation-based features
Name_data1_Aged = Name_file1[1:861,(num_Young_total + 1):(num_Young_total + num_Aged_total)]  #deviation-based features
}
}


#Young is (41-50: 119) and Aged is (51-60: 119) 
if(my_condition == 13){
num_Young_total = 119
num_Aged_total = 119

if(num_feat == 7){
Name_file1 = read.csv("Your_PATH/Name_age_test_SVM_MCLOO_41to50_51to60_test1_NoLabels.csv")
Name_data1_Young = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), 2:(num_Young_total + 1)]        #this is the full set of features
Name_data1_Aged = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), (num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #this is the full set of features
}

if(num_feat == 5){
Name_file1 = read.csv("Your_PATH/Name_age_test_SVM_MCLOO_41to50_51to60_StatFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), 2:(num_Young_total + 1)]          #stat features
Name_data1_Aged = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), (num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #stat features
}

if(num_feat == 2){
Name_file1 = read.csv("Your_PATH/Name_age_test_SVM_MCLOO_41to50_51to60_DevFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), 2:(num_Young_total + 1)]          #deviation-based features
Name_data1_Aged = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), (num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #deviation-based features
}

if(num_feat == 861){
Name_file1 = read.csv("Your_PATH/Name_age_test_SVM_MCLOO_41to50_51to60_CCFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[1:861,1:(num_Young_total)]          #deviation-based features
Name_data1_Aged = Name_file1[1:861,(num_Young_total + 1):(num_Young_total + num_Aged_total)]  #deviation-based features
}
}


#Young is (41-50: 119) and Aged is (61-70: 67) 
if(my_condition == 14){
num_Young_total = 119
num_Aged_total = 67

if(num_feat == 7){
Name_file1 = read.csv("Your_PATH/Name_age_test_SVM_MCLOO_41to50_61to70_test1_NoLabels.csv")
Name_data1_Young = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), 2:(num_Young_total + 1)]        #this is the full set of features
Name_data1_Aged = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), (num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #this is the full set of features
}

if(num_feat == 5){
Name_file1 = read.csv("Your_PATH/Name_age_test_SVM_MCLOO_41to50_61to70_StatFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), 2:(num_Young_total + 1)]          #stat features
Name_data1_Aged = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), (num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #stat features
}

if(num_feat == 2){
Name_file1 = read.csv("Your_PATH/Name_age_test_SVM_MCLOO_41to50_61to70_DevFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), 2:(num_Young_total + 1)]          #deviation-based features
Name_data1_Aged = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), (num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #deviation-based features
}

if(num_feat == 861){
Name_file1 = read.csv("Your_PATH/Name_age_test_SVM_MCLOO_41to50_61to70_CCFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[1:861,1:(num_Young_total)]          #deviation-based features
Name_data1_Aged = Name_file1[1:861,(num_Young_total + 1):(num_Young_total + num_Aged_total)]  #deviation-based features
}
}


#Young is (51-60: 119) and Aged is (61-70: 67) 
if(my_condition == 15){
num_Young_total = 119
num_Aged_total = 67

if(num_feat == 7){
Name_file1 = read.csv("Your_PATH/Name_age_test_SVM_MCLOO_51to60_61to70_test1_NoLabels.csv")
Name_data1_Young = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), 2:(num_Young_total + 1)]        #this is the full set of features
Name_data1_Aged = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), (num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #this is the full set of features
}

if(num_feat == 5){
Name_file1 = read.csv("Your_PATH/Name_age_test_SVM_MCLOO_51to60_61to70_StatFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), 2:(num_Young_total + 1)]          #stat features
Name_data1_Aged = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), (num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #stat features
}

if(num_feat == 2){
Name_file1 = read.csv("Your_PATH/Name_age_test_SVM_MCLOO_51to60_61to70_DevFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), 2:(num_Young_total + 1)]          #deviation-based features
Name_data1_Aged = Name_file1[(2 + feat_start_idx):(2 + feat_end_idx), (num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #deviation-based features
}

if(num_feat == 861){
Name_file1 = read.csv("Your_PATH/Name_age_test_SVM_MCLOO_51to60_61to70_CCFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[1:861,1:(num_Young_total)]          #deviation-based features
Name_data1_Aged = Name_file1[1:861,(num_Young_total + 1):(num_Young_total + num_Aged_total)]  #deviation-based features
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
#printf("subj_idx1=%f", subj_idx1)

shuffle_indices1 = sample.int(Num_ROI, Num_ROI)  # generate rand vector of integers from 1 to Num_ROI.

#cat("shuffle_indices1=")
#cat(shuffle_indices1)
#cat("\n")

shuffle_idx1 = 1
range3 = 1
range4 = (num_feat/Num_ROI)

while(shuffle_idx1 <= Num_ROI)
{
#go through each of the Num_ROI shuffled integers and take t

#temp_matrix = Name_data1_YoungAged2[(shuffle_idx1*((num_feat/Num_ROI)+1)):((shuffle_idx1)*(num_feat/Num_ROI)), subj_idx1]

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

# make a vector of zeros just to initiate "y" vector for the labels associated with the training data 
#y <- matrix(0, 1, dim(xmat1)[2])
#I hard-code this right now for the way that I've set it up in the CSV file - this hard-coding will not change for this reason 
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

x_train_mat1 <- matrix(0, feat_end_idx - feat_start_idx +1, length(train_indices))

while(k2 <= length(train_indices)){
k3=1
  while(k3 <= (feat_end_idx - feat_start_idx +1)){
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

printf("network_mode=%d   my_condition=%d", network_mode, my_condition)
printf("num_feat=%d", num_feat)
printf("num_subj=%d   num_for_test=%d", num_subj, num_for_test)
printf("num_Young_total=%d   num_Aged_total=%d", num_Young_total, num_Aged_total)

printf("feat_start_idx=%d",  feat_start_idx)
printf("feat_end_idx=%d",  feat_end_idx)
