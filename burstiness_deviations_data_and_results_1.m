%plotting the results attained from counting all NDs (aka # of deviations, aka # of paroxysmal events) among the 42 ROIs of subjects
%considered -2 sigma and 2 sigma points

%age groups:
%21-30: 458 
%31-40: 85 
%41-50: 119 
%51-60: 119 
%61-70: 67 
%(71+ : 39)
%71-80: 31 
%81+ : 8 


%================================= t-test for all subjects (begin) ================================= 
%do 2-sample t-test to compare all age groups to 21-to-30 group to see if changes are significant

devs_low_21to30 = [144	101	87	96	119	106	74	83	117	102	125	109	154	120	196	82	77	205	140	116	186	213	235	152	93	105	181	91	194	184	187	195	168	211	94	196	166	94	101	202	89	141	83	199	154	88	207	82	200	102	211	189	185	99	110	135	216	116	223	187	191	231	173	188	203	107	223	108	190	120	91	171	233	187	194	211	182	90	202	196	103	108	201	118	108	113	176	91	105	196	113	166	89	114	222	189	197	184	210	90	228	187	155	212	118	91	170	206	89	129	141	131	137	138	102	118	100	90	106	101	98	103	114	95	114	191	119	179	198	130	116	175	204	99	112	66	113	97	235	205	97	204	234	177	179	210	154	212	82	199	222	113	131	195	165	112	208	168	98	119	225	183	125	89	119	200	197	105	106	99	100	193	239	109	188	206	152	194	122	188	175	134	77	147	147	146	125	145	116	119	88	107	99	90	134	115	113	115	103	87	103	101	157	194	122	188	97	186	106	107	97	181	95	199	162	183	188	109	205	167	115	100	159	197	216	193	185	221	124	241	162	96	170	91	87	104	165	203	121	127	84	92	197	162	106	119	91	210	91	199	88	217	191	150	196	188	76	122	198	203	237	225	87	251	212	133	142	140	122	115	117	116	102	101	111	91	90	87	194	199	100	201	184	205	94	191	108	126	94	215	116	111	177	193	172	171	212	204	179	160	229	184	91	197	181	145	185	74	213	113	108	111	114	94	95	202	102	105	146	186	87	205	203	97	179	193	97	162	178	172	103	196	168	211	143	148	109	116	193	187	118	109	129	136	113	118	122	118	121	117	166	151	76	109	209	79	110	194	150	109	169	91	152	106	102	209	198	97	192	162	110	112	119	201	165	87	149	116	161	94	231	160	221	105	156	122	129	141	99	111	100	119	141	174	183	107	102	189	175	166	214	105	187	209	129	163	110	156	108	131	146	120	101	113	97	193	178	95	113	176	106	118	120	186	117	163	119	169	110	162	84	119	79	157	97	164	117	213	191	160	171	106	235	107	149	127	139	119	112	128	113	84	146	193	181	94	208	109]; 
devs_high_21to30 = [148	109	127	125	95	110	142	127	134	130	108	123	115	135	207	134	134	196	241	120	223	192	194	212	120	118	249	115	239	228	233	239	226	221	120	240	207	114	124	233	128	94	118	217	237	131	210	131	220	117	246	227	233	110	109	100	202	104	237	234	258	204	212	239	214	95	210	115	220	105	129	233	171	218	223	200	223	130	225	212	128	112	188	106	120	109	234	114	126	214	99	201	131	97	226	245	253	242	249	115	219	234	188	186	117	121	210	216	126	145	158	152	152	90	130	106	144	130	109	136	125	99	124	115	105	206	102	200	236	98	129	221	240	122	94	153	108	130	197	226	104	219	186	222	252	230	273	202	124	200	189	115	203	214	231	106	210	210	114	110	213	228	105	127	127	239	227	135	96	125	112	240	172	118	230	211	247	245	112	241	239	114	133	229	198	151	160	138	114	105	132	108	137	134	119	100	110	108	151	132	132	124	211	212	106	227	98	201	93	125	105	213	135	196	209	183	230	115	215	180	103	122	184	189	210	176	236	219	122	201	232	103	176	124	111	124	196	220	103	99	155	103	234	275	108	107	126	211	130	186	129	244	235	231	192	211	142	132	199	168	210	218	129	210	192	113	169	154	179	170	98	122	113	137	118	113	122	127	231	244	107	217	216	202	132	185	132	112	133	202	124	130	173	246	246	186	193	207	211	202	214	221	112	246	212	215	227	128	214	175	120	121	107	151	119	199	132	125	149	202	130	213	197	135	200	221	120	209	226	205	109	216	211	234	204	187	127	122	190	188	162	174	164	160	107	128	114	111	87	114	208	195	120	155	222	130	122	170	198	118	229	119	227	109	145	207	223	116	220	138	118	118	124	161	171	122	220	137	171	119	208	218	211	151	272	150	144	136	107	107	129	124	231	222	202	112	110	196	192	210	203	125	213	184	113	212	138	208	124	152	149	114	126	114	112	175	195	143	150	207	138	114	115	171	134	164	237	225	110	212	134	108	122	187	117	174	206	208	182	153	158	136	213	113	175	145	144	197	109	122	123	139	212	250	183	150	196	138]; 
devs_total_21to30 = devs_low_21to30 + devs_high_21to30;

devs_low_31to40 = [118	130	117	108	102	90	176	191	170	165	204	194	138	181	93	118	104	210	170	169	180	209	119	161	104	93	176	154	96	202	108	140	116	104	113	89	98	169	222	178	177	159	158	149	159	134	159	89	96	181	123	133	90	115	146	123	139	112	98	104	89	183	139	169	134	137	100	125	213	149	167	139	89	114	122	85	109	209	152	137	131	105	106	162	169]; 
devs_high_31to40 = [135	150	157	107	116	142	202	201	203	211	176	235	170	204	125	110	136	236	183	193	196	186	147	126	108	116	215	204	138	261	138	160	146	107	129	127	107	188	219	174	176	204	161	220	189	150	132	124	122	170	177	148	103	108	161	111	164	96	126	118	116	182	218	198	144	173	140	98	231	172	131	166	123	128	119	136	117	257	211	146	149	118	129	199	180]; 
devs_total_31to40 = devs_low_31to40 + devs_high_31to40;

devs_low_41to50 = [89	116	139	113	107	103	208	193	206	112	132	98	107	104	111	104	110	262	112	109	110	105	102	142	119	128	131	108	97	93	106	118	121	108	99	112	143	124	175	92	141	121	103	82	111	121	126	171	105	102	101	109	120	92	103	122	223	176	186	166	225	125	110	126	128	105	114	111	117	121	102	95	105	161	190	146	155	141	133	116	123	79	119	115	102	112	160	151	199	161	118	107	93	96	97	128	111	112	108	106	98	112	107	99	89	156	135	147	178	116	120	121	104	113	97	121	104	110	168]; 
devs_high_41to50  = [137	115	119	110	119	102	229	182	175	124	156	103	124	144	94	126	128	179	148	141	133	96	127	166	126	131	147	149	103	107	131	112	115	114	111	112	175	207	178	148	182	88	109	125	129	98	116	177	128	148	136	123	103	122	121	82	212	181	160	147	235	174	178	152	131	134	110	138	116	106	102	133	129	192	134	172	156	183	156	151	143	144	104	99	129	103	170	187	186	166	126	127	119	133	131	103	108	119	89	102	103	109	113	125	129	203	179	218	161	154	121	101	128	125	116	120	131	130	153]; 
devs_total_41to50 = devs_low_41to50 + devs_high_41to50;

devs_low_51to60 = [87	114	127	111	99	102	119	106	136	168	170	132	106	106	90	125	125	103	130	108	159	134	135	122	165	149	114	114	113	103	93	115	122	109	107	92	93	157	148	181	143	157	156	106	149	218	121	104	106	99	110	108	117	148	159	175	148	135	100	102	104	114	111	160	117	121	125	90	110	93	96	93	165	106	97	95	115	121	91	104	196	141	150	145	151	102	133	143	139	102	98	84	106	99	115	95	102	167	98	195	145	100	96	110	94	103	118	109	103	103	106	92	99	115	112	122	100	100	108]; 
devs_high_51to60  = [122	114	107	138	122	128	101	104	186	156	166	159	155	97	128	127	95	119	112	111	167	182	173	92	169	166	125	169	138	111	121	115	124	107	123	143	136	183	173	175	175	182	183	132	145	171	161	132	114	127	110	126	190	175	161	195	157	99	114	128	112	133	110	169	135	98	99	132	110	99	100	122	173	121	96	113	124	135	112	102	167	171	165	189	173	133	110	132	158	127	105	146	115	107	112	113	120	165	97	154	203	106	124	122	123	125	93	120	129	141	125	112	118	113	116	124	113	127	130]; 
devs_total_51to60 = devs_low_51to60 + devs_high_51to60;

devs_low_61to70 = [129	106	80	112	102	113	154	182	143	78	90	122	117	83	100	118	114	94	122	154	143	76	142	81	103	71	181	80	106	122	116	106	109	101	62	51	101	75	138	136	96	99	95	110	99	92	106	104	78	94	99	71	128	68	61	119	111	103	100	98	99	96	82	88	79	66	52]; 
devs_high_61to70  = [107	116	114	119	112	126	169	143	146	143	135	119	117	135	115	107	115	140	124	185	170	65	198	117	110	71	141	128	116	149	110	107	138	115	54	76	107	76	198	196	120	130	123	109	116	135	106	126	131	132	138	122	96	67	58	130	119	125	118	138	102	127	130	127	140	71	70]; 
devs_total_61to70 = devs_low_61to70 + devs_high_61to70;

devs_low_71plus = [109	94	103	94	103	80	106	95	77	111	60	70	67	60	116	108	97	119	112	104	125	103	102	119	103	121	132	108	110	107	119  79	112	112	109	83	91	107	107]; 
devs_high_71plus   = [126	112	112	146	111	69	105	124	124	110	75	69	70	73	94	112	136	123	123	118	108	102	107	137	113	130	92	120	109	136	133  139  104  113  140  138  122  109  110]; 
devs_total_71plus  = devs_low_71plus + devs_high_71plus;


[h_21to30_vs_31to40_low, p_21to30_vs_31to40_low] = ttest2(devs_low_21to30, devs_low_31to40, 'Vartype', 'unequal')
[h_21to30_vs_31to40_high, p_21to30_vs_31to40_high] = ttest2(devs_high_21to30, devs_high_31to40, 'Vartype', 'unequal')
[h_21to30_vs_31to40_total, p_21to30_vs_31to40_total] = ttest2(devs_total_21to30, devs_total_31to40, 'Vartype', 'unequal')

[h_21to30_vs_41to50_low, p_21to30_vs_41to50_low] = ttest2(devs_low_21to30, devs_low_41to50, 'Vartype', 'unequal')
[h_21to30_vs_41to50_high, p_21to30_vs_41to50_high] = ttest2(devs_high_21to30, devs_high_41to50, 'Vartype', 'unequal') 
[h_21to30_vs_41to50_total, p_21to30_vs_41to50_total] = ttest2(devs_total_21to30, devs_total_41to50, 'Vartype', 'unequal') 

[h_21to30_vs_51to60_low, p_21to30_vs_51to60_low] = ttest2(devs_low_21to30, devs_low_51to60, 'Vartype', 'unequal')
[h_21to30_vs_51to60_high, p_21to30_vs_51to60_high] = ttest2(devs_high_21to30, devs_high_51to60, 'Vartype', 'unequal')
[h_21to30_vs_51to60_total, p_21to30_vs_51to60_total] = ttest2(devs_total_21to30, devs_total_51to60, 'Vartype', 'unequal')

[h_21to30_vs_61to70_low, p_21to30_vs_61to70_low] = ttest2(devs_low_21to30, devs_low_61to70, 'Vartype', 'unequal')
[h_21to30_vs_61to70_high, p_21to30_vs_61to70_high] = ttest2(devs_high_21to30, devs_high_61to70, 'Vartype', 'unequal')
[h_21to30_vs_61to70_total, p_21to30_vs_61to70_total] = ttest2(devs_total_21to30, devs_total_61to70, 'Vartype', 'unequal')

[h_21to30_vs_71plus_low, p_21to30_vs_71plus_low] = ttest2(devs_low_21to30, devs_low_71plus, 'Vartype', 'unequal')
[h_21to30_vs_71plus_high, p_21to30_vs_71plus_high] = ttest2(devs_high_21to30, devs_high_71plus, 'Vartype', 'unequal')
[h_21to30_vs_71plus_total, p_21to30_vs_71plus_total] = ttest2(devs_total_21to30, devs_total_71plus, 'Vartype', 'unequal')
%================================= t-test for all subjects (end) ==================================


group2130_low_mean = mean(devs_low_21to30); 
group2130_high_mean = mean(devs_high_21to30); 
group2130_mean_total = mean(devs_total_21to30); 

group3140_low_mean = mean(devs_low_31to40); 
group3140_high_mean = mean(devs_high_31to40); 
group3140_mean_total = mean(devs_total_31to40); 

group4150_low_mean = mean(devs_low_41to50); 
group4150_high_mean = mean(devs_high_41to50); 
group4150_mean_total = mean(devs_total_41to50); 

group5160_low_mean = mean(devs_low_51to60); 
group5160_high_mean = mean(devs_high_51to60); 
group5160_mean_total = mean(devs_total_51to60); 

group6170_low_mean = mean(devs_low_61to70); 
group6170_high_mean = mean(devs_high_61to70); 
group6170_mean_total = mean(devs_total_61to70); 

group71plus_low_mean = mean(devs_low_71plus); 
group71plus_high_mean = mean(devs_high_71plus); 
group71plus_mean_total = mean(devs_total_71plus); 


group2130_low_var = var(devs_low_21to30); 
group2130_high_var = var(devs_high_21to30); 
group2130_var_total = var(devs_total_21to30); 

group3140_low_var = var(devs_low_31to40); 
group3140_high_var = var(devs_high_31to40); 
group3140_var_total = var(devs_total_31to40); 

group4150_low_var = var(devs_low_41to50); 
group4150_high_var = var(devs_high_41to50); 
group4150_var_total = var(devs_total_41to50); 

group5160_low_var = var(devs_low_51to60); 
group5160_high_var = var(devs_high_51to60); 
group5160_var_total = var(devs_total_51to60); 

group6170_low_var = var(devs_low_61to70); 
group6170_high_var = var(devs_high_61to70); 
group6170_var_total = var(devs_total_61to70); 

group71plus_low_var = var(devs_low_71plus); 
group71plus_high_var = var(devs_high_71plus); 
group71plus_var_total = var(devs_total_71plus); 


x1_mean = [group2130_mean_total  group2130_high_mean  group2130_low_mean;  group3140_mean_total  group3140_high_mean  group3140_low_mean;  group4150_mean_total  group4150_high_mean  group4150_low_mean;  group5160_mean_total  group5160_high_mean  group5160_low_mean;  group6170_mean_total  group6170_high_mean  group6170_low_mean;  group71plus_mean_total  group71plus_high_mean  group71plus_low_mean]; 
x1_var = [group2130_var_total  group2130_high_var  group2130_low_var;  group3140_var_total  group3140_high_var  group3140_low_var;  group4150_var_total  group4150_high_var  group4150_low_var;  group5160_var_total  group5160_high_var  group5160_low_var;  group6170_var_total  group6170_high_var  group6170_low_var;  group71plus_var_total  group71plus_high_var  group71plus_low_var]; 

figure(1)
str1 = {'21-30', '31-40', '41-50', '51-60', '61-70', '71+'};
%str1 = {'21-30 (458)', '31-40 (85)', '41-50 (119)', '51-60 (119)', '61-70 (67)', '71-80 (31)', '81+ (8)'};
bar(x1_mean);
%bar(x1_mean, 0.5);
%ylim([0 1]);
title('All subjects');
ylabel('# of deviations'); 
xlabel('Age group'); 
set(gca, 'XTickLabel',str1, 'XTick',1:numel(str1));
legend('total', 'high', 'low');

%=================== this is how you add s.d. bars to the above plot (begin) ===================
%{
hold on

model_series = x1_mean; 
%model_error = 0.2*x1_mean;
model_error = sqrt(x1_var);
% Find the number of groups and the number of bars in each group
[ngroups, nbars] = size(model_series);

% Calculate the width for each bar group
groupwidth = min(0.8, nbars/(nbars + 1.5));

% Set the position of each error bar in the centre of the main bar
% Based on barweb.m by Bolu Ajiboye from MATLAB File Exchange
for i = 1:nbars
    % Calculate center of each bar
    x = (1:ngroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*nbars);
    errorbar(x, model_series(:,i), model_error(:,i), 'k', 'linestyle', 'none');
end
hold off
%}
%=================== this is how you add s.d. bars to the above plot (end) ===================

x1_sd = sqrt(x1_var);
figure(2)
str1 = {'21-30', '31-40', '41-50', '51-60', '61-70','71+'};
bar(x1_sd);
title('All subjects');
ylabel('s.d. of # of deviations'); 
xlabel('Age group'); 
set(gca, 'XTickLabel',str1, 'XTick',1:numel(str1));
legend('total', 'high', 'low');


%================================= t-test for male subjects (begin) ================================= 
%do 2-sample t-test to compare all age groups to 21-to-30 group to see if changes are significant

devs_low_male_21to30 = [101	96	83	102	109	154	77	140	213	152	181	91	184	94	94	89	154	207	82	189	99	135	216	223	191	173	188	203	107	223	190	120	233	211	182	90	196	108	118	113	176	91	196	114	189	197	184	210	90	228	206	129	131	137	138	102	100	90	106	103	95	119	130	66	113	235	97	177	154	212	82	131	165	183	106	100	193	188	122	175	134	77	147	147	146	125	145	116	119	107	134	115	115	103	87	194	188	97	106	107	97	162	183	188	159	197	216	124	241	96	165	84	91	199	217	191	150	122	203	225	87	122	117	101	111	199	100	201	184	205	94	215	177	204	179	145	74	213	113	111	94	102	146	186	203	97	179	193	97	162	178	172	196	143	109	116	193	187	118	109	129	136	118	118	121	117	166	109	102	162	165	231	160	105	129	141	100	119	141	107	175	214	105	187	209	129	110	108	131	120	101	113	97	113	106	186	163	119	169	110	162	84	119	97	164	117	213	160	171	127	139	113	146	181	94]; 
devs_high_male_21to30 = [109 125	127	130	123	115	134	241	192	212	249	115	228	120	114	128	237	210	131	227	110	100	202	237	258	212	239	214	95	210	220	105	171	200	223	130	212	112	106	109	234	114	214	97	245	253	242	249	115	219	216	145	152	152	90	130	144	130	109	99	115	102	98	153	108	197	104	222	273	202	124	203	231	228	96	112	240	230	112	239	114	133	229	198	151	160	138	114	105	108	119	100	108	151	132	212	227	98	93	125	105	209	183	230	184	189	210	122	201	103	196	155	126	186	244	235	231	132	168	218	129	179	98	137	118	244	107	217	216	202	132	202	173	207	211	215	128	214	175	121	151	132	149	202	197	135	200	221	120	209	226	205	216	204	127	122	190	188	162	174	164	160	128	111	87	114	208	118	145	138	171	208	218	151	144	136	129	124	231	112	192	203	125	213	184	113	138	124	152	114	126	114	112	150	138	171	164	237	225	110	212	134	108	117	174	206	208	153	158	145	144	123	212	183	150]; 
devs_total_male_21to30 = devs_low_male_21to30 + devs_high_male_21to30; 

devs_low_male_31to40 = [118	117	108	176	191	170	165	204	93	118	170	169	119	104	176	108	140	116	98	169	222	178	177	158	149	134	96	123	133	146	123	139	98	139	134	137	100	149	167	139	85	209	152	169]; 
devs_high_male_31to40 = [135	157	107	202	201	203	211	176	125	110	183	193	147	108	215	138	160	146	107	188	219	174	176	161	220	150	122	177	148	161	111	164	126	218	144	173	140	172	131	166	136	257	211	180]; 
devs_total_male_31to40 = devs_low_male_31to40 + devs_high_male_31to40; 

devs_low_male_41to50 = [89	139	206	132	107	104	112	102	142	128	131	97	93	143	175	141	82	111	102	176	186	125	110	128	114	121	190	155	141	133	116	123	160	98	156	116	121	104	97	110]; 
devs_high_male_41to50 = [137	119	175	156	124	126	148	127	166	131	147	103	107	175	178	182	125	129	148	181	160	174	178	131	110	106	134	156	183	156	151	143	170	103	203	154	101	128	116	130]; 
devs_total_male_41to50 = devs_low_male_41to50 + devs_high_male_41to50; 

devs_low_male_51to60 = [127	111	102	132	106	134	135	122	103	93	157	156	149	218	121	148	159	100	114	111	160	110	93	104	196	141	150	145	143	99	98	195	145	100	96	110	118	109]; 
devs_high_male_51to60 = [107	138	128	159	155	182	173	92	111	136	182	183	145	171	161	175	161	114	133	110	169	110	122	102	167	171	165	189	132	107	97	154	203	106	124	122	93	120]; 
devs_total_male_51to60 = devs_low_male_51to60 + devs_high_male_51to60; 

devs_low_male_61to70 = [112	113	143	90	81	71	106	122	62	51	75	96	99	106	94	128	100	99	96	79	66	52]; 
devs_high_male_61to70 = [119	126	146	135	117	71	116	149	54	76	76	120	116	106	132	96	118	102	127	140	71	70]; 
devs_total_male_61to70 = devs_low_male_61to70 + devs_high_male_61to70; 

devs_low_male_71plus = [94	60	67	60	116	108	112	102	103	132	107	119  139  140]; 
devs_high_male_71plus = [146	75	70	73	94	112	123	107	113	92	136	133  79  109]; 
devs_total_male_71plus = devs_low_male_71plus + devs_high_male_71plus;

[h_21to30_vs_31to40_low_male, p_21to30_vs_31to40_low_male] = ttest2(devs_low_male_21to30, devs_low_male_31to40, 'Vartype', 'unequal')
[h_21to30_vs_31to40_high_male, p_21to30_vs_31to40_high_male] = ttest2(devs_high_male_21to30, devs_high_male_31to40, 'Vartype', 'unequal')
[h_21to30_vs_31to40_total_male, p_21to30_vs_31to40_total_male] = ttest2(devs_total_male_21to30, devs_total_male_31to40, 'Vartype', 'unequal')

[h_21to30_vs_41to50_low_male, p_21to30_vs_41to50_low_male] = ttest2(devs_low_male_21to30, devs_low_male_41to50, 'Vartype', 'unequal')
[h_21to30_vs_41to50_high_male, p_21to30_vs_41to50_high_male] = ttest2(devs_high_male_21to30, devs_high_male_41to50, 'Vartype', 'unequal') 
[h_21to30_vs_41to50_total_male, p_21to30_vs_41to50_total_male] = ttest2(devs_total_male_21to30, devs_total_male_41to50, 'Vartype', 'unequal') 

[h_21to30_vs_51to60_low_male, p_21to30_vs_51to60_low_male] = ttest2(devs_low_male_21to30, devs_low_male_51to60, 'Vartype', 'unequal')
[h_21to30_vs_51to60_high_male, p_21to30_vs_51to60_high_male] = ttest2(devs_high_male_21to30, devs_high_male_51to60, 'Vartype', 'unequal')
[h_21to30_vs_51to60_total_male, p_21to30_vs_51to60_total_male] = ttest2(devs_total_male_21to30, devs_total_male_51to60, 'Vartype', 'unequal')

[h_21to30_vs_61to70_low_male, p_21to30_vs_61to70_low_male] = ttest2(devs_low_male_21to30, devs_low_male_61to70, 'Vartype', 'unequal')
[h_21to30_vs_61to70_high_male, p_21to30_vs_61to70_high_male] = ttest2(devs_high_male_21to30, devs_high_male_61to70, 'Vartype', 'unequal')
[h_21to30_vs_61to70_total_male, p_21to30_vs_61to70_total_male] = ttest2(devs_total_male_21to30, devs_total_male_61to70, 'Vartype', 'unequal')

[h_21to30_vs_71plus_low_male, p_21to30_vs_71plus_low_male] = ttest2(devs_low_male_21to30, devs_low_male_71plus, 'Vartype', 'unequal')
[h_21to30_vs_71plus_high_male, p_21to30_vs_71plus_high_male] = ttest2(devs_high_male_21to30, devs_high_male_71plus, 'Vartype', 'unequal')
[h_21to30_vs_71plus_total_male, p_21to30_vs_71plus_total_male] = ttest2(devs_total_male_21to30, devs_total_male_71plus, 'Vartype', 'unequal')
%================================= t-test for male subjects (end) ==================================


group2130_mean_male_total = mean(devs_total_male_21to30); 
group2130_high_mean_male = mean(devs_high_male_21to30); 
group2130_low_mean_male = mean(devs_low_male_21to30); 

group3140_mean_male_total = mean(devs_total_male_31to40); 
group3140_high_mean_male = mean(devs_high_male_31to40);
group3140_low_mean_male = mean(devs_low_male_31to40);

group4150_mean_male_total = mean(devs_total_male_41to50);
group4150_high_mean_male = mean(devs_high_male_41to50);
group4150_low_mean_male = mean(devs_low_male_41to50);

group5160_mean_male_total = mean(devs_total_male_51to60); 
group5160_high_mean_male = mean(devs_high_male_51to60); 
group5160_low_mean_male = mean(devs_low_male_51to60); 

group6170_mean_male_total = mean(devs_total_male_61to70); 
group6170_high_mean_male = mean(devs_high_male_61to70); 
group6170_low_mean_male = mean(devs_low_male_61to70); 

group71plus_mean_male_total = mean(devs_total_male_71plus); 
group71plus_high_mean_male = mean(devs_high_male_71plus); 
group71plus_low_mean_male = mean(devs_low_male_71plus); 

group2130_var_male_total = var(devs_total_male_21to30); 
group2130_high_var_male = var(devs_high_male_21to30); 
group2130_low_var_male = var(devs_low_male_21to30); 

group3140_var_male_total = var(devs_total_male_31to40); 
group3140_high_var_male = var(devs_high_male_31to40);
group3140_low_var_male = var(devs_low_male_31to40);

group4150_var_male_total = var(devs_total_male_41to50);
group4150_high_var_male = var(devs_high_male_41to50);
group4150_low_var_male = var(devs_low_male_41to50);

group5160_var_male_total = var(devs_total_male_51to60); 
group5160_high_var_male = var(devs_high_male_51to60); 
group5160_low_var_male = var(devs_low_male_51to60); 

group6170_var_male_total = var(devs_total_male_61to70); 
group6170_high_var_male = var(devs_high_male_61to70); 
group6170_low_var_male = var(devs_low_male_61to70); 

group71plus_var_male_total = var(devs_total_male_71plus); 
group71plus_high_var_male = var(devs_high_male_71plus); 
group71plus_low_var_male = var(devs_low_male_71plus); 


x2_mean_male = [group2130_mean_male_total  group2130_high_mean_male  group2130_low_mean_male;  group3140_mean_male_total  group3140_high_mean_male  group3140_low_mean_male;  group4150_mean_male_total  group4150_high_mean_male  group4150_low_mean_male;  group5160_mean_male_total  group5160_high_mean_male  group5160_low_mean_male;  group6170_mean_male_total  group6170_high_mean_male  group6170_low_mean_male;  group71plus_mean_male_total  group71plus_high_mean_male  group71plus_low_mean_male]; 
x2_var_male = [group2130_var_male_total  group2130_high_var_male  group2130_low_var_male;  group3140_var_male_total  group3140_high_var_male  group3140_low_var_male;  group4150_var_male_total  group4150_high_var_male  group4150_low_var_male;  group5160_var_male_total  group5160_high_var_male  group5160_low_var_male;  group6170_var_male_total  group6170_high_var_male  group6170_low_var_male;  group71plus_var_male_total  group71plus_high_var_male  group71plus_low_var_male]; 

figure(3)
str1 = {'21-30', '31-40', '41-50', '51-60', '61-70', '71+'};
%str1 = {'21-30 (458)', '31-40 (85)', '41-50 (119)', '51-60 (119)', '61-70 (67)', '71-80 (31)', '81+ (8)'};
bar(x2_mean_male);
title('Male subjects');
ylabel('# of deviations '); 
xlabel('Age group'); 
set(gca, 'XTickLabel', str1,  'XTick', 1:numel(str1));
legend('total', 'high', 'low');

x2_sd_male = sqrt(x2_var_male);
figure(4)
str1 = {'21-30', '31-40', '41-50', '51-60', '61-70', '71+'};
bar(x2_sd_male);
title('Male subjects');
ylabel('s.d. of # of deviations'); 
xlabel('Age group'); 
set(gca, 'XTickLabel',str1, 'XTick',1:numel(str1));
legend('total', 'high', 'low');


%================================= t-test for female subjects (begin) ================================= 
%do 2-sample t-test to compare all age groups to 21-to-30 group to see if changes are significant

devs_low_female_21to30 = [144	87	119	106	74	117	125	120	196	82	205	116	186	235	93	105	194	187	195	168	211	196	166	101	202	141	83	199	88	200	102	211	185	110	116	187	231	108	91	171	187	194	202	103	201	108	105	113	166	89	222	187	155	212	118	91	170	89	141	118	101	98	114	114	191	179	198	116	175	204	99	112	97	205	204	234	179	210	199	222	113	195	112	208	168	98	119	225	125	89	119	200	197	105	99	239	109	206	152	194	188	88	99	90	113	103	101	157	122	186	181	95	199	109	205	167	115	100	193	185	221	162	170	91	87	104	203	121	127	92	197	162	106	119	210	91	88	196	188	76	198	237	251	212	133	142	140	115	116	102	91	90	87	194	191	108	126	94	116	111	193	172	171	212	160	229	184	91	197	181	185	108	114	95	202	105	87	205	103	168	211	148	113	122	151	76	109	209	79	110	194	150	169	91	152	106	209	198	97	192	110	112	119	201	87	149	116	161	94	221	156	122	99	111	174	183	102	189	166	163	156	146	193	178	95	176	118	120	117	79	157	191	106	235	107	149	119	112	128	84	193	208	109]; 
devs_high_female_21to30 = [148	127	95	110	142	134	108	135	207	134	196	120	223	194	120	118	239	233	239	226	221	240	207	124	233	94	118	217	131	220	117	246	233	109	104	234	204	115	129	233	218	223	225	128	188	120	126	99	201	131	226	234	188	186	117	121	210	126	158	106	136	125	124	105	206	200	236	129	221	240	122	94	130	226	219	186	252	230	200	189	115	214	106	210	210	114	110	213	105	127	127	239	227	135	125	172	118	211	247	245	241	132	137	134	110	132	124	211	106	201	213	135	196	115	215	180	103	122	176	236	219	232	176	124	111	124	220	103	99	103	234	275	108	107	211	130	129	192	211	142	199	210	210	192	113	169	154	170	122	113	113	122	127	231	185	132	112	133	124	130	246	246	186	193	202	214	221	112	246	212	227	120	107	119	199	125	130	213	109	211	234	187	107	114	195	120	155	222	130	122	170	198	229	119	227	109	207	223	116	220	118	118	124	161	122	220	137	171	119	211	272	150	107	107	222	202	110	196	210	212	208	149	175	195	143	207	114	115	134	122	187	182	136	213	113	175	197	109	122	139	250	196	138]; 
devs_total_female_21to30 = devs_low_female_21to30 + devs_high_female_21to30;

devs_low_female_31to40 = [130	102	90	194	138	181	104	210	180	209	161	93	154	96	202	104	113	89	159	159	159	89	181	90	115	112	104	89	183	169	125	213	89	114	122	109	137	131	105	106	162]; 
devs_high_female_31to40 = [150	116	142	235	170	204	136	236	196	186	126	116	204	138	261	107	129	127	204	189	132	124	170	103	108	96	118	116	182	198	98	231	123	128	119	117	146	149	118	129	199]; 
devs_total_female_31to40 = devs_low_female_31to40 + devs_high_female_31to40;

devs_low_female_41to50 = [116	113	107	103	208	193	112	98	104	111	110	262	109	110	105	119	108	106	118	121	108	99	112	124	92	121	103	121	126	171	105	101	109	120	92	103	122	223	166	225	126	105	111	117	102	95	105	161	146	79	119	115	102	112	151	199	161	118	107	93	96	97	128	111	112	108	106	112	107	99	89	135	147	178	120	113	121	104	168]; 
devs_high_female_41to50 = [115	110	119	102	229	182	124	103	144	94	128	179	141	133	96	126	149	131	112	115	114	111	112	207	148	88	109	98	116	177	128	136	123	103	122	121	82	212	147	235	152	134	138	116	102	133	129	192	172	144	104	99	129	103	187	186	166	126	127	119	133	131	103	108	119	89	102	109	113	125	129	179	218	161	121	125	120	131	153]; 
devs_total_female_41to50 = devs_low_female_41to50 + devs_high_female_41to50;

devs_low_female_51to60 = [87	114	99	119	106	136	168	170	106	90	125	125	103	130	108	159	165	149	114	114	113	93	115	122	109	107	92	157	148	181	143	106	104	106	99	110	108	117	175	148	135	102	104	117	121	125	90	93	96	165	106	97	95	115	121	91	151	102	133	139	102	98	84	106	115	95	102	167	94	103	103	103	106	92	99	115	112	122	100	100	108]; 
devs_high_female_51to60 = [122	114	122	101	104	186	156	166	97	128	127	95	119	112	111	167	169	166	125	169	138	121	115	124	107	123	143	183	173	175	175	132	132	114	127	110	126	190	195	157	99	128	112	135	98	99	132	99	100	173	121	96	113	124	135	112	173	133	110	158	127	105	146	115	112	113	120	165	123	125	129	141	125	112	118	113	116	124	113	127	130]; 
devs_total_female_51to60 = devs_low_female_51to60 + devs_high_female_51to60;

devs_low_female_61to70 = [129	106	80	102	154	182	78	122	117	83	100	118	114	94	122	154	143	76	142	103	181	80	116	106	109	101	101	138	136	99	95	110	92	104	78	99	71	68	61	119	111	103	98	82	88]; 
devs_high_female_61to70 = [107	116	114	112	169	143	143	119	117	135	115	107	115	140	124	185	170	65	198	110	141	128	110	107	138	115	107	198	196	130	123	109	135	126	131	138	122	67	58	130	119	125	138	130	127]; 
devs_total_female_61to70 = devs_low_female_61to70 + devs_high_female_61to70;

devs_low_female_71plus = [109	94	103	103	80	106	95	77	111	70	97	119	104	125	103	119	121	108	110  112	112	83	91	107	107]; 
devs_high_female_71plus = [126	112	112	111	69	105	124	124	110	69	136	123	118	108	102	137	130	120	109  104	113	138	122	109	110]; 
devs_total_female_71plus = devs_low_female_71plus + devs_high_female_71plus;


[h_21to30_vs_31to40_low_female, p_21to30_vs_31to40_low_female] = ttest2(devs_low_female_21to30, devs_low_female_31to40, 'Vartype', 'unequal')
[h_21to30_vs_31to40_high_female, p_21to30_vs_31to40_high_female] = ttest2(devs_high_female_21to30, devs_high_female_31to40, 'Vartype', 'unequal')
[h_21to30_vs_31to40_total_female, p_21to30_vs_31to40_total_female] = ttest2(devs_total_female_21to30, devs_total_female_31to40, 'Vartype', 'unequal')

[h_21to30_vs_41to50_low_female, p_21to30_vs_41to50_low_female] = ttest2(devs_low_female_21to30, devs_low_female_41to50, 'Vartype', 'unequal')
[h_21to30_vs_41to50_high_female, p_21to30_vs_41to50_high_female] = ttest2(devs_high_female_21to30, devs_high_female_41to50, 'Vartype', 'unequal') 
[h_21to30_vs_41to50_total_female, p_21to30_vs_41to50_total_female] = ttest2(devs_total_female_21to30, devs_total_female_41to50, 'Vartype', 'unequal') 

[h_21to30_vs_51to60_low_female, p_21to30_vs_51to60_low_female] = ttest2(devs_low_female_21to30, devs_low_female_51to60, 'Vartype', 'unequal')
[h_21to30_vs_51to60_high_female, p_21to30_vs_51to60_high_female] = ttest2(devs_high_female_21to30, devs_high_female_51to60, 'Vartype', 'unequal')
[h_21to30_vs_51to60_total_female, p_21to30_vs_51to60_total_female] = ttest2(devs_total_female_21to30, devs_total_female_51to60, 'Vartype', 'unequal')

[h_21to30_vs_61to70_low_female, p_21to30_vs_61to70_low_female] = ttest2(devs_low_female_21to30, devs_low_female_61to70, 'Vartype', 'unequal')
[h_21to30_vs_61to70_high_female, p_21to30_vs_61to70_high_female] = ttest2(devs_high_female_21to30, devs_high_female_61to70, 'Vartype', 'unequal')
[h_21to30_vs_61to70_total_female, p_21to30_vs_61to70_total_female] = ttest2(devs_total_female_21to30, devs_total_female_61to70, 'Vartype', 'unequal')

[h_21to30_vs_71plus_low_female, p_21to30_vs_71to80_low_female] = ttest2(devs_low_female_21to30, devs_low_female_71plus, 'Vartype', 'unequal')
[h_21to30_vs_71plus_high_female, p_21to30_vs_71to80_high_female] = ttest2(devs_high_female_21to30, devs_high_female_71plus, 'Vartype', 'unequal')
[h_21to30_vs_71plus_total_female, p_21to30_vs_71to80_total_female] = ttest2(devs_total_female_21to30, devs_total_female_71plus, 'Vartype', 'unequal')

%================================= t-test for female subjects (end) ==================================

group2130_mean_female_total = mean(devs_total_female_21to30); 
group2130_high_mean_female = mean(devs_high_female_21to30); 
group2130_low_mean_female = mean(devs_low_female_21to30); 

group3140_mean_female_total = mean(devs_total_female_31to40); 
group3140_high_mean_female = mean(devs_high_female_31to40);
group3140_low_mean_female = mean(devs_low_female_31to40);

group4150_mean_female_total = mean(devs_total_female_41to50);
group4150_high_mean_female = mean(devs_high_female_41to50);
group4150_low_mean_female = mean(devs_low_female_41to50);

group5160_mean_female_total = mean(devs_total_female_51to60); 
group5160_high_mean_female = mean(devs_high_female_51to60); 
group5160_low_mean_female = mean(devs_low_female_51to60); 

group6170_mean_female_total = mean(devs_total_female_61to70); 
group6170_high_mean_female = mean(devs_high_female_61to70); 
group6170_low_mean_female = mean(devs_low_female_61to70); 

group71plus_mean_female_total = mean(devs_total_female_71plus); 
group71plus_high_mean_female = mean(devs_high_female_71plus); 
group71plus_low_mean_female = mean(devs_low_female_71plus); 


group2130_var_female_total = var(devs_total_female_21to30); 
group2130_high_var_female = var(devs_high_female_21to30); 
group2130_low_var_female = var(devs_low_female_21to30); 

group3140_var_female_total = var(devs_total_female_31to40); 
group3140_high_var_female = var(devs_high_female_31to40);
group3140_low_var_female = var(devs_low_female_31to40);

group4150_var_female_total = var(devs_total_female_41to50);
group4150_high_var_female = var(devs_high_female_41to50);
group4150_low_var_female = var(devs_low_female_41to50);

group5160_var_female_total = var(devs_total_female_51to60); 
group5160_high_var_female = var(devs_high_female_51to60); 
group5160_low_var_female = var(devs_low_female_51to60); 

group6170_var_female_total = var(devs_total_female_61to70); 
group6170_high_var_female = var(devs_high_female_61to70); 
group6170_low_var_female = var(devs_low_female_61to70); 

group71plus_var_female_total = var(devs_total_female_71plus); 
group71plus_high_var_female = var(devs_high_female_71plus); 
group71plus_low_var_female = var(devs_low_female_71plus); 

x2_mean_female = [group2130_mean_female_total  group2130_high_mean_female  group2130_low_mean_female;  group3140_mean_female_total  group3140_high_mean_female  group3140_low_mean_female;  group4150_mean_female_total  group4150_high_mean_female  group4150_low_mean_female;  group5160_mean_female_total  group5160_high_mean_female  group5160_low_mean_female;  group6170_mean_female_total  group6170_high_mean_female  group6170_low_mean_female;  group71plus_mean_female_total  group71plus_high_mean_female  group71plus_low_mean_female]; 
x2_var_female = [group2130_var_female_total  group2130_high_var_female  group2130_low_var_female;  group3140_var_female_total  group3140_high_var_female  group3140_low_var_female;  group4150_var_female_total  group4150_high_var_female  group4150_low_var_female;  group5160_var_female_total  group5160_high_var_female  group5160_low_var_female;  group6170_var_female_total  group6170_high_var_female  group6170_low_var_female;  group71plus_var_female_total  group71plus_high_var_female  group71plus_low_var_female]; 

figure(5)
str1 = {'21-30', '31-40', '41-50', '51-60', '61-70', '71+'};
%str1 = {'21-30 (458)', '31-40 (85)', '41-50 (119)', '51-60 (119)', '61-70 (67)', '71-80 (31)', '81+ (8)'};
bar(x2_mean_female);
title('Female subjects');
ylabel('# of deviations '); 
xlabel('Age group'); 
set(gca, 'XTickLabel', str1,  'XTick', 1:numel(str1));
legend('total', 'high', 'low');

x2_sd_female = sqrt(x2_var_female);
figure(6)
str1 = {'21-30', '31-40', '41-50', '51-60', '61-70', '71+'};
bar(x2_sd_female);
title('Female subjects');
ylabel('s.d. of # of deviations'); 
xlabel('Age group'); 
set(gca, 'XTickLabel',str1, 'XTick',1:numel(str1));
legend('total', 'high', 'low');
