%% Day 1 Analysis
% Total # words recalled (by list; and overall for non-practice lists)
% # HV words recalled (by list; and overall for non-practice lists)
% # LV words recalled (by list; and overall for non-practice lists)
% Selectivity Index (by list; and overall for non-practice lists)
clear();
close all;

LeftAnodalAllSub = {[1,1],[1,2],[1,3],[1,4],[1,5],[1,6],[1,7],[1,8],[1,9],[1,10],[1,11],[1,12],[1,13],[1,14],[1,15],[1,16]};
RightAnodalAllSub = {[3,1],[3,2],[3,3],[3,4],[3,6],[3,7],[3,8],[3,9],[3,10],[3,11],[3,12],[3,13],[3,14],[3,15]};
ShamAllSub = {[2,1],[2,2],[2,3],[2,4],[2,5],[2,6],[2,7],[4,1],[4,2],[4,3],[4,4],[4,6],[4,7],[4,8]};

SubList = [LeftAnodalAllSub, RightAnodalAllSub, ShamAllSub];

nSub = 1:size(SubList,2);
nLeftAnodal = length(LeftAnodalAllSub);
nRightAnodal = length(RightAnodalAllSub);
nSham = length(ShamAllSub);


nLA = 1:nLeftAnodal;
nRA = (nLeftAnodal + 1):(nLeftAnodal + nRightAnodal);
nS = (nLeftAnodal + nRightAnodal + 1):(nLeftAnodal + nRightAnodal + nSham);
segments = [1, nLA(end) + 1, nRA(end) + 1, nS(end) + 1];

for iteSub = nSub
    ppl = SubList{iteSub}; %Defining the subject's data file
    Group = ppl(1);
    Sub = ppl(2);
    cd Data_Session1
    switch Group
        case 1
            cd('LeftAnodal_Group1');
        case 2
            cd('LeftSham_Group2');
        case 3
            cd('RightAnodal_Group3');
        case 4
            cd('RightSham_Group4');
    end
    load(['Result_',num2str(Sub),'_SS1.mat']);
    
    cd ..
    cd ..
    
    %AS, CS, IS
    %Actual Score, Chance Score, Ideal Score
    Poss = sort(repmat([1,2,3,10,11,12],1,5),'descend'); %Possible answers
    
    %% L1 results
    AS.L1 = sum(CR_Value_HV{3}) + sum(CR_Value_LV{3});
    NumItems = ((length(CR_Value_HV{3}) + length(CR_Value_LV{3})));
    CS.L1 = NumItems * mean(Poss);
    IS.L1 = sum(Poss(1:NumItems));
    
    [SI.L1,TP.L1] = SelectivityIndex(AS.L1,CS.L1,IS.L1);
    
    %% L3 selectivity
    AS.L3 = sum(CR_Value_HV{5}) + sum(CR_Value_LV{5});
    NumItems = ((length(CR_Value_HV{5}) + length(CR_Value_LV{5})));
    CS.L3 = NumItems * mean(Poss);
    IS.L3 = sum(Poss(1:NumItems));
    
    [SI.L3,TP.L3] = SelectivityIndex(AS.L3,CS.L3,IS.L3);
    
    %% L6 selectivity
    AS.L6 = sum(CR_Value_HV{8}) + sum(CR_Value_LV{8});
    NumItems = ((length(CR_Value_HV{8}) + length(CR_Value_LV{8})));
    CS.L6 = NumItems * mean(Poss);
    IS.L6 = sum(Poss(1:NumItems));
    
    [SI.L6,TP.L6] = SelectivityIndex(AS.L6,CS.L6,IS.L6);
    
    %% L8 selectivity
    AS.L8 = sum(CR_Value_HV{10}) + sum(CR_Value_LV{10});
    NumItems = ((length(CR_Value_HV{10}) + length(CR_Value_LV{10})));
    CS.L8 = NumItems * mean(Poss);
    IS.L8 = sum(Poss(1:NumItems));
    
    [SI.L8,TP.L8] = SelectivityIndex(AS.L8,CS.L8,IS.L8);
    %%
    
    recallListNum = [3,5,8,10];
    for iteData = 1:length(recallListNum)
        DataSheet(iteSub, iteData) = length(CR_Resp_HV{recallListNum(iteData)});
        DataSheet(iteSub, iteData + 4) = length(CR_Resp_LV{recallListNum(iteData)});
        DataSheet(iteSub, iteData + 8) = length(CR_Resp_HV{recallListNum(iteData)}) + length(CR_Resp_LV{recallListNum(iteData)});
        DataSheet(iteSub, iteData + 12) = eval(['SI.L',num2str(recallListNum(iteData) - 2)]);
    end
    
    averageStage(iteSub, 1) = mean([TP.L1, TP.L3])/100;
    averageStage(iteSub, 2) = mean([TP.L6, TP.L8])/100;
    averageStage(iteSub, 3) = mean([SI.L1, SI.L3]);
    averageStage(iteSub, 4) = mean([SI.L6, SI.L8]);
    averageStage(iteSub, 5) = averageStage(iteSub, 2) - averageStage(iteSub, 1);
    averageStage(iteSub, 6) = averageStage(iteSub, 4) - averageStage(iteSub, 3);
