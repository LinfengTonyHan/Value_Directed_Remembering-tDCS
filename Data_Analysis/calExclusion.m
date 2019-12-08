%% Calculate the number of subjects having bad memory performance
% Two potential criteria: getting excluded if any of the lists contain
% fewer than 5 words, or getting excluded if the average recall performance
% is below 5.

LeftAnodalAllSub = {[1,1],[1,2],[1,3],[1,4],[1,5],[1,6],[1,7],[1,8],[1,9],[1,10],[1,11],[1,12],[1,13]};
RightAnodalAllSub = {[3,1],[3,2],[3,3],[3,4],[3,5],[3,6],[3,7],[3,8],[3,9],[3,10],[3,11],[3,12]};
ShamAllSub = {[2,1],[2,2],[2,3],[2,4],[2,5],[2,6],[2,7],[4,1],[4,2],[4,3],[4,4],[4,5],[4,6]};

SubList = [LeftAnodalAllSub, RightAnodalAllSub, ShamAllSub];

nSub = 1:size(SubList,2);
nLeftAnodal = length(LeftAnodalAllSub);
nRightAnodal = length(RightAnodalAllSub);
nSham = length(ShamAllSub);

exMin = [];
exMean = [];
exMin2 = [];
for iteSub = nSub
    ppl = SubList{iteSub};
    GroupID = ppl(1);
    SubID = ppl(2);
    Sub = SubID;
    cd Data_Session1
    switch GroupID
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
    
    V = [3, 5, 8, 10];
    for iteBlock = 1:length(V)
        itemRecalled(iteBlock) = length(CR_Resp_HV{V(iteBlock)}) + length(CR_Resp_LV{V(iteBlock)});
    end
    allNrecall(iteSub, :) = itemRecalled;
    allSubNrecall{iteSub} = itemRecalled;
    
    itemRecalled = sort(itemRecalled);
    min1 = itemRecalled(1);
    min2 = itemRecalled(2);
    
    if min1 < 5 && min2 < 5
        exMin2(end+1) = iteSub;
    end
    
    if min(itemRecalled) < 5
        exMin(end+1) = iteSub;
    end
    
    if mean(itemRecalled) < 5
        exMean(end+1) = iteSub;
    end
    
end
exMin;
exMean;