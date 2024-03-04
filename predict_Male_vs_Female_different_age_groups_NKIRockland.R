
#Question: For a given age category, can we distinguish between a male and female brain? 
#For a given age group: train on X male and X female brains. Test on the remaining. Do MC over 1000 iterations. 

#age groups:
#21-30: 65 (37, 28) 
#31-40: 27 (8, 19) 
#41-50: 71 (16, 55) 
#51-60: 67 (12, 55) 
#61-70: 45 (13, 32) 
#71+ : 32 (11, 21) 

#labels are 1 = Male or  -1/0 = Female 
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

my_condition = 1   #21-to-30 
#my_condition = 2    #31-to-40
#my_condition = 3   #41-to-50
#my_condition = 4   #51-to-60 
#my_condition = 5   #61-to-70
#my_condition = 6   #71+

Num_ROI = 42

shuffle = 0

num_feat=294   #i.e. 42 * 7  all features
#num_feat=210   #i.e. 42 * 5  stat features
#num_feat=84    #i.e. 42 * 2  deviation-based features


if(my_condition == 1){
num_Male_total = 37
num_Female_total = 28

if(num_feat == 294){
Name_file1 = read.csv("Your_Path/NKI_Rockland/Name_NKI_Rockland_gender_sorted_21to30_AllFeautres_1.csv")
Name_data1_Male = Name_file1[3:296, 2:(num_Male_total + 1)]          #this is the full set of features
Name_data1_Female = Name_file1[3:296, (num_Male_total + 2):(num_Male_total+num_Female_total+1)]  #this is the full set of features
}

if(num_feat == 210){
Name_file1 = read.csv("Your_Path/NKI_Rockland/Name_NKI_Rockland_gender_sorted_21to30_StatFeautres_1.csv")
Name_data1_Male = Name_file1[3:212, 2:(num_Male_total + 1)]          #stat features
Name_data1_Female = Name_file1[3:212, (num_Male_total + 2):(num_Male_total+num_Female_total+1)]  #stat features
}

if(num_feat == 84){
Name_file1 = read.csv("Your_Path/NKI_Rockland/Name_NKI_Rockland_gender_sorted_21to30_DevFeautres_1.csv")
Name_data1_Male = Name_file1[3:86, 2:(num_Male_total + 1)]          #deviation-based features
Name_data1_Female = Name_file1[3:86, (num_Male_total + 2):(num_Male_total+num_Female_total+1)]  #deviation-based features
}

if(num_feat == 861){
Name_file1 = read.csv("Your_Path/NKI_Rockland/matrix_ROI_CCs_per_subjects_NKI_Rockland_21to30_1.csv")
Name_data1_Male = Name_file1[3:863, 2:(num_Male_total + 1)]          # CC features
Name_data1_Female = Name_file1[3:863, (num_Male_total + 2):(num_Male_total+num_Female_total+1)]      # CC features
}
}

if(my_condition == 2){
num_Male_total = 8
num_Female_total = 19

if(num_feat == 294){
Name_file1 = read.csv("Your_Path/NKI_Rockland/Name_NKI_Rockland_gender_sorted_31to40_AllFeautres_1.csv")
Name_data1_Male = Name_file1[3:296, 2:(num_Male_total + 1)]          #this is the full set of features
Name_data1_Female = Name_file1[3:296, (num_Male_total + 2):(num_Male_total+num_Female_total+1)]  #this is the full set of features
}

if(num_feat == 210){
Name_file1 = read.csv("Your_Path/NKI_Rockland/Name_NKI_Rockland_gender_sorted_31to40_StatFeautres_1.csv")
Name_data1_Male = Name_file1[3:212, 2:(num_Male_total + 1)]          #stat features
Name_data1_Female = Name_file1[3:212, (num_Male_total + 2):(num_Male_total+num_Female_total+1)]  #stat features
}

if(num_feat == 84){
Name_file1 = read.csv("Your_Path/NKI_Rockland/Name_NKI_Rockland_gender_sorted_31to40_DevFeautres_1.csv")
Name_data1_Male = Name_file1[3:86, 2:(num_Male_total + 1)]          #deviation-based features
Name_data1_Female = Name_file1[3:86, (num_Male_total + 2):(num_Male_total+num_Female_total+1)]  #deviation-based features
}

if(num_feat == 861){
Name_file1 = read.csv("Your_Path/NKI_Rockland/matrix_ROI_CCs_per_subjects_NKI_Rockland_31to40_1.csv")
Name_data1_Male = Name_file1[3:863, 2:(num_Male_total + 1)]           # CC features
Name_data1_Female = Name_file1[3:863, (num_Male_total + 2):(num_Male_total+num_Female_total+1)]      # CC features
}
}

