%% Day 2 Analysis - Part 1
% Hit Rate for HV words and LV words
%%%%%
% Generate the hit rate and FA rate in ROC toolbox
%%%%%
% FA Rate for novel words
% Corrected recognition (i.e. Hit Rate - FA rate) for HV words and LV words
% d' for HV words and LV words
%%%%%
% Generate in the ROC toolbox
% Mean rating for HV words, LV words, and novel words
% Corrected rating for HV words (e.g, HV rating - Novel rating)
% Corrected rating for LV words (e.g, LV rating - Novel rating)

% ROC curves for HV words and LV words
% DPSD parameter estimates for recollection and familiarity

% Histogram of rating distribution (% responses) for each stim type (HV, LV, novel).
clear();
close all;

Path = '/Users/hanlinfeng/Dropbox/Tony-Jesse_shared/tDCS_Project/Data_Analysis&Statistics/Analysis_Codes/Analysis_Figures';
RespBins = 6:(-1):1;
%% Using the DPSD model or the UVSD model to work out:
% Hit rate, FA rate, Hit - FA rate, dprime
% Comparing Left Anodal and Right Anodal

SubList = {[1,1],[1,2],[1,3],[1,4],[1,5],[1,6],[1,7],[3,1],[3,2],[3,3],[3,4],[3,5],[2,1],[2,2],[2,3],[2,4],[4,1],[4,2],[4,3]};
nSub = 1:size(SubList,2);
nLeftAnodal = 7;
nRightAnodal = 5;
nSham = 7;

nLA = 1:nLeftAnodal;
nRA = (nLeftAnodal + 1):(nLeftAnodal + nRightAnodal);
nS = (nLeftAnodal + nRightAnodal + 1):(nLeftAnodal + nRightAnodal + nSham);
segments = [1, nLA(end) + 1, nRA(end) + 1, nS(end) + 1];
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
        'condLabels',CondLabels,'figure',false);
    
    Result.DprimeHV = rocData.uvsd_model.parameters.Dprime(1);
    Result.DprimeLV = rocData.uvsd_model.parameters.Dprime(2);
    
    DataSheet.Stage1(IteSub,:) = [Result.HVmeanR, Result.LVmeanR, Result.LuremeanR, Result.HVmLureR, Result.LVmLureR,...
        Result.RoHV, Result.RoLV, Result.FarHV, Result.FarLV, ...
        Result.HRHV, Result.HRLV, Result.FAR, Result.HRmFARHV, Result.HRmFARLV, Result.DprimeHV, Result.DprimeLV];
    DistributionSheet.Stage1(IteSub,:) = [Result.RatingProp.HV, Result.RatingProp.LV, Result.RatingProp.Lure];
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
        'condLabels',CondLabels,'figure',false);
    
    Result.DprimeHV = rocData.uvsd_model.parameters.Dprime(1);
    Result.DprimeLV = rocData.uvsd_model.parameters.Dprime(2);
    
    DataSheet.Stage2(IteSub,:) = [Result.HVmeanR, Result.LVmeanR, Result.LuremeanR, Result.HVmLureR, Result.LVmLureR,...
        Result.RoHV, Result.RoLV, Result.FarHV, Result.FarLV, ...
        Result.HRHV, Result.HRLV, Result.FAR, Result.HRmFARHV, Result.HRmFARLV, Result.DprimeHV, Result.DprimeLV];
    DistributionSheet.Stage2(IteSub,:) = [Result.RatingProp.HV, Result.RatingProp.LV, Result.RatingProp.Lure];
end

DataSheet.Diff = DataSheet.Stage2 - DataSheet.Stage1;
DistributionSheet.Diff = DistributionSheet.Stage2 - DistributionSheet.Stage1;

%% Plotting out the results -- 4 figures to plot
% Barplot 1: HV, LV, Lure ratings (and corrected)
% Barplot 2: Rating distributions (%)
% Barplot 3: Recollection and Familiarity (dpsd model)
% Barplot 4: SDT model parameters (uvsd model);

