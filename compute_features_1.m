
%--------------------pick file (begin)------------------------ 

Name_myDir_1 = 'Your_Directory'
pathSam1 = 'Your_Path' 
Name_myFiles_1 = dir(fullfile(pathSam1,'*.mat'));      %the data from the recordings were in .mat files

%--------------------pick file (end)------------------------ 

file_idx =1;

while(file_idx <= length(Name_myFiles_1))

baseFileName = Name_myFiles_1(file_idx).name;

[pathstr11, name11, ext11] = fileparts(baseFileName);

entire_fileSam1 = strcat(pathSam1, baseFileName)

x1 = load(entire_fileSam1)


A11 = x1.TC;

[n_time_points, ROI_idx_max] = size(A11)


num_features = 7;   %total number of features computed per ROI

metrics_mat_1 = zeros(num_features, ROI_idx_max);

ROI_idx = 1;    %ROI index starts at 1

while(ROI_idx <= ROI_idx_max)

A22 = A11(:, ROI_idx);


%==============================================================================================
mean_vector_pre = mean(A22)
var_vector_pre = var(A22)
median_vector_pre = median(A22)   

min_vector_pre = min(A22)
max_vector_pre = max(A22)

%------------------------------Compute "events" here (begin)------------------------------
event_feat_1 = (A22 - mean_vector_pre)/(sqrt(var_vector_pre));

thresh_zscore_high = 2
thresh_zscore_low = -2

num_above_events_feat = sum(event_feat_1 >= thresh_zscore_high);  %the element (1) here means the feature #1 from the "features_matrix1_pre" formed above, i.e. theta
num_below_events_feat = sum(event_feat_1 <= thresh_zscore_low);


num_below_events_feat
num_above_events_feat
%------------------------------Compute "events" here (end)--------------------------------

metrics_mat_1(:, ROI_idx) = [mean_vector_pre', var_vector_pre', median_vector_pre', min_vector_pre', max_vector_pre', num_below_events_feat, num_above_events_feat];

clear A22

ROI_idx = ROI_idx + 1;

end

%these 3 lines are for the write part at the end of this code: 
write_file_name_Sam1 = strcat(name11, '.xls')
entire_write_fileSam1 = strcat('metrics_for_', write_file_name_Sam1)
path_with_entire_write_fileSam1 = strcat(pathSam1, entire_write_fileSam1)

xlswrite(path_with_entire_write_fileSam1, metrics_mat_1)

file_idx = file_idx + 1
end