if(my_condition == 3){
num_Male_total = 16
num_Female_total = 55

if(num_feat == 294){
Name_file1 = read.csv("Your_Path/NKI_Rockland/Name_NKI_Rockland_gender_sorted_41to50_AllFeautres_1.csv")
Name_data1_Male = Name_file1[3:296, 2:(num_Male_total + 1)]          #this is the full set of features
Name_data1_Female = Name_file1[3:296, (num_Male_total + 2):(num_Male_total+num_Female_total+1)]  #this is the full set of features
}

if(num_feat == 210){
Name_file1 = read.csv("Your_Path/NKI_Rockland/Name_NKI_Rockland_gender_sorted_41to50_StatFeautres_1.csv")
Name_data1_Male = Name_file1[3:212, 2:(num_Male_total + 1)]          #stat features
Name_data1_Female = Name_file1[3:212, (num_Male_total + 2):(num_Male_total+num_Female_total+1)]  #stat features
}

if(num_feat == 84){
Name_file1 = read.csv("Your_Path/NKI_Rockland/Name_NKI_Rockland_gender_sorted_41to50_DevFeautres_1.csv")
Name_data1_Male = Name_file1[3:86, 2:(num_Male_total + 1)]          #deviation-based features
Name_data1_Female = Name_file1[3:86, (num_Male_total + 2):(num_Male_total+num_Female_total+1)]  #deviation-based features
}

if(num_feat == 861){
Name_file1 = read.csv("Your_Path/NKI_Rockland/matrix_ROI_CCs_per_subjects_NKI_Rockland_41to50_1.csv")
Name_data1_Male = Name_file1[3:863, 2:(num_Male_total + 1)]          # CC features
Name_data1_Female = Name_file1[3:863, (num_Male_total + 2):(num_Male_total+num_Female_total+1)]      # CC features
}
}

if(my_condition == 4){
num_Male_total = 12
num_Female_total = 55

if(num_feat == 294){
Name_file1 = read.csv("Your_Path/NKI_Rockland/Name_NKI_Rockland_gender_sorted_51to60_AllFeautres_1.csv")
Name_data1_Male = Name_file1[3:296, 2:(num_Male_total + 1)]          #this is the full set of features
Name_data1_Female = Name_file1[3:296, (num_Male_total + 2):(num_Male_total+num_Female_total+1)]  #this is the full set of features
}

if(num_feat == 210){
Name_file1 = read.csv("Your_Path/NKI_Rockland/Name_NKI_Rockland_gender_sorted_51to60_StatFeautres_1.csv")
Name_data1_Male = Name_file1[3:212, 2:(num_Male_total + 1)]          #stat features
Name_data1_Female = Name_file1[3:212, (num_Male_total + 2):(num_Male_total+num_Female_total+1)]  #stat features
}

if(num_feat == 84){
Name_file1 = read.csv("Your_Path/NKI_Rockland/Name_NKI_Rockland_gender_sorted_51to60_DevFeautres_1.csv")
Name_data1_Male = Name_file1[3:86, 2:(num_Male_total + 1)]          #deviation-based features
Name_data1_Female = Name_file1[3:86, (num_Male_total + 2):(num_Male_total+num_Female_total+1)]  #deviation-based features
}

if(num_feat == 861){
Name_file1 = read.csv("Your_Path/NKI_Rockland/matrix_ROI_CCs_per_subjects_NKI_Rockland_51to60_1.csv")
Name_data1_Male = Name_file1[3:863, 2:(num_Male_total + 1)]          # CC features
Name_data1_Female = Name_file1[3:863, (num_Male_total + 2):(num_Male_total+num_Female_total+1)]   # CC features
}
}

