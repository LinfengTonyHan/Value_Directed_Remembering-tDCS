%% This script is written for conducting t-tests (comparisons) between left anodal and right anodal / sham groups
load DataSheet.mat

% defining groups
diffSheet = DataSheet.Diff;
groupLA = find(diffSheet(:, 19) == 1);
groupRA = find(diffSheet(:, 19) == 2);
groupS = find(diffSheet(:, 19) == 3);

%% Recollection column 6 & 7
Ro.LA.HV = diffSheet(groupLA, 6);
Ro.RA.HV = diffSheet(groupRA, 6);
Ro.S.HV = diffSheet(groupS, 6);
Ro.LA.LV = diffSheet(groupLA, 7);
Ro.RA.LV = diffSheet(groupRA, 7);
Ro.S.LV = diffSheet(groupS, 7);

[~, pval, ~, stats] = ttest2(Ro.LA.HV, Ro.RA.HV); 
Stats.Ro.LRHV = [pval, stats.tstat];
[~, pval, ~, stats] = ttest2(Ro.LA.HV, Ro.S.HV); 
Stats.Ro.LSHV = [pval, stats.tstat];

[~, pval, ~, stats] = ttest2(Ro.LA.LV, Ro.RA.LV); 
Stats.Ro.LRLV = [pval, stats.tstat];
[~, pval, ~, stats] = ttest2(Ro.LA.LV, Ro.S.LV); 
Stats.Ro.LSLV = [pval, stats.tstat];
%% Familiarity Column 8 & 9
Fml.LA.HV = diffSheet(groupLA, 8);
Fml.RA.HV = diffSheet(groupRA, 8);
Fml.S.HV = diffSheet(groupS, 8);
Fml.LA.LV = diffSheet(groupLA, 9);
Fml.RA.LV = diffSheet(groupRA, 9);
Fml.S.LV = diffSheet(groupS, 9);

[~, pval, ~, stats] = ttest2(Fml.LA.HV, Fml.RA.HV); 
Stats.Fml.LRHV = [pval, stats.tstat];
[~, pval, ~, stats] = ttest2(Fml.LA.HV, Fml.S.HV); 
Stats.Fml.LSHV = [pval, stats.tstat];

[~, pval, ~, stats] = ttest2(Fml.LA.LV, Fml.RA.LV); 
Stats.Fml.LRLV = [pval, stats.tstat];
[~, pval, ~, stats] = ttest2(Fml.LA.LV, Fml.S.LV); 
Stats.Fml.LSLV = [pval, stats.tstat];
%% D-prime
Dprime.LA.HV = diffSheet(groupLA, 15);
Dprime.RA.HV = diffSheet(groupRA, 15);
Dprime.S.HV = diffSheet(groupS, 15);
Dprime.LA.LV = diffSheet(groupLA, 16);
Dprime.RA.LV = diffSheet(groupRA, 16);
Dprime.S.LV = diffSheet(groupS, 16);

[~, pval, ~, stats] = ttest2(Dprime.LA.HV, Dprime.RA.HV); 
Stats.Dprime.LRHV = [pval, stats.tstat];
[~, pval, ~, stats] = ttest2(Dprime.LA.HV, Dprime.S.HV); 
Stats.Dprime.LSHV = [pval, stats.tstat];

[~, pval, ~, stats] = ttest2(Dprime.LA.LV, Dprime.RA.LV); 
Stats.Dprime.LRLV = [pval, stats.tstat];
[~, pval, ~, stats] = ttest2(Dprime.LA.LV, Dprime.S.LV); 
Stats.Dprime.LSLV = [pval, stats.tstat];

%% Look at this variable: Stats