DS.LeftAnodal = DataSheet.Diff(nLA,:); %LA: Left Anodal
DS.RightAnodal = DataSheet.Diff(nRA,:); %RA: Right Anodal
DS.Sham = DataSheet.Diff(nS,:); %S: Sham
DTB.LeftAnodal = DistributionSheet.Diff(nLA, :); %DTB: Distribution
DTB.RightAnodal = DistributionSheet.Diff(nRA, :);
DTB.Sham = DistributionSheet.Diff(nS, :);
%% Barplot 1: HV, LV, Lure Ratings (and corrected)
pT1.LeftAnodal = DS.LeftAnodal(:,1:5);
pT1.RightAnodal = DS.RightAnodal(:,1:5);
pT1.Sham = DS.Sham(:,1:5);
pT1.LeftAnodalM = mean(pT1.LeftAnodal);
pT1.RightAnodalM = mean(pT1.RightAnodal);
pT1.ShamM = mean(pT1.Sham);
pT1.LeftAnodalSEM = std(pT1.LeftAnodal) / sqrt(nLeftAnodal);
pT1.RightAnodalSEM = std(pT1.RightAnodal) / sqrt(nRightAnodal);
pT1.ShamSEM = std(pT1.Sham) / sqrt(nSham);

MatMean = [pT1.LeftAnodalM; pT1.RightAnodalM; pT1.ShamM];
MatSEM = [pT1.LeftAnodalSEM; pT1.RightAnodalSEM; pT1.ShamSEM];
RatingFigure = figure;
BarPlotWithSinglePoints(MatMean', MatSEM', [pT1.LeftAnodal; pT1.RightAnodal; pT1.Sham], segments);
legend('LeftAnodal','RightAnodal','Sham');
xticklabels({'HVRating','LVRating','LureRating','HV-Lure','LV-Lure'});
CurFigure = gca; %Setting the font size of the output figures
CurFigure.FontSize = 15;
ylabel('Rating Values');
title('Originial Rating Values');
cd Analysis_Figures
saveas(RatingFigure,'RatingValues.jpg');
cd ..

%% Barplot 2: % Distribution of ratings
pT2.LeftAnodalMtmp = mean(DTB.LeftAnodal);
pT2.RightAnodalMtmp = mean(DTB.RightAnodal);
pT2.ShamMtmp = mean(DTB.Sham);

pT2.LeftAnodalM = [pT2.LeftAnodalMtmp(1:6); pT2.LeftAnodalMtmp(7:12); pT2.LeftAnodalMtmp(13:18)];
pT2.RightAnodalM = [pT2.RightAnodalMtmp(1:6); pT2.RightAnodalMtmp(7:12); pT2.RightAnodalMtmp(13:18)];
pT2.ShamM = [pT2.ShamMtmp(1:6); pT2.ShamMtmp(7:12); pT2.ShamMtmp(13:18)];

pT2.LeftAnodalSEMtmp = std(DTB.LeftAnodal) / sqrt(nLeftAnodal);
pT2.RightAnodalSEMtmp = std(DTB.RightAnodal) / sqrt(nRightAnodal);
pT2.ShamSEMtmp = std(DTB.Sham) / sqrt(nSham);

pT2.LeftAnodalSEM = [pT2.LeftAnodalSEMtmp(1:6); pT2.LeftAnodalSEMtmp(7:12); pT2.LeftAnodalSEMtmp(13:18)];
pT2.RightAnodalSEM = [pT2.RightAnodalSEMtmp(1:6); pT2.RightAnodalSEMtmp(7:12); pT2.RightAnodalSEMtmp(13:18)];
pT2.ShamSEM = [pT2.ShamSEMtmp(1:6); pT2.ShamSEMtmp(7:12); pT2.ShamSEMtmp(13:18)];