end

%% Comment here soon!


msDS.LeftAnodal = averageStage(nLA, :);
msDS.RightAnodal = averageStage(nRA, :);
msDS.Sham = averageStage(nS, :);

DataSheet(isnan(DataSheet)) = 0;

DS.LeftAnodal = DataSheet(nLA, :);
DS.RightAnodal = DataSheet(nRA, :);
DS.Sham = DataSheet(nS, :);

nItem.LeftAnodal = DS.LeftAnodal(:,1:12);
nItem.RightAnodal = DS.RightAnodal(:,1:12);
nItem.Sham = DS.Sham(:, 1:12);
Sindex.LeftAnodal = DS.LeftAnodal(:,13:16);
Sindex.RightAnodal = DS.RightAnodal(:,13:16);
Sindex.Sham = DS.Sham(:, 13:16);

MeanMat.nItem = [mean(nItem.LeftAnodal); mean(nItem.RightAnodal); mean(nItem.Sham)];
MeanMat.SI = [mean(Sindex.LeftAnodal); mean(Sindex.RightAnodal); mean(Sindex.Sham)];
MeanMat.mStage = [mean(msDS.LeftAnodal); mean(msDS.RightAnodal); mean(msDS.Sham)];
SEMMat.nItem = [std(nItem.LeftAnodal) / sqrt(nLeftAnodal); std(nItem.RightAnodal) / sqrt(nRightAnodal); std(nItem.Sham) / sqrt(nSham)];
SEMMat.SI = [std(Sindex.LeftAnodal) / sqrt(nLeftAnodal); std(Sindex.RightAnodal) / sqrt(nRightAnodal); std(Sindex.Sham) / sqrt(nSham)];
SEMMat.mStage = [std(msDS.LeftAnodal) / sqrt(nLeftAnodal); std(msDS.RightAnodal) / sqrt(nRightAnodal); std(msDS.Sham) / sqrt(nSham)];
ItemFig = figure;
BarPlotWithSinglePoints(MeanMat.nItem', SEMMat.nItem',DataSheet(:,1:12),segments, 9);
legend({'LeftAnodal','RightAnodal','Sham'});
xticklabels({'HV-L1','HV-L3','HV-L6','HV-L8','LV-L1','LV-L3','LV-L6','LV-L8','Total-L1','Total-L3','Total-L6','Total-L8'});
CurFigure = gca; %Setting the font size of the output figures
CurFigure.FontSize = 14;
ylabel('Number of Items Recalled');
ylim([0,30]);
title('# Items Recalled on Day 1 Across Lists');
cd Analysis_Figures
saveas(ItemFig,'nItems.jpg');
cd ..

SIFig = figure;
BarPlotWithSinglePoints(MeanMat.SI', SEMMat.SI',DataSheet(:,13:16),segments, 9);
legend({'LeftAnodal','RightAnodal','Sham'});
xticklabels({'L1','L3','L6','L8'});
CurFigure = gca; %Setting the font size of the output figures
CurFigure.FontSize = 14;
ylabel('Selectivity Index');
title('Selectivity Index Across Lists');
cd Analysis_Figures
saveas(SIFig,'SelectivityIndex.jpg');
cd ..

%% Difference Fig
DiffFig = figure;
BarPlotWithSinglePoints(MeanMat.mStage', SEMMat.mStage',averageStage,segments, 9);
legend({'LeftAnodal','RightAnodal','Sham'});
xticklabels({'Stage1-Scores','Stage2-Scores','Stage1-Selectivity Index','Stage2-Selectivity Index','Scores-Diff','SI-Diff'});
CurFigure = gca; %Setting the font size of the output figures
CurFigure.FontSize = 14;
ylabel('Scores / Selectivity Index');
title('Scores and Selectivity Index Across Stages -- Scores = Raw Scores / 100');
cd Analysis_Figures
saveas(SIFig,'StageAnalysis.jpg');
cd ..
