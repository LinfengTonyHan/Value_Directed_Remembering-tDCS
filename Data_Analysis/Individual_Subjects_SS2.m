%% Day 2 Analysis

%% Specify [group number, subject number] in the "SubList" variable to see individual ROC curves (and stats)
clear();
close all;
STs = GetSecs(); %Start time (testing how long this script takes to run)
Path = '/Users/hanlinfeng/Dropbox/Tony-Jesse_shared/tDCS_Project/Data_Analysis&Statistics/Analysis_Codes/Analysis_Figures';
RespBins = 6:(-1):1;
figureResults = 'Difference'; %Specify 'Stage1', 'Stage2', or 'Difference' here, to look at the results of specific stages
%% Using the DPSD model or the UVSD model to work out:
% Hit rate, FA rate, Hit - FA rate, dprime
% Comparing Left Anodal and Right Anodal
SubList = {[4,5]};
nSub = 1:size(SubList,2);

%% Stage 1 Analysis
for IteSub = nSub
    ppl = SubList{IteSub};
    GroupID = ppl(1);
    SubID = ppl(2);
    [HVR, LVR, LureR, nBin] = SS2_Preprocessing(GroupID, SubID, 'Stage1');
    
    Result.HVmeanR = sum(nBin.HV .* RespBins) / sum(nBin.HV);
    Result.LVmeanR = sum(nBin.LV .* RespBins) / sum(nBin.LV);
    Result.LuremeanR = sum(nBin.Lure .* RespBins) / sum(nBin.Lure);
    Result.HVmLureR = Result.HVmeanR - Result.LuremeanR;
    Result.LVmLureR = Result.LVmeanR - Result.LuremeanR;
    Result.RatingProp.HV = nBin.HV/sum(nBin.HV);
    Result.RatingProp.LV = nBin.LV/sum(nBin.LV);
    Result.RatingProp.Lure = nBin.Lure / sum(nBin.Lure);
    %%
    targf(1,:) = nBin.HV;
    targf(2,:) = nBin.LV;
    luref(1,:) = nBin.Lure;
    luref(2,:) = luref(1,:);
    
    nB = 6; %number of response bins (6-point scale confidence rating)
    nC = 2; %number of conditions (2 conditions in the target groups (HV vs. LV)))
    
    fitStat = '-LL';
    model = 'dpsd';
    parNames = {'Ro','F'};
    CondLabels = {'High Value', 'Low Value'};
    % Ro & Rn?
    
    [x0, LB, UB] = gen_pars(model,nB,nC,parNames);
    
    rocData = roc_solver(targf,luref,model,fitStat,x0,LB,UB, ...
        'condLabels',CondLabels,'figure',false);
    
    Result.RoHV = rocData.dpsd_model.parameters.Ro(1);
    Result.RoLV = rocData.dpsd_model.parameters.Ro(2);
    Result.FarHV = rocData.dpsd_model.parameters.F(1);
    Result.FarLV = rocData.dpsd_model.parameters.F(2);
    Result.HRHV = rocData.observed_data.accuracy_measures.HR(1);
    Result.HRLV = rocData.observed_data.accuracy_measures.HR(2);
    Result.FAR = rocData.observed_data.accuracy_measures.FAR(1);
    Result.HRmFARHV = rocData.observed_data.accuracy_measures.HR_m_FAR(1);
    Result.HRmFARLV = rocData.observed_data.accuracy_measures.HR_m_FAR(2);
    
    fitStat = '-LL';
    model = 'uvsd';
    parNames = {'Dprime','Vo'};
    CondLabels = {'High Value', 'Low Value'};
    % Ro & Rn?
    
    [x0, LB, UB] = gen_pars(model,nB,nC,parNames);
    
    rocData = roc_solver(targf,luref,model,fitStat,x0,LB,UB, ...
        'condLabels',CondLabels);
    
    Result.DprimeHV = rocData.uvsd_model.parameters.Dprime(1);
    Result.DprimeLV = rocData.uvsd_model.parameters.Dprime(2);
end

%% Stage 2 Analysis
for IteSub = nSub
    
    ppl = SubList{IteSub};
    GroupID = ppl(1);
    SubID = ppl(2);
    [HVR, LVR, LureR, nBin] = SS2_Preprocessing(GroupID, SubID, 'Stage2');
    
    Result.HVmeanR = sum(nBin.HV .* RespBins) / sum(nBin.HV);
    Result.LVmeanR = sum(nBin.LV .* RespBins) / sum(nBin.LV);
    Result.LuremeanR = sum(nBin.Lure .* RespBins) / sum(nBin.Lure);
    Result.HVmLureR = Result.HVmeanR - Result.LuremeanR;
    Result.LVmLureR = Result.LVmeanR - Result.LuremeanR;
    Result.RatingProp.HV = nBin.HV/sum(nBin.HV);
    Result.RatingProp.LV = nBin.LV/sum(nBin.LV);
    Result.RatingProp.Lure = nBin.Lure / sum(nBin.Lure);
    %%
    targf(1,:) = nBin.HV;
    targf(2,:) = nBin.LV;
    luref(1,:) = nBin.Lure;
    luref(2,:) = luref(1,:);
    
    nB = 6; %number of response bins (6-point scale confidence rating)
    nC = 2; %number of conditions (2 conditions in the target groups (HV vs. LV)))
    
    fitStat = '-LL';
    model = 'dpsd';
    parNames = {'Ro','F'};
    CondLabels = {'High Value', 'Low Value'};
    % Ro & Rn?
    
    [x0, LB, UB] = gen_pars(model,nB,nC,parNames);
    
    rocData = roc_solver(targf,luref,model,fitStat,x0,LB,UB, ...
        'condLabels',CondLabels,'figure',false);
    
    Result.RoHV = rocData.dpsd_model.parameters.Ro(1);
    Result.RoLV = rocData.dpsd_model.parameters.Ro(2);
    Result.FarHV = rocData.dpsd_model.parameters.F(1);
    Result.FarLV = rocData.dpsd_model.parameters.F(2);
    Result.HRHV = rocData.observed_data.accuracy_measures.HR(1);
    Result.HRLV = rocData.observed_data.accuracy_measures.HR(2);
    Result.FAR = rocData.observed_data.accuracy_measures.FAR(1);
    Result.HRmFARHV = rocData.observed_data.accuracy_measures.HR_m_FAR(1);
    Result.HRmFARLV = rocData.observed_data.accuracy_measures.HR_m_FAR(2);
    
    fitStat = '-LL';
    model = 'uvsd';
    parNames = {'Dprime','Vo'};
    CondLabels = {'High Value', 'Low Value'};
    % Ro & Rn?
    
    [x0, LB, UB] = gen_pars(model,nB,nC,parNames);
    
    rocData = roc_solver(targf,luref,model,fitStat,x0,LB,UB, ...
        'condLabels',CondLabels);
    
    Result.DprimeHV = rocData.uvsd_model.parameters.Dprime(1);
    Result.DprimeLV = rocData.uvsd_model.parameters.Dprime(2);
end