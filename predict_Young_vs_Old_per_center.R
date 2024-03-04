
#train the system on data from 2 different centers and then see if it can predict which center the test data came from 
#will do separately for young and aged brains - each coming from 3 centers

#Centers:
#young_Rockland: 54
#young_Beijing:  119
#young_Cambridge: 96
#aged_Rockland: 145
#aged_Milwaukee:  43
#aged_COBRE: 21

#labels are 1  or  -1/0  for test center
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

my_condition = 1   #young (21 to 26) Rockland vs. Beijing
#my_condition = 2   #young (21 26) Rockland vs. Cambridge
#my_condition = 3   #young (21 to 26) Beijing vs. Cambridge
#my_condition = 4   #aged (44 to 65) Rockland vs. Milwaukee
#my_condition = 5  #aged (44 to 65) Rockland vs. COBRE
#my_condition = 6  #aged (44 to 65) COBRE vs. Milwaukee 

num_feat=294   #i.e. 42 * 7  all features
#num_feat=210   #i.e. 42 * 5  stat features
#num_feat=84    #i.e. 42 * 2  deviation-based features
#num_feat=861   #i.e. ((42 ^2) - 42)/2  CC features


if(my_condition == 1){
num_Center1_total = 54
num_Center2_total = 119

if(num_feat == 294){
Name_file1 = read.csv("Your_Path/study_per_test_center_2/Name_center_sorted_test1_young_NKI_ROCKLAND_vs_Beijing_Zang.csv")
Name_data1_Center1 = Name_file1[3:296,2:(num_Center1_total + 1)]          #this is the full set of features
Name_data1_Center2 = Name_file1[3:296,(num_Center1_total + 2):(num_Center1_total + num_Center2_total + 1)]  #this is the full set of features
}

if(num_feat == 210){
Name_file1 = read.csv("Your_Path/study_per_test_center_2/Name_center_sorted_test1_young_NKI_ROCKLAND_vs_Beijing_Zang_StatFeats.csv")
Name_data1_Center1 = Name_file1[3:212,2:(num_Center1_total + 1)]          #stat features
Name_data1_Center2 = Name_file1[3:212,(num_Center1_total + 2):(num_Center1_total + num_Center2_total + 1)]  #stat features
}

if(num_feat == 84){
Name_file1 = read.csv("Your_Path/study_per_test_center_2/Name_center_sorted_test1_young_NKI_ROCKLAND_vs_Beijing_Zang_DevFeats.csv")
Name_data1_Center1 = Name_file1[3:86,2:(num_Center1_total + 1)]          #deviation-based features
Name_data1_Center2 = Name_file1[3:86,(num_Center1_total + 2):(num_Center1_total + num_Center2_total + 1)]  #deviation-based features
}

if(num_feat == 861){
Name_file1 = read.csv("Your_Path/study_per_test_center_2/Name_center_sorted_test1_young_NKI_ROCKLAND_vs_Beijing_Zang_CCFeats.csv")
Name_data1_Center1 = Name_file1[3:863,2:(num_Center1_total + 1)]          #deviation-based features
Name_data1_Center2 = Name_file1[3:863,(num_Center1_total + 2):(num_Center1_total + num_Center2_total + 1)]   #CC features
}
}


