
#Train and test the system on young (Y) and old (A) - for test center = NKI-RS  

#age groups:
#21-30: 65
#31-40: 27 
#41-50: 71 
#51-60: 67 
#61-70: 45 
#(71+ : 32)
#71-80:  24
#81+ :  8

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

#my_condition = 16   #test Y (21to25) vs. O (26to30)

#my_condition = 17   #test Y (31to35) vs. O (36to40)

#my_condition = 18   #test Y (61to65) vs. O (66to70)


num_feat=294   #i.e. 42 * 7  all features
#num_feat=210   #i.e. 42 * 5  stat features
#num_feat=84    #i.e. 42 * 2  deviation-based features
#num_feat=861   #i.e. ((42 ^2) - 42)/2  CC features


if(my_condition == 1){
num_Young_total = 65
num_Aged_total = 32

if(num_feat == 294){
Name_file1 = read.csv("Your_Path/study_per_test_center_1/Name_age_test_SVM_MCLOO_NKI_ROCKLAND_21to30_71plus_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:296,2:66]          #this is the full set of features
Name_data1_Aged = Name_file1[3:296,67:(67+32-1)]  #this is the full set of features
}

if(num_feat == 210){
Name_file1 = read.csv("Your_Path/study_per_test_center_1/Name_age_test_SVM_MCLOO_NKI_ROCKLAND_21to30_71plus_StatFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:212,2:66]          #stat features
Name_data1_Aged = Name_file1[3:212,67:(67+32-1)]  #stat features
}

if(num_feat == 84){
Name_file1 = read.csv("Your_Path/study_per_test_center_1/Name_age_test_SVM_MCLOO_NKI_ROCKLAND_21to30_71plus_DevFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:86,2:66]          #deviation-based features
Name_data1_Aged = Name_file1[3:86,67:(67+32-1)]  #deviation-based features
}

if(num_feat == 861){
Name_file1 = read.csv("Your_Path/cross_corr_features_betweenROIs_NKI_Rockland/Name_age_test_SVM_MCLOO_21to30_71plus_CCFeats_test1_NoLabels_NKI_Rockland.csv") 
Name_data1_Young = Name_file1[3:863,2:66]          # CC features
Name_data1_Aged = Name_file1[3:863,67:(67+32-1)]      # CC features
}
}


if(my_condition == 2){
num_Young_total = 27
num_Aged_total = 32

if(num_feat == 294){
Name_file1 = read.csv("Your_Path/study_per_test_center_1/Name_age_test_SVM_MCLOO_NKI_ROCKLAND_31to40_71plus_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:296,2:(num_Young_total + 1)]          #this is the full set of features
Name_data1_Aged = Name_file1[3:296,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #this is the full set of features
}

if(num_feat == 210){
Name_file1 = read.csv("Your_Path/study_per_test_center_1/Name_age_test_SVM_MCLOO_NKI_ROCKLAND_31to40_71plus_StatFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:212,2:(num_Young_total + 1)]          #stat features
Name_data1_Aged = Name_file1[3:212,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #stat features
}

if(num_feat == 84){
Name_file1 = read.csv("Your_Path/study_per_test_center_1/Name_age_test_SVM_MCLOO_NKI_ROCKLAND_31to40_71plus_DevFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:86,2:(num_Young_total + 1)]          #deviation-based features
Name_data1_Aged = Name_file1[3:86,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #deviation-based features
}

if(num_feat == 861){
Name_file1 = read.csv("Your_Path/cross_corr_features_betweenROIs_NKI_Rockland/Name_age_test_SVM_MCLOO_31to40_71plus_CCFeats_test1_NoLabels_NKI_Rockland.csv")
Name_data1_Young = Name_file1[3:863,2:(num_Young_total + 1)]          #CC-based features
Name_data1_Aged = Name_file1[3:863,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]    #CC-based features
}
}

if(my_condition == 3){
num_Young_total = 71
num_Aged_total = 32

if(num_feat == 294){
Name_file1 = read.csv("Your_Path/study_per_test_center_1/Name_age_test_SVM_MCLOO_NKI_ROCKLAND_41to50_71plus_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:296,2:(num_Young_total + 1)]          #this is the full set of features
Name_data1_Aged = Name_file1[3:296,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #this is the full set of features
}

if(num_feat == 210){
Name_file1 = read.csv("Your_Path/study_per_test_center_1/Name_age_test_SVM_MCLOO_NKI_ROCKLAND_41to50_71plus_StatFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:212,2:(num_Young_total + 1)]          #stat features
Name_data1_Aged = Name_file1[3:212,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #stat features
}

if(num_feat == 84){
Name_file1 = read.csv("Your_Path/study_per_test_center_1/Name_age_test_SVM_MCLOO_NKI_ROCKLAND_41to50_71plus_DevFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:86,2:(num_Young_total + 1)]          #deviation-based features
Name_data1_Aged = Name_file1[3:86,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #deviation-based features
}

if(num_feat == 861){
Name_file1 = read.csv("Your_Path/cross_corr_features_betweenROIs_NKI_Rockland/Name_age_test_SVM_MCLOO_41to50_71plus_CCFeats_test1_NoLabels_NKI_Rockland.csv")
Name_data1_Young = Name_file1[3:863,2:(num_Young_total + 1)]          #CC-based features
Name_data1_Aged = Name_file1[3:863,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]    #CC-based features
}
}

if(my_condition == 4){
num_Young_total = 67
num_Aged_total = 32

if(num_feat == 294){
Name_file1 = read.csv("Your_Path/study_per_test_center_1/Name_age_test_SVM_MCLOO_NKI_ROCKLAND_51to60_71plus_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:296,2:(num_Young_total + 1)]          #this is the full set of features
Name_data1_Aged = Name_file1[3:296,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #this is the full set of features
}

if(num_feat == 210){
Name_file1 = read.csv("Your_Path/study_per_test_center_1/Name_age_test_SVM_MCLOO_NKI_ROCKLAND_51to60_71plus_StatFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:212,2:(num_Young_total + 1)]          #stat features
Name_data1_Aged = Name_file1[3:212,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #stat features
}

if(num_feat == 84){
Name_file1 = read.csv("Your_Path/study_per_test_center_1/Name_age_test_SVM_MCLOO_NKI_ROCKLAND_51to60_71plus_DevFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:86,2:(num_Young_total + 1)]          #deviation-based features
Name_data1_Aged = Name_file1[3:86,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #deviation-based features
}

if(num_feat == 861){
Name_file1 = read.csv("Your_Path/cross_corr_features_betweenROIs_NKI_Rockland/Name_age_test_SVM_MCLOO_51to60_71plus_CCFeats_test1_NoLabels_NKI_Rockland.csv")
Name_data1_Young = Name_file1[3:863,2:(num_Young_total + 1)]          #CC-based features
Name_data1_Aged = Name_file1[3:863,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]    #CC-based features
}
}


if(my_condition == 5){
num_Young_total = 45
num_Aged_total = 32

if(num_feat == 294){
Name_file1 = read.csv("Your_Path/study_per_test_center_1/Name_age_test_SVM_MCLOO_NKI_ROCKLAND_61to70_71plus_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:296,2:(num_Young_total + 1)]          #this is the full set of features
Name_data1_Aged = Name_file1[3:296,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #this is the full set of features
}

if(num_feat == 210){
Name_file1 = read.csv("Your_Path/study_per_test_center_1/Name_age_test_SVM_MCLOO_NKI_ROCKLAND_61to70_71plus_StatFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:212,2:(num_Young_total + 1)]          #stat features
Name_data1_Aged = Name_file1[3:212,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #stat features
}

if(num_feat == 84){
Name_file1 = read.csv("Your_Path/study_per_test_center_1/Name_age_test_SVM_MCLOO_NKI_ROCKLAND_61to70_71plus_DevFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:86,2:(num_Young_total + 1)]          #deviation-based features
Name_data1_Aged = Name_file1[3:86,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #deviation-based features
}

if(num_feat == 861){
Name_file1 = read.csv("Your_Path/cross_corr_features_betweenROIs_NKI_Rockland/Name_age_test_SVM_MCLOO_61to70_71plus_CCFeats_test1_NoLabels_NKI_Rockland.csv")
Name_data1_Young = Name_file1[3:863,2:(num_Young_total + 1)]          #CC-based features
Name_data1_Aged = Name_file1[3:863,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]    #CC-based features
}
}


#Youns is (21-30: 65) and Aged is (31-40: 27)
if(my_condition == 6){
num_Young_total = 65
num_Aged_total = 27

if(num_feat == 294){
Name_file1 = read.csv("Your_Path/study_per_test_center_1/Name_age_test_SVM_MCLOO_NKI_ROCKLAND_21to30_31to40_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:296,2:(num_Young_total + 1)]        #this is the full set of features
Name_data1_Aged = Name_file1[3:296,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #this is the full set of features
}

if(num_feat == 210){
Name_file1 = read.csv("Your_Path/study_per_test_center_1/Name_age_test_SVM_MCLOO_NKI_ROCKLAND_21to30_31to40_StatFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:212,2:(num_Young_total + 1)]          #stat features
Name_data1_Aged = Name_file1[3:212,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #stat features
}

if(num_feat == 84){
Name_file1 = read.csv("Your_Path/study_per_test_center_1/Name_age_test_SVM_MCLOO_NKI_ROCKLAND_21to30_31to40_DevFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:86,2:(num_Young_total + 1)]          #deviation-based features
Name_data1_Aged = Name_file1[3:86,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #deviation-based features
}

if(num_feat == 861){
Name_file1 = read.csv("Your_Path/cross_corr_features_betweenROIs_NKI_Rockland/Name_age_test_SVM_MCLOO_21to30_31to40_CCFeats_test1_NoLabels_NKI_Rockland.csv")
Name_data1_Young = Name_file1[3:863,2:(num_Young_total + 1)]          #deviation-based features
Name_data1_Aged = Name_file1[3:863,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #deviation-based features
}
}


#Youns is (21-30: 65) and Aged is (41-50: 71) 
if(my_condition == 7){
num_Young_total = 65
num_Aged_total = 71

if(num_feat == 294){
Name_file1 = read.csv("Your_Path/study_per_test_center_1/Name_age_test_SVM_MCLOO_NKI_ROCKLAND_21to30_41to50_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:296,2:(num_Young_total + 1)]        #this is the full set of features
Name_data1_Aged = Name_file1[3:296,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #this is the full set of features
}

if(num_feat == 210){
Name_file1 = read.csv("Your_Path/study_per_test_center_1/Name_age_test_SVM_MCLOO_NKI_ROCKLAND_21to30_41to50_StatFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:212,2:(num_Young_total + 1)]          #stat features
Name_data1_Aged = Name_file1[3:212,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #stat features
}

if(num_feat == 84){
Name_file1 = read.csv("Your_Path/study_per_test_center_1/Name_age_test_SVM_MCLOO_NKI_ROCKLAND_21to30_41to50_DevFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:86,2:(num_Young_total + 1)]          #deviation-based features
Name_data1_Aged = Name_file1[3:86,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #deviation-based features
}

if(num_feat == 861){
Name_file1 = read.csv("Your_Path/cross_corr_features_betweenROIs_NKI_Rockland/Name_age_test_SVM_MCLOO_21to30_41to50_CCFeats_test1_NoLabels_NKI_Rockland.csv")
Name_data1_Young = Name_file1[3:863,2:(num_Young_total + 1)]          #deviation-based features
Name_data1_Aged = Name_file1[3:863,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #deviation-based features
}
}


#Youns is (21-30: 65) and Aged is (51-60: 67) 
if(my_condition == 8){
num_Young_total = 65
num_Aged_total = 67

if(num_feat == 294){
Name_file1 = read.csv("Your_Path/study_per_test_center_1/Name_age_test_SVM_MCLOO_NKI_ROCKLAND_21to30_51to60_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:296,2:(num_Young_total + 1)]        #this is the full set of features
Name_data1_Aged = Name_file1[3:296,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #this is the full set of features
}

if(num_feat == 210){
Name_file1 = read.csv("Your_Path/study_per_test_center_1/Name_age_test_SVM_MCLOO_NKI_ROCKLAND_21to30_51to60_StatFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:212,2:(num_Young_total + 1)]          #stat features
Name_data1_Aged = Name_file1[3:212,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #stat features
}

if(num_feat == 84){
Name_file1 = read.csv("Your_Path/study_per_test_center_1/Name_age_test_SVM_MCLOO_NKI_ROCKLAND_21to30_51to60_DevFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:86,2:(num_Young_total + 1)]          #deviation-based features
Name_data1_Aged = Name_file1[3:86,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #deviation-based features
}

if(num_feat == 861){
Name_file1 = read.csv("Your_Path/cross_corr_features_betweenROIs_NKI_Rockland/Name_age_test_SVM_MCLOO_21to30_51to60_CCFeats_test1_NoLabels_NKI_Rockland.csv")
Name_data1_Young = Name_file1[3:863,2:(num_Young_total + 1)]          #deviation-based features
Name_data1_Aged = Name_file1[3:863,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #deviation-based features
}
}

#Young is (21-30: 65) and Aged is (61-70: 45) 
if(my_condition == 9){
num_Young_total = 65
num_Aged_total = 45

if(num_feat == 294){
Name_file1 = read.csv("Your_Path/study_per_test_center_1/Name_age_test_SVM_MCLOO_NKI_ROCKLAND_21to30_61to70_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:296,2:(num_Young_total + 1)]        #this is the full set of features
Name_data1_Aged = Name_file1[3:296,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #this is the full set of features
}

if(num_feat == 210){
Name_file1 = read.csv("Your_Path/study_per_test_center_1/Name_age_test_SVM_MCLOO_NKI_ROCKLAND_21to30_61to70_StatFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:212,2:(num_Young_total + 1)]          #stat features
Name_data1_Aged = Name_file1[3:212,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #stat features
}

if(num_feat == 84){
Name_file1 = read.csv("Your_Path/study_per_test_center_1/Name_age_test_SVM_MCLOO_NKI_ROCKLAND_21to30_61to70_DevFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:86,2:(num_Young_total + 1)]          #deviation-based features
Name_data1_Aged = Name_file1[3:86,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #deviation-based features
}

if(num_feat == 861){
Name_file1 = read.csv("Your_Path/cross_corr_features_betweenROIs_NKI_Rockland/Name_age_test_SVM_MCLOO_21to30_61to70_CCFeats_test1_NoLabels_NKI_Rockland.csv")
Name_data1_Young = Name_file1[3:863,2:(num_Young_total + 1)]          #deviation-based features
Name_data1_Aged = Name_file1[3:863,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #deviation-based features
}
}


#Young is (31-40: 27) and Aged is (41-50: 71) 
if(my_condition == 10){
num_Young_total = 27
num_Aged_total = 71

if(num_feat == 294){
Name_file1 = read.csv("Your_Path/study_per_test_center_1/Name_age_test_SVM_MCLOO_NKI_ROCKLAND_31to40_41to50_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:296,2:(num_Young_total + 1)]        #this is the full set of features
Name_data1_Aged = Name_file1[3:296,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #this is the full set of features
}

if(num_feat == 210){
Name_file1 = read.csv("Your_Path/study_per_test_center_1/Name_age_test_SVM_MCLOO_NKI_ROCKLAND_31to40_41to50_StatFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:212,2:(num_Young_total + 1)]          #stat features
Name_data1_Aged = Name_file1[3:212,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #stat features
}

if(num_feat == 84){
Name_file1 = read.csv("Your_Path/study_per_test_center_1/Name_age_test_SVM_MCLOO_NKI_ROCKLAND_31to40_41to50_DevFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:86,2:(num_Young_total + 1)]          #deviation-based features
Name_data1_Aged = Name_file1[3:86,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #deviation-based features
}

if(num_feat == 861){
Name_file1 = read.csv("Your_Path/cross_corr_features_betweenROIs_NKI_Rockland/Name_age_test_SVM_MCLOO_31to40_41to50_CCFeats_test1_NoLabels_NKI_Rockland.csv")
Name_data1_Young = Name_file1[3:863,2:(num_Young_total + 1)]          #CC-based features
Name_data1_Aged = Name_file1[3:863,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #CC-based features
}
}


#Young is (31-40: 27) and Aged is (51-60: 67) 
if(my_condition == 11){
num_Young_total = 27
num_Aged_total = 67

if(num_feat == 294){
Name_file1 = read.csv("Your_Path/study_per_test_center_1/Name_age_test_SVM_MCLOO_NKI_ROCKLAND_31to40_51to60_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:296,2:(num_Young_total + 1)]        #this is the full set of features
Name_data1_Aged = Name_file1[3:296,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #this is the full set of features
}

if(num_feat == 210){
Name_file1 = read.csv("Your_Path/study_per_test_center_1/Name_age_test_SVM_MCLOO_NKI_ROCKLAND_31to40_51to60_StatFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:212,2:(num_Young_total + 1)]          #stat features
Name_data1_Aged = Name_file1[3:212,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #stat features
}

if(num_feat == 84){
Name_file1 = read.csv("Your_Path/study_per_test_center_1/Name_age_test_SVM_MCLOO_NKI_ROCKLAND_31to40_51to60_DevFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:86,2:(num_Young_total + 1)]          #deviation-based features
Name_data1_Aged = Name_file1[3:86,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #deviation-based features
}

if(num_feat == 861){
Name_file1 = read.csv("Your_Path/cross_corr_features_betweenROIs_NKI_Rockland/Name_age_test_SVM_MCLOO_31to40_51to60_CCFeats_test1_NoLabels_NKI_Rockland.csv")
Name_data1_Young = Name_file1[3:863,2:(num_Young_total + 1)]          #CC-based features
Name_data1_Aged = Name_file1[3:863,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #CC-based features
}
}


#Young is (31-40: 27) and Aged is (61-70: 45) 
if(my_condition == 12){
num_Young_total = 27
num_Aged_total = 45

if(num_feat == 294){
Name_file1 = read.csv("Your_Path/study_per_test_center_1/Name_age_test_SVM_MCLOO_NKI_ROCKLAND_31to40_61to70_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:296,2:(num_Young_total + 1)]        #this is the full set of features
Name_data1_Aged = Name_file1[3:296,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #this is the full set of features
}

if(num_feat == 210){
Name_file1 = read.csv("Your_Path/study_per_test_center_1/Name_age_test_SVM_MCLOO_NKI_ROCKLAND_31to40_61to70_StatFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:212,2:(num_Young_total + 1)]          #stat features
Name_data1_Aged = Name_file1[3:212,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #stat features
}

if(num_feat == 84){
Name_file1 = read.csv("Your_Path/study_per_test_center_1/Name_age_test_SVM_MCLOO_NKI_ROCKLAND_31to40_61to70_DevFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:86,2:(num_Young_total + 1)]          #deviation-based features
Name_data1_Aged = Name_file1[3:86,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #deviation-based features
}

if(num_feat == 861){
Name_file1 = read.csv("Your_Path/cross_corr_features_betweenROIs_NKI_Rockland/Name_age_test_SVM_MCLOO_31to40_61to70_CCFeats_test1_NoLabels_NKI_Rockland.csv")
Name_data1_Young = Name_file1[3:863,2:(num_Young_total + 1)]          #CC-based features
Name_data1_Aged = Name_file1[3:863,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #CC-based features
}
}


#Young is (41-50: 71) and Aged is (51-60: 67) 
if(my_condition == 13){
num_Young_total = 71
num_Aged_total = 67

if(num_feat == 294){
Name_file1 = read.csv("Your_Path/study_per_test_center_1/Name_age_test_SVM_MCLOO_NKI_ROCKLAND_41to50_51to60_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:296,2:(num_Young_total + 1)]        #this is the full set of features
Name_data1_Aged = Name_file1[3:296,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #this is the full set of features
}

if(num_feat == 210){
Name_file1 = read.csv("Your_Path/study_per_test_center_1/Name_age_test_SVM_MCLOO_NKI_ROCKLAND_41to50_51to60_StatFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:212,2:(num_Young_total + 1)]          #stat features
Name_data1_Aged = Name_file1[3:212,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #stat features
}

if(num_feat == 84){
Name_file1 = read.csv("Your_Path/study_per_test_center_1/Name_age_test_SVM_MCLOO_NKI_ROCKLAND_41to50_51to60_DevFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:86,2:(num_Young_total + 1)]          #deviation-based features
Name_data1_Aged = Name_file1[3:86,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #deviation-based features
}

if(num_feat == 861){
Name_file1 = read.csv("Your_Path/cross_corr_features_betweenROIs_NKI_Rockland/Name_age_test_SVM_MCLOO_41to50_51to60_CCFeats_test1_NoLabels_NKI_Rockland.csv")
Name_data1_Young = Name_file1[3:863,2:(num_Young_total + 1)]          #CC-based features
Name_data1_Aged = Name_file1[3:863,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #CC-based features
}
}


#Young is (41-50: 71) and Aged is (61-70: 45) 
if(my_condition == 14){
num_Young_total = 71
num_Aged_total = 45

if(num_feat == 294){
Name_file1 = read.csv("Your_Path/study_per_test_center_1/Name_age_test_SVM_MCLOO_NKI_ROCKLAND_41to50_61to70_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:296,2:(num_Young_total + 1)]        #this is the full set of features
Name_data1_Aged = Name_file1[3:296,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #this is the full set of features
}

if(num_feat == 210){
Name_file1 = read.csv("Your_Path/study_per_test_center_1/Name_age_test_SVM_MCLOO_NKI_ROCKLAND_41to50_61to70_StatFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:212,2:(num_Young_total + 1)]          #stat features
Name_data1_Aged = Name_file1[3:212,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #stat features
}

if(num_feat == 84){
Name_file1 = read.csv("Your_Path/study_per_test_center_1/Name_age_test_SVM_MCLOO_NKI_ROCKLAND_41to50_61to70_DevFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:86,2:(num_Young_total + 1)]          #deviation-based features
Name_data1_Aged = Name_file1[3:86,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #deviation-based features
}

if(num_feat == 861){
Name_file1 = read.csv("Your_Path/cross_corr_features_betweenROIs_NKI_Rockland/Name_age_test_SVM_MCLOO_41to50_61to70_CCFeats_test1_NoLabels_NKI_Rockland.csv")
Name_data1_Young = Name_file1[3:863,2:(num_Young_total + 1)]          #CC-based features
Name_data1_Aged = Name_file1[3:863,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #CC-based features
}
}


#Young is (51-60: 67) and Aged is (61-70: 45) 
if(my_condition == 15){
num_Young_total = 67
num_Aged_total = 45

if(num_feat == 294){
Name_file1 = read.csv("Your_Path/study_per_test_center_1/Name_age_test_SVM_MCLOO_NKI_ROCKLAND_51to60_61to70_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:296,2:(num_Young_total + 1)]        #this is the full set of features
Name_data1_Aged = Name_file1[3:296,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #this is the full set of features
}

if(num_feat == 210){
Name_file1 = read.csv("Your_Path/study_per_test_center_1/Name_age_test_SVM_MCLOO_NKI_ROCKLAND_51to60_61to70_StatFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:212,2:(num_Young_total + 1)]          #stat features
Name_data1_Aged = Name_file1[3:212,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #stat features
}

if(num_feat == 84){
Name_file1 = read.csv("Your_Path/study_per_test_center_1/Name_age_test_SVM_MCLOO_NKI_ROCKLAND_51to60_61to70_DevFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[3:86,2:(num_Young_total + 1)]          #deviation-based features
Name_data1_Aged = Name_file1[3:86,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #deviation-based features
}

if(num_feat == 861){
Name_file1 = read.csv("Your_Path/cross_corr_features_betweenROIs_NKI_Rockland/Name_age_test_SVM_MCLOO_51to60_61to70_CCFeats_test1_NoLabels_NKI_Rockland.csv")
Name_data1_Young = Name_file1[3:863,2:(num_Young_total + 1)]          #CC-based features
Name_data1_Aged = Name_file1[3:863,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #CC-based features
}
}


#Young is (21-25: 48) and Aged is (26-30: 17)  
if(my_condition == 16){
num_Young_total = 48
num_Aged_total = 17

if(num_feat == 294){
Name_file1 = read.csv("Your_Path/Name_center_sorted_test1_NKI_ROCKLAND_same_decade_21to25_vs_26to30.csv")
Name_data1_Young = Name_file1[3:296,2:(num_Young_total + 1)]        #this is the full set of features
Name_data1_Aged = Name_file1[3:296,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #this is the full set of features
}

if(num_feat == 210){
Name_file1 = read.csv("Your_Path/Name_center_sorted_test1_NKI_ROCKLAND_same_decade_21to25_vs_26to30_StatFeats.csv")
Name_data1_Young = Name_file1[3:212,2:(num_Young_total + 1)]          #stat features
Name_data1_Aged = Name_file1[3:212,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #stat features
}

if(num_feat == 84){
Name_file1 = read.csv("Your_Path/Name_center_sorted_test1_NKI_ROCKLAND_same_decade_21to25_vs_26to30_DevFeats.csv")
Name_data1_Young = Name_file1[3:86,2:(num_Young_total + 1)]          #deviation-based features
Name_data1_Aged = Name_file1[3:86,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #deviation-based features
}

if(num_feat == 861){
Name_file1 = read.csv("Your_Path/Name_center_sorted_test1_NKI_ROCKLAND_same_decade_21to25_vs_26to30_CCFeats.csv")
Name_data1_Young = Name_file1[3:863,2:(num_Young_total + 1)]          #CC-based features
Name_data1_Aged = Name_file1[3:863,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]   #CC-based features 
}
}


#Young is (31-35: 15) and Aged is (36-40: 13)
if(my_condition == 17){
num_Young_total = 14
num_Aged_total = 13

if(num_feat == 294){
Name_file1 = read.csv("Your_Path/Name_center_sorted_test1_NKI_ROCKLAND_same_decade_31to35_vs_36to40.csv")
Name_data1_Young = Name_file1[3:296,2:(num_Young_total + 1)]        #this is the full set of features
Name_data1_Aged = Name_file1[3:296,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #this is the full set of features
}

if(num_feat == 210){
Name_file1 = read.csv("Your_Path/Name_center_sorted_test1_NKI_ROCKLAND_same_decade_31to35_vs_36to40_StatFeats.csv")
Name_data1_Young = Name_file1[3:212,2:(num_Young_total + 1)]          #stat features
Name_data1_Aged = Name_file1[3:212,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #stat features
}

if(num_feat == 84){
Name_file1 = read.csv("Your_Path/Name_center_sorted_test1_NKI_ROCKLAND_same_decade_31to35_vs_36to40_DevFeats.csv")
Name_data1_Young = Name_file1[3:86,2:(num_Young_total + 1)]          #deviation-based features
Name_data1_Aged = Name_file1[3:86,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #deviation-based features
}

if(num_feat == 861){
Name_file1 = read.csv("Your_Path/Name_center_sorted_test1_NKI_ROCKLAND_same_decade_31to35_vs_36to40_CCFeats.csv")
Name_data1_Young = Name_file1[3:863,2:(num_Young_total + 1)]          #CC-based features
Name_data1_Aged = Name_file1[3:863,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]    #CC-based features
}
}


#Young is (61-65: 22) and Aged is (66-70: 23)
if(my_condition == 18){
num_Young_total = 22
num_Aged_total = 23

if(num_feat == 294){
Name_file1 = read.csv("Your_Path/Name_center_sorted_test1_NKI_ROCKLAND_same_decade_61to65_vs_66to70.csv")
Name_data1_Young = Name_file1[3:296,2:(num_Young_total + 1)]        #this is the full set of features
Name_data1_Aged = Name_file1[3:296,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #this is the full set of features
}

if(num_feat == 210){
Name_file1 = read.csv("Your_Path/Name_center_sorted_test1_NKI_ROCKLAND_same_decade_61to65_vs_66to70_StatFeats.csv")
Name_data1_Young = Name_file1[3:212,2:(num_Young_total + 1)]          #stat features
Name_data1_Aged = Name_file1[3:212,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #stat features
}

if(num_feat == 84){
Name_file1 = read.csv("Your_Path/Name_center_sorted_test1_NKI_ROCKLAND_same_decade_61to65_vs_66to70_DevFeats.csv")
Name_data1_Young = Name_file1[3:86,2:(num_Young_total + 1)]          #deviation-based features
Name_data1_Aged = Name_file1[3:86,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #deviation-based features
}

if(num_feat == 861){
Name_file1 = read.csv("Your_Path/Name_center_sorted_test1_NKI_ROCKLAND_same_decade_61to65_vs_66to70_CCFeats.csv")
Name_data1_Young = Name_file1[3:863,2:(num_Young_total + 1)]          #CC-based features
Name_data1_Aged = Name_file1[3:863,(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]    #CC-based features
}
}

num_for_test = (min(num_Aged_total, num_Young_total) - 1) * 2

y_label = c(rep(1, num_for_test/2), rep(-1, num_for_test/2))


# label = "1" means young
# label = "0/-1" means old

Name_data1_YoungAged = cbind(Name_data1_Young, Name_data1_Aged)

#total_loop1 = 5000
total_loop1 = 1000
#total_loop1 = 100
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

num_subj = dim(Name_data1_YoungAged)[2]

x_train_mat1 <- matrix(0, num_feat, length(train_indices))

while(k2 <= length(train_indices)){
k3=1
  while(k3 <= num_feat){
  x_train_mat1[k3, k2] = Name_data1_YoungAged[k3, (train_indices[k2])]
   k3 = k3 + 1
  }
 k2 = k2 + 1
}

######### Set up the training and test matrices for both the data and the labels (begin) #########

#xtrain <- xmat1
xtest_Young <- Name_data1_YoungAged[,test_Young_idx]
xtest_Aged <- Name_data1_YoungAged[,test_Aged_idx]

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

printf("my_condition=%f,  num_feat=%f", my_condition, num_feat) 
printf("num_Young_total=%d   num_Aged_total=%d", num_Young_total, num_Aged_total)
printf("correct_Young=%d   correct_Aged=%d", correct_Young, correct_Aged)