MatMean = [pT2.LeftAnodalM, pT2.RightAnodalM, pT2.ShamM];
MatSEM = [pT2.LeftAnodalSEM, pT2.RightAnodalSEM, pT2.ShamSEM];
RatingDTBFigure = figure;
BarPlotWithSEM(MatMean', MatSEM');
legend('High Value','Low Value','Lure');
xticklabels({'6LA','5LA','4LA','3LA','2LA','1LA','6RA','5RA','4RA','3RA','2RA','1RA','6S','5S','4S','3S','2S','1S'});
ylabel('Response Ratio');
title('Response Ratio: LA = Left Anodal, RA = Right Anodal, S = Sham');
CurFigure = gca; %Setting the font size of the output figures
CurFigure.FontSize = 12;

cd Analysis_Figures
saveas(RatingDTBFigure,'RatingDistribution.jpg');
cd ..
%% Barplot 3: Recollection and Familiarity (dpsd model)
pT3.LeftAnodal = DS.LeftAnodal(:,6:9);
pT3.RightAnodal = DS.RightAnodal(:,6:9);
pT3.Sham = DS.Sham(:,6:9);

pT3.LeftAnodalM = mean(pT3.LeftAnodal);
pT3.RightAnodalM = mean(pT3.RightAnodal);
pT3.ShamM = mean(pT3.Sham);

pT3.LeftAnodalSEM = std(pT3.LeftAnodal) / sqrt(nLeftAnodal);
pT3.RightAnodalSEM = std(pT3.RightAnodal) / sqrt(nRightAnodal);
pT3.ShamSEM = std(pT3.Sham) / sqrt(nSham);

MatMean = [pT3.LeftAnodalM; pT3.RightAnodalM; pT3.ShamM];
MatSEM = [pT3.LeftAnodalSEM; pT3.RightAnodalSEM; pT3.ShamSEM];
RFestimate = figure;
BarPlotWithSinglePoints(MatMean', MatSEM', [pT3.LeftAnodal; pT3.RightAnodal; pT3.Sham], segments);
legend('Left Anodal','Right Anodal','Sham');
xticklabels({'RoHV','RoLV','FHV','FLV'});
ylabel('DPSD Model Parameters Estimate');
CurFigure = gca; %Setting the font size of the output figures
CurFigure.FontSize = 16;
title('Recollection and Familiarity -- DPSD Model')
cd Analysis_Figures
saveas(RFestimate,'RFparameters.jpg');
cd ..

%% Barplot 4: SDT parameter estimates (UVSD model)
pT4.LeftAnodal = DS.LeftAnodal(:, 10:16);
pT4.RightAnodal = DS.RightAnodal(:, 10:16);
pT4.Sham = DS.Sham(:, 10:16);

pT4.LeftAnodalM = mean(pT4.LeftAnodal);
pT4.RightAnodalM = mean(pT4.RightAnodal);
pT4.ShamM = mean(pT4.Sham);

pT4.LeftAnodalSEM = std(pT4.LeftAnodal) / sqrt(nLeftAnodal);
pT4.RightAnodalSEM = std(pT4.RightAnodal) / sqrt(nRightAnodal);
pT4.ShamSEM = std(pT4.Sham) / sqrt(nSham);

MatMean = [pT4.LeftAnodalM; pT4.RightAnodalM; pT4.ShamM];
MatSEM = [pT4.LeftAnodalSEM; pT4.RightAnodalSEM; pT4.ShamSEM];

SDT = figure;
BarPlotWithSinglePoints(MatMean', MatSEM', [pT4.LeftAnodal; pT4.RightAnodal; pT4.Sham], segments);
legend('Left Anodal','Right Anodal','Sham');
xticklabels({'HRHV','HRLV','FARate','CorHV','CorLV','DprimeHV','DprimeLV'}); %Corrected
ylabel('SDT Model estimate');
title('SDT Parameters');
CurFigure = gca; %Setting the font size of the output figures
CurFigure.FontSize = 14;

cd Analysis_Figures
saveas(SDT,'SDT_UVSDmodel.jpg');
cd ..