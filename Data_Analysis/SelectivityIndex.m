function [SI, TP] = SelectivityIndex(AS,CS,IS)
%% This function is for calculating the selectivity index 
% AS: Actual Score
% CS: Chance Score
% IS: Ideal Score
% SI: Selectivity Index
% TP: Total Points
SI = (AS - CS) / (IS - CS);
TP = AS;