if(my_condition == 5){
num_Male_total = 13
num_Female_total = 32

if(num_feat == 294){
Name_file1 = read.csv("Your_Path/NKI_Rockland/Name_NKI_Rockland_gender_sorted_61to70_AllFeautres_1.csv")
Name_data1_Male = Name_file1[3:296, 2:(num_Male_total + 1)]          #this is the full set of features
Name_data1_Female = Name_file1[3:296, (num_Male_total + 2):(num_Male_total+num_Female_total+1)]  #this is the full set of features
}

if(num_feat == 210){
Name_file1 = read.csv("Your_Path/NKI_Rockland/Name_NKI_Rockland_gender_sorted_61to70_StatFeautres_1.csv")
Name_data1_Male = Name_file1[3:212, 2:(num_Male_total + 1)]           #stat features
Name_data1_Female = Name_file1[3:212, (num_Male_total + 2):(num_Male_total+num_Female_total+1)]  #stat features
}

if(num_feat == 84){
Name_file1 = read.csv("Your_Path/NKI_Rockland/Name_NKI_Rockland_gender_sorted_61to70_DevFeautres_1.csv")
Name_data1_Male = Name_file1[3:86, 2:(num_Male_total + 1)]         #deviation-based features
Name_data1_Female = Name_file1[3:86, (num_Male_total + 2):(num_Male_total+num_Female_total+1)]  #deviation-based features
}

if(num_feat == 861){
Name_file1 = read.csv("Your_Path/NKI_Rockland/matrix_ROI_CCs_per_subjects_NKI_Rockland_61to70_1.csv")
Name_data1_Male = Name_file1[3:863, 2:(num_Male_total + 1)]           # CC features
Name_data1_Female = Name_file1[3:863, (num_Male_total + 2):(num_Male_total+num_Female_total+1)]      # CC features
}
}

if(my_condition == 6){
num_Male_total = 11
num_Female_total = 21

if(num_feat == 294){
Name_file1 = read.csv("Your_Path/NKI_Rockland/Name_NKI_Rockland_gender_sorted_71plus_AllFeautres_1.csv")
Name_data1_Male = Name_file1[3:296, 2:(num_Male_total + 1)]          #this is the full set of features
Name_data1_Female = Name_file1[3:296, (num_Male_total + 2):(num_Male_total+num_Female_total+1)]  #this is the full set of features
}

if(num_feat == 210){
Name_file1 = read.csv("Your_Path/NKI_Rockland/Name_NKI_Rockland_gender_sorted_71plus_StatFeautres_1.csv")
Name_data1_Male = Name_file1[3:212, 2:(num_Male_total + 1)]          #stat features
Name_data1_Female = Name_file1[3:212, (num_Male_total + 2):(num_Male_total+num_Female_total+1)]  #stat features
}

if(num_feat == 84){
Name_file1 = read.csv("Your_Path/NKI_Rockland/Name_NKI_Rockland_gender_sorted_71plus_DevFeautres_1.csv")
Name_data1_Male = Name_file1[3:86, 2:(num_Male_total + 1)]          #deviation-based features
Name_data1_Female = Name_file1[3:86, (num_Male_total + 2):(num_Male_total+num_Female_total+1)]  #deviation-based features
}

if(num_feat == 861){
Name_file1 = read.csv("Your_Path/NKI_Rockland/matrix_ROI_CCs_per_subjects_NKI_Rockland_71plus_1.csv")
Name_data1_Male = Name_file1[3:863, 2:(num_Male_total + 1)]            # CC features
Name_data1_Female = Name_file1[3:863, (num_Male_total + 2):(num_Male_total+num_Female_total+1)]      # CC features
}
}


Name_data1_MaleFemale = cbind(Name_data1_Male, Name_data1_Female)
num_subj = dim(Name_data1_MaleFemale)[2]

Name_data1_MaleFemale_2 <- matrix(0, dim(Name_data1_MaleFemale)[1], dim(Name_data1_MaleFemale)[2])


################# shuffling portion (begin) #################
if(shuffle == 1){

subj_idx1 = 1

while(subj_idx1 <= num_subj)
{

shuffle_indices1 = sample.int(Num_ROI, Num_ROI)  # generate rand vector of integers from 1 to Num_ROI.

shuffle_idx1 = 1
range3 = 1
range4 = (num_feat/Num_ROI)

while(shuffle_idx1 <= Num_ROI)
{

range1 = ((shuffle_indices1[shuffle_idx1])*((num_feat/Num_ROI))) + 1 - (num_feat/Num_ROI)
range2 = range1 + (num_feat/Num_ROI) - 1 
temp_ROI_of_subj = Name_data1_MaleFemale[range1:range2, subj_idx1]

Name_data1_MaleFemale_2[range3:range4, subj_idx1] = temp_ROI_of_subj

range3 = range3 + (num_feat/Num_ROI)
range4 = range3 + (num_feat/Num_ROI) - 1

shuffle_idx1 = shuffle_idx1 + 1
}

subj_idx1 = subj_idx1 + 1

}  #end of while loop from 1 to num_subj

} #end of if-condition for shuffle


