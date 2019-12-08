This folder contains the analysis codes for the data from the experiment with within-subject comparsions.

Most scripts used a function ***BarPlotWithSinglePoints.m*** which can be seen in another repository *Linfeng_Toolkits*.

For an overview of the analyses, please look at ***Analysis_Notes.m***.

For the equation for calculating the selectivity index in value-directed free recall, please look at ***Selectivity_Index.m***.

***Day1_Analysis_3Groups.m*** calculates and visualizes the following results on Day 1 free recall: number of high-value (HV), low-value (LV), and all items recalled; total point values obtained; selectivity index; differences between stage 1 and stage 2 (sham stimulation vs. different stimulation groups).

***SS2_Preprocessing.m*** transforms the raw data into the format required by the ROC Toolbox (Koen et al., 2016).

***Day2_Analysis_3Groups_Basic.m*** computes and visualizes the results from Day 2 recognition (6-point scale confidence ratings). 

***Day2_Analysis_3Groups_2Stages_UVSD.m Day2_Analysis_3Groups_2Stages_EVSD.m Day2_Analysis_3Groups_2Stages_RawDprime.m*** compute the d' in different models. In addition, to look at the results on stage 1, stage 2, or the differences between the two stages, you can simply change the variable in line 28 ***figureResults***.

To compute one or multiple individual subjects' results (and ROC curves under different conditions), please look at ***Individual_Subjects_SS2.m***.