if(my_condition == 2){
num_Center1_total = 54
num_Center2_total = 96

if(num_feat == 294){
Name_file1 = read.csv("Your_Path/study_per_test_center_2/Name_center_sorted_test1_young_NKI_ROCKLAND_vs_Cambridge_Buckner.csv") 
Name_data1_Center1 = Name_file1[3:296,2:(num_Center1_total + 1)]          #this is the full set of features
Name_data1_Center2 = Name_file1[3:296,(num_Center1_total + 2):(num_Center1_total + num_Center2_total + 1)]  #this is the full set of features
}

if(num_feat == 210){
Name_file1 = read.csv("Your_Path/study_per_test_center_2/Name_center_sorted_test1_young_NKI_ROCKLAND_vs_Cambridge_Buckner_StatFeats.csv")
Name_data1_Center1 = Name_file1[3:212,2:(num_Center1_total + 1)]          #stat features
Name_data1_Center2 = Name_file1[3:212,(num_Center1_total + 2):(num_Center1_total + num_Center2_total + 1)]  #stat features
}

if(num_feat == 84){
Name_file1 = read.csv("Your_Path/study_per_test_center_2/Name_center_sorted_test1_young_NKI_ROCKLAND_vs_Cambridge_Buckner_DevFeats.csv")
Name_data1_Center1 = Name_file1[3:86,2:(num_Center1_total + 1)]          #deviation-based features
Name_data1_Center2 = Name_file1[3:86,(num_Center1_total + 2):(num_Center1_total + num_Center2_total + 1)]  #deviation-based features
}

if(num_feat == 861){
Name_file1 = read.csv("Your_Path/study_per_test_center_2/Name_center_sorted_test1_young_NKI_ROCKLAND_vs_Cambridge_Buckner_CCFeats.csv")
Name_data1_Center1 = Name_file1[3:863,2:(num_Center1_total + 1)]          #deviation-based features
Name_data1_Center2 = Name_file1[3:863,(num_Center1_total + 2):(num_Center1_total + num_Center2_total + 1)]    #CC features
}
}

if(my_condition == 3){
num_Center1_total = 119
num_Center2_total = 96

if(num_feat == 294){
Name_file1 = read.csv("Your_Path/study_per_test_center_2/Name_center_sorted_test1_young_Beijing_Zang_vs_Cambridge_Buckner.csv")
Name_data1_Center1 = Name_file1[3:296,2:(num_Center1_total + 1)]          #this is the full set of features
Name_data1_Center2 = Name_file1[3:296,(num_Center1_total + 2):(num_Center1_total + num_Center2_total + 1)]  #this is the full set of features
}

if(num_feat == 210){
Name_file1 = read.csv("Your_Path/study_per_test_center_2/Name_center_sorted_test1_young_Beijing_Zang_vs_Cambridge_Buckner_StatFeats.csv")
Name_data1_Center1 = Name_file1[3:212,2:(num_Center1_total + 1)]          #stat features
Name_data1_Center2 = Name_file1[3:212,(num_Center1_total + 2):(num_Center1_total + num_Center2_total + 1)]  #stat features
}

if(num_feat == 84){
Name_file1 = read.csv("Your_Path/study_per_test_center_2/Name_center_sorted_test1_young_Beijing_Zang_vs_Cambridge_Buckner_DevFeats.csv")
Name_data1_Center1 = Name_file1[3:86,2:(num_Center1_total + 1)]          #deviation-based features
Name_data1_Center2 = Name_file1[3:86,(num_Center1_total + 2):(num_Center1_total + num_Center2_total + 1)]  #deviation-based features
}

if(num_feat == 861){
Name_file1 = read.csv("Your_Path/study_per_test_center_2/Name_center_sorted_test1_young_Beijing_Zang_vs_Cambridge_Buckner_CCFeats.csv")
Name_data1_Center1 = Name_file1[3:863,2:(num_Center1_total + 1)]          #deviation-based features
Name_data1_Center2 = Name_file1[3:863,(num_Center1_total + 2):(num_Center1_total + num_Center2_total + 1)]   #CC features
}
}

if(my_condition == 4){
num_Center1_total = 145
num_Center2_total = 43

if(num_feat == 294){
Name_file1 = read.csv("Your_Path/study_per_test_center_2/Name_center_sorted_test1_aged_NKI_ROCKLAND_vs_Milwaukee.csv")
Name_data1_Center1 = Name_file1[3:296,2:(num_Center1_total + 1)]          #this is the full set of features
Name_data1_Center2 = Name_file1[3:296,(num_Center1_total + 2):(num_Center1_total + num_Center2_total + 1)]  #this is the full set of features
}

if(num_feat == 210){
Name_file1 = read.csv("Your_Path/study_per_test_center_2/Name_center_sorted_test1_aged_NKI_ROCKLAND_vs_Milwaukee_StatFeats.csv")
Name_data1_Center1 = Name_file1[3:212,2:(num_Center1_total + 1)]          #stat features
Name_data1_Center2 = Name_file1[3:212,(num_Center1_total + 2):(num_Center1_total + num_Center2_total + 1)]  #stat features
}

if(num_feat == 84){
Name_file1 = read.csv("Your_Path/study_per_test_center_2/Name_center_sorted_test1_aged_NKI_ROCKLAND_vs_Milwaukee_DevFeats.csv")
Name_data1_Center1 = Name_file1[3:86,2:(num_Center1_total + 1)]          #deviation-based features
Name_data1_Center2 = Name_file1[3:86,(num_Center1_total + 2):(num_Center1_total + num_Center2_total + 1)]  #deviation-based features
}

if(num_feat == 861){
Name_file1 = read.csv("Your_Path/study_per_test_center_2/Name_center_sorted_test1_aged_NKI_ROCKLAND_vs_Milwaukee_CCFeats.csv")
Name_data1_Center1 = Name_file1[3:863,2:(num_Center1_total + 1)]          #deviation-based features
Name_data1_Center2 = Name_file1[3:863,(num_Center1_total + 2):(num_Center1_total + num_Center2_total + 1)]   #CC features
}
}


if(my_condition == 5){
num_Center1_total = 145
num_Center2_total = 21

if(num_feat == 294){
Name_file1 = read.csv("Your_Path/study_per_test_center_2/Name_center_sorted_test1_aged_NKI_ROCKLAND_vs_COBRE.csv")
Name_data1_Center1 = Name_file1[3:296,2:(num_Center1_total + 1)]          #this is the full set of features
Name_data1_Center2 = Name_file1[3:296,(num_Center1_total + 2):(num_Center1_total + num_Center2_total + 1)]  #this is the full set of features
}

if(num_feat == 210){
Name_file1 = read.csv("Your_Path/study_per_test_center_2/Name_center_sorted_test1_aged_NKI_ROCKLAND_vs_COBRE_StatFeats.csv")
Name_data1_Center1 = Name_file1[3:212,2:(num_Center1_total + 1)]          #stat features
Name_data1_Center2 = Name_file1[3:212,(num_Center1_total + 2):(num_Center1_total + num_Center2_total + 1)]  #stat features
}

if(num_feat == 84){
Name_file1 = read.csv("Your_Path/study_per_test_center_2/Name_center_sorted_test1_aged_NKI_ROCKLAND_vs_COBRE_DevFeats.csv")
Name_data1_Center1 = Name_file1[3:86,2:(num_Center1_total + 1)]          #deviation-based features
Name_data1_Center2 = Name_file1[3:86,(num_Center1_total + 2):(num_Center1_total + num_Center2_total + 1)]  #deviation-based features
}

if(num_feat == 861){
Name_file1 = read.csv("Your_Path/study_per_test_center_2/Name_center_sorted_test1_aged_NKI_ROCKLAND_vs_COBRE_CCFeats.csv")
Name_data1_Center1 = Name_file1[3:863,2:(num_Center1_total + 1)]          #deviation-based features
Name_data1_Center2 = Name_file1[3:863,(num_Center1_total + 2):(num_Center1_total + num_Center2_total + 1)]    #CC features
}
}


#Youns is (21-30: 65) and Center2 is (31-40: 27)
if(my_condition == 6){
num_Center1_total = 21
num_Center2_total = 43

if(num_feat == 294){
Name_file1 = read.csv("Your_Path/study_per_test_center_2/Name_center_sorted_test1_aged_COBRE_vs_Milwaukee.csv")
Name_data1_Center1 = Name_file1[3:296,2:(num_Center1_total + 1)]        #this is the full set of features
Name_data1_Center2 = Name_file1[3:296,(num_Center1_total + 2):(num_Center1_total + num_Center2_total + 1)]  #this is the full set of features
}

if(num_feat == 210){
Name_file1 = read.csv("Your_Path/study_per_test_center_2/Name_center_sorted_test1_aged_COBRE_vs_Milwaukee_StatFeats.csv")
Name_data1_Center1 = Name_file1[3:212,2:(num_Center1_total + 1)]          #stat features
Name_data1_Center2 = Name_file1[3:212,(num_Center1_total + 2):(num_Center1_total + num_Center2_total + 1)]  #stat features
}

if(num_feat == 84){
Name_file1 = read.csv("Your_Path/study_per_test_center_2/Name_center_sorted_test1_aged_COBRE_vs_Milwaukee_DevFeats.csv")
Name_data1_Center1 = Name_file1[3:86,2:(num_Center1_total + 1)]          #deviation-based features
Name_data1_Center2 = Name_file1[3:86,(num_Center1_total + 2):(num_Center1_total + num_Center2_total + 1)]  #deviation-based features
}

if(num_feat == 861){
Name_file1 = read.csv("Your_Path/study_per_test_center_2/Name_center_sorted_test1_aged_COBRE_vs_Milwaukee_CCFeats.csv")
Name_data1_Center1 = Name_file1[3:863,2:(num_Center1_total + 1)]          #deviation-based features
Name_data1_Center2 = Name_file1[3:863,(num_Center1_total + 2):(num_Center1_total + num_Center2_total + 1)]     #CC features
}
}