if(shuffle == 0){
Name_data1_MaleFemale_2 = Name_data1_MaleFemale
}
################# shuffling portion (end) ################# 

num_for_test = (min(num_Female_total, num_Male_total) - 1) * 2

y_label = c(rep(1, num_for_test/2), rep(-1, num_for_test/2))

total_loop1 = 1000
#total_loop1 = 100
#total_loop1 = 10
#total_loop1 = 1

idx_of_loop = 1
correct_Female = 0
correct_Male = 0


while(idx_of_loop <= total_loop1){       # outer-most while-loop for leave-one-out analysis

#Male vs. Female : train on "min(num_Female_total, num_Male_total) - 1" from Male and "min(num_Female_total, num_Male_total) - 1" from Female

Male_indices = sample.int(num_Male_total, num_Male_total)
Female_indices = num_Male_total + sample.int(num_Female_total, num_Female_total)

train_indices = c(Male_indices[1:(min(num_Female_total, num_Male_total) - 1)], Female_indices[1: (min(num_Female_total, num_Male_total) - 1)])

test_Male_idx = Male_indices[min(num_Female_total, num_Male_total)]
test_Female_idx = Female_indices[min(num_Female_total, num_Male_total)]

k2=1 

# make a matrix of zeros just to initiate "xmat1" for the training data 

x_train_mat1 <- matrix(0, num_feat, length(train_indices))


Name_data1_MaleFemale_3 <- matrix(unlist(Name_data1_MaleFemale_2), ncol = num_subj, byrow = FALSE)
#necessary to convert: list to matrix 

while(k2 <= length(train_indices)){
k3=1
  while(k3 <= num_feat){
  x_train_mat1[k3, k2] = Name_data1_MaleFemale_3[(k3),(train_indices[k2])]
  k3 = k3 + 1
  }
 k2 = k2 + 1
}

######### Set up the training and test matrices for both the data and the labels (begin) #########

#xtrain <- xmat1
xtest_Male <- Name_data1_MaleFemale_3[,test_Male_idx]
xtest_Female <- Name_data1_MaleFemale_3[,test_Female_idx]

ylabel_Male = 1
ylabel_Female = -1

######### Set up the training and test matrices for both the data and the labels (end) #########

############# Train the SVM with the training data ############# 

class(x_train_mat1) <- "numeric"      # convert the guy who is not "atomic" into "atomic" via this command

svp <- ksvm(t(x_train_mat1), y_label, type="C-svc", kernel='vanilladot', C=60, scaled=c())     #linear kernel

############# Predict labels on test data ############# 

class(xtest_Male) <- "numeric"      # convert the guy who is not "atomic" into "atomic" via this command
class(xtest_Female) <- "numeric"      # convert the guy who is not "atomic" into "atomic" via this command

ypred_Male = predict(svp, t(xtest_Male))

ypred_Female = predict(svp, t(xtest_Female))


if(ypred_Male == ylabel_Male){ 
correct_Male = correct_Male + 1  }

if(ypred_Female == ylabel_Female){ 
correct_Female = correct_Female + 1  }

printf("idx_of_loop =%f", idx_of_loop) 
printf("test_Male_idx=%f  test_Female_idx=%f", test_Male_idx, test_Female_idx)
printf("ypred_Male=%f  ypred_Female=%f", ypred_Male, ypred_Female)
printf("correct_Male=%f  correct_Female=%f", correct_Male, correct_Female)
cat("\n")

rm(ypred_Male, svp, ypred_Female, xtest_Male, xtest_Female, x_train_mat1)   # remove these vars form memory so you can set it anew for the next subject

idx_of_loop = idx_of_loop + 1
 
}        # outer-most while-loop 

printf("my_condition=%f,  num_feat=%f", my_condition, num_feat) 
printf("num_Male_total=%d   num_Female_total=%d", num_Male_total, num_Female_total)
printf("correct_Male=%d   correct_Female=%d", correct_Male, correct_Female)
