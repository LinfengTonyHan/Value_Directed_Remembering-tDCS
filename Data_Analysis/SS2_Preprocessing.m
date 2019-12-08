%% This script is basically for pre-processing the data of session 2
% This script will organize the data from session 2 old / new responses

function [HVRating, LVRating, LureRating, nBin] = SS2_Preprocessing(Group, Sub, Stages)
%% nBin is a struct including rating distributions of HV, LV and lure items.
%% Loading the data
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

cd Data_Session2
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

load(['Result_',num2str(Sub),'_SS2.mat']);

cd ..
cd ..

%% General Analysis Procedure:
% Using the function "crecallprob" to find out the HV words and LV words,
% then find out the lure words, then generate the ratings lists for each
% subject

% If constraining the stage as S2, S3, or S2S3, then exclude the old
% words in other lists
if strcmp(Stages, 'Stage1')
    RecogList = [StudyList.L2,StudyList.L4,StudyList.L5];
    
    HvList = RecogList(1,cell2mat(RecogList(2,:)) >= 10);
    LvList = RecogList(1,cell2mat(RecogList(2,:)) <= 3);
    [~,Seq1] = crecallprob(HvList, Stimuli_List(1,:));
    Seq1 = cell2mat(Seq1);
    HV_Resp = cell2mat(Stimuli_List(2,Seq1));
    HV_Resp(isnan(HV_Resp)) = [];
    [~,Seq2] = crecallprob(LvList, Stimuli_List(1,:));
    Seq2 = cell2mat(Seq2);
    LV_Resp = cell2mat(Stimuli_List(2,Seq2));
    LV_Resp(isnan(LV_Resp)) = [];

    [~, NewSeq] = crecallprob(StudyList.Lure, Stimuli_List(1,:));
    NewSeq = cell2mat(NewSeq);
    New_Resp = cell2mat(Stimuli_List(2,NewSeq));
    
    HVRating = Stimuli_List(:,Seq1);
    LVRating = Stimuli_List(:,Seq2);
    LureRating = Stimuli_List(:,NewSeq);
    
    for nK = 1:6
        nBin.HV(nK) = sum(HV_Resp == 7 - nK);
        nBin.LV(nK) = sum(LV_Resp == 7 - nK);
        nBin.Lure(nK) = sum(New_Resp == 7 - nK);
    end
end
%% Separating Stage: S2S3 (When stimulation works

if strcmp(Stages, 'Stage2')
    RecogList = [StudyList.L7,StudyList.L9,StudyList.L10];
    
    HvList = RecogList(1,cell2mat(RecogList(2,:)) >= 10);
    LvList = RecogList(1,cell2mat(RecogList(2,:)) <= 3);
    [~,Seq1] = crecallprob(HvList, Stimuli_List(1,:));
    Seq1 = cell2mat(Seq1);
    HV_Resp = cell2mat(Stimuli_List(2,Seq1));
    HV_Resp(isnan(HV_Resp)) = [];
    [~,Seq2] = crecallprob(LvList, Stimuli_List(1,:));
    Seq2 = cell2mat(Seq2);
    LV_Resp = cell2mat(Stimuli_List(2,Seq2));
    LV_Resp(isnan(LV_Resp)) = [];

    [~, NewSeq] = crecallprob(StudyList.Lure, Stimuli_List(1,:));
    NewSeq = cell2mat(NewSeq);
    New_Resp = cell2mat(Stimuli_List(2,NewSeq));
    
    HVRating = Stimuli_List(:,Seq1);
    LVRating = Stimuli_List(:,Seq2);
    LureRating = Stimuli_List(:,NewSeq);
    
    for nK = 1:6
        nBin.HV(nK) = sum(HV_Resp == 7 - nK);
        nBin.LV(nK) = sum(LV_Resp == 7 - nK);
        nBin.Lure(nK) = sum(New_Resp == 7 - nK);
    end
end

%% Find their corresponding values
for ite = 1:size(HVRating,2)
    clear TargetLoc
    Target = HVRating{1,ite};
    TargetLoc = strcmp(Target,RecogList(1,:));
    HVRating{3,ite} = RecogList{2,TargetLoc};
end

for ite = 1:size(LVRating,2)
    clear TargetLoc
    Target = LVRating{1,ite};
    TargetLoc = strcmp(Target,RecogList(1,:));
    LVRating{3,ite} = RecogList{2,TargetLoc};
end

