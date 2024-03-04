
#ML pipeline with SVM, uses 1 ROI at a time to predict into Young vs. Aged groups

#The Y vs. O groups are selected via 3 difference cases.
#Case 1: train on 38 in group 1, 38 in group 6. Then test on 1 left-out from each group. Iterate over random permutations. 
#Case 2: train on 118 in group 3, 118 in group 4. Then test on 1 left-out from each group. Iterate over random permutations. 
#Case 3: train on 224 in group 1+2+3, 224 in group 4+5+6. Then test on 1 left-out from each group. Then test on 1 left-out from each group. Iterate over random permutations. 

#age groups:
#group 1 - 21-30: 458 
#group 2 - 31-40: 85 
#group 3 - 41-50: 119 
#group 4 - 51-60: 119 
#group 5 - 61-70: 67 
#group 6 - (71+ : 39)
#group 7 - 71-80: 31 
#group 8 - 81+ : 8 

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

my_condition = 1    #Case 1: test Y (21-30) vs. O (71+)
#my_condition = 2   #Case 2: test Y (41-50) vs. O (51-60)
#my_condition = 3   #Case 3: test Y (21-50) vs. O (51+)

ROI_idx_max = 42

ROI_idx = 1   #index of ROI being considered, 1 to 42

while(ROI_idx <= ROI_idx_max)
{

set.seed(123)

shuffle = 0

num_feat=7   #i.e. 1 * 7  all features
#num_feat=5   #i.e. 1 * 5  stat features
#num_feat=2   #i.e. 1 * 2  deviation-based features

feature_start_num = 3 + ((ROI_idx - 1) * num_feat)
feature_end_num = 3 + ((ROI_idx) * num_feat) - 1


if(my_condition == 1){
num_Young_total = 458
num_Aged_total = 39

if(num_feat == 7){
Name_file1 = read.csv("Your_Path/Name_age_test_SVM_MCLOO_21to30_71plus_test1_NoLabels.csv")
Name_data1_Young = Name_file1[feature_start_num:feature_end_num, 2:459]          #this is the full set of features
Name_data1_Aged = Name_file1[feature_start_num:feature_end_num, 460:(460+39-1)]  #this is the full set of features
}

if(num_feat == 5){
Name_file1 = read.csv("Your_Path/Name_age_test_SVM_MCLOO_21to30_71plus_StatFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[feature_start_num:feature_end_num, 2:459]          #stat features
Name_data1_Aged = Name_file1[feature_start_num:feature_end_num, 460:(460+39-1)]  #stat features
}

if(num_feat == 2){
Name_file1 = read.csv("Your_Path/Name_age_test_SVM_MCLOO_21to30_71plus_DevFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[(feature_start_num):(feature_end_num), 2:459]          #deviation-based features
Name_data1_Aged = Name_file1[(feature_start_num):(feature_end_num), 460:(460+39-1)]  #deviation-based features
}
}

if(my_condition == 2){
num_Young_total = 119
num_Aged_total = 119

if(num_feat == 7){
Name_file1 = read.csv("Your_Path/Name_age_test_SVM_MCLOO_41to50_51to60_test1_NoLabels.csv")
Name_data1_Young = Name_file1[(feature_start_num):(feature_end_num), 2:(num_Young_total + 1)]          #this is the full set of features
Name_data1_Aged = Name_file1[(feature_start_num):(feature_end_num), (num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #this is the full set of features
}

if(num_feat == 5){
Name_file1 = read.csv("Your_Path/Name_age_test_SVM_MCLOO_41to50_51to60_StatFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[(feature_start_num):(feature_end_num),2:(num_Young_total + 1)]          #stat features
Name_data1_Aged = Name_file1[(feature_start_num):(feature_end_num),(num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #stat features
}

if(num_feat == 2){
Name_file1 = read.csv("Your_Path/Name_age_test_SVM_MCLOO_41to50_51to60_DevFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[(feature_start_num):(feature_end_num), 2:(num_Young_total + 1)]          #deviation-based features
Name_data1_Aged = Name_file1[(feature_start_num):(feature_end_num), (num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #deviation-based features
}
}

if(my_condition == 3){
num_Young_total = 662
num_Aged_total = 225

if(num_feat == 7){
Name_file1 = read.csv("Your_Path/Name_age_test_SVM_MCLOO_21to50_51to71plus_test1_NoLabels.csv")
Name_data1_Young = Name_file1[(feature_start_num):(feature_end_num), 2:(num_Young_total + 1)]          #this is the full set of features 
Name_data1_Aged = Name_file1[(feature_start_num):(feature_end_num), (num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #this is the full set of features 
}

if(num_feat == 5){
Name_file1 = read.csv("Your_Path/Name_age_test_SVM_MCLOO_21to50_51to71plus_StatFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[(feature_start_num):(feature_end_num), 2:(num_Young_total + 1)]          #stat features 
Name_data1_Aged = Name_file1[(feature_start_num):(feature_end_num), (num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #stat features 
}

if(num_feat == 2){
Name_file1 = read.csv("Your_Path/Name_age_test_SVM_MCLOO_21to50_51to71plus_DevFeats_test1_NoLabels.csv")
Name_data1_Young = Name_file1[(feature_start_num):(feature_end_num), 2:(num_Young_total + 1)]          #deviation-based features 
Name_data1_Aged = Name_file1[(feature_start_num):(feature_end_num), (num_Young_total + 2):(num_Young_total + num_Aged_total + 1)]  #deviation-based features 
}
}

Name_data1_YoungAged = cbind(Name_data1_Young, Name_data1_Aged)
num_subj = dim(Name_data1_YoungAged)[2]

Name_data1_YoungAged_2 <- matrix(0, dim(Name_data1_YoungAged)[1], dim(Name_data1_YoungAged)[2])

num_for_test = (min(num_Aged_total, num_Young_total) - 1) * 2

y_label = c(rep(1, num_for_test/2), rep(-1, num_for_test/2))

# label = "1" means young
# label = "0/-1" means old

#n22 = dim(Name_data1)[1]

#indices 1 to 458 are +1, indices 459 to 497 are -1

#total_loop1 = 5000
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

#xtrain <- xmat1
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


if(idx_of_loop == total_loop1){
printf("ROI_idx =%f", ROI_idx) 
printf("idx_of_loop =%f", idx_of_loop) 
printf("test_Young_idx=%f  test_Aged_idx=%f", test_Young_idx, test_Aged_idx)
printf("ypred_Young=%f  ypred_Aged=%f", ypred_Young, ypred_Aged)
printf("correct_Young=%f  correct_Aged=%f", correct_Young, correct_Aged)
cat("\n")
}

rm(ypred_Young, svp, ypred_Aged, xtest_Young, xtest_Aged, x_train_mat1)   # remove these vars form memory so you can set it anew for the next subject

idx_of_loop = idx_of_loop + 1

}        # outer-most while-loop 

ROI_idx = ROI_idx + 1
} #for ROI-loop