num_for_test = (min(num_Center2_total, num_Center1_total) - 1) * 2

y_label = c(rep(1, num_for_test/2), rep(-1, num_for_test/2))

# label = "1" means Center1
# label = "0/-1" means Center2

Name_data1_Center1Center2 = cbind(Name_data1_Center1, Name_data1_Center2)

#total_loop1 = 3000
total_loop1 = 1000
#total_loop1 = 100
#total_loop1 = 1

idx_of_loop = 1
correct_Center2 = 0
correct_Center1 = 0

while(idx_of_loop <= total_loop1){       # outer-most while-loop for leave-one-out analysis

Center1_indices = sample.int(num_Center1_total, num_Center1_total)
Center2_indices = num_Center1_total + sample.int(num_Center2_total, num_Center2_total)

train_indices = c(Center1_indices[1:(min(num_Center2_total, num_Center1_total) - 1)], Center2_indices[1: (min(num_Center2_total, num_Center1_total) - 1)])

test_Center1_idx = Center1_indices[min(num_Center2_total, num_Center1_total)]
test_Center2_idx = Center2_indices[min(num_Center2_total, num_Center1_total)]

k2=1 

num_subj = dim(Name_data1_Center1Center2)[2]

x_train_mat1 <- matrix(0, num_feat, length(train_indices))

while(k2 <= length(train_indices)){
k3=1
  while(k3 <= num_feat){
  x_train_mat1[k3, k2] = Name_data1_Center1Center2[k3, (train_indices[k2])]
   k3 = k3 + 1
  }
 k2 = k2 + 1
}

######### Set up the training and test matrices for both the data and the labels (begin) #########

#xtrain <- xmat1
xtest_Center1 <- Name_data1_Center1Center2[,test_Center1_idx]
xtest_Center2 <- Name_data1_Center1Center2[,test_Center2_idx]

ylabel_Center1 = 1
ylabel_Center2 = -1

######### Set up the training and test matrices for both the data and the labels (end) #########

############# Train the SVM with the training data ############# 

svp <- ksvm(t(x_train_mat1), y_label, type="C-svc", kernel='vanilladot', C=60, scaled=c())     #linear kernel

############# Predict labels on test data ############# 
class(xtest_Center1) <- "numeric"      # convert the guy who is not "atomic" into "atomic" via this command
class(xtest_Center2) <- "numeric"      # convert the guy who is not "atomic" into "atomic" via this command

ypred_Center1 = predict(svp, t(xtest_Center1))

ypred_Center2 = predict(svp, t(xtest_Center2))

if(ypred_Center1 == ylabel_Center1){ 
correct_Center1 = correct_Center1 + 1  }

if(ypred_Center2 == ylabel_Center2){ 
correct_Center2 = correct_Center2 + 1  }

printf("idx_of_loop =%f", idx_of_loop) 
printf("test_Center1_idx=%f  test_Center2_idx=%f", test_Center1_idx, test_Center2_idx)
printf("ypred_Center1=%f  ypred_Center2=%f", ypred_Center1, ypred_Center2)
printf("correct_Center1=%f  correct_Center2=%f", correct_Center1, correct_Center2)
cat("\n")

rm(ypred_Center1, svp, ypred_Center2, xtest_Center1, xtest_Center2, x_train_mat1)   # remove these vars form memory so you can set it anew for the next subject

idx_of_loop = idx_of_loop + 1
 
}        # outer-most while-loop 
