## This script is for the ANOVAs and post-hoc t-test
library(R.matlab)

fullData <- readMat("/Users/linfenghan/Dropbox (Personal)/Tony-Jesse_shared/tDCS_Project/Data_Analysis&Statistics/Analysis_Codes_V2/DataSheet_63Sub.mat")
stage1Data <- fullData$DataSheet[[1]]
stage2Data <- fullData$DataSheet[[2]]
diffData <- fullData$DataSheet[[3]]

groupID <- c(replicate(21, 1), replicate(20, 2), replicate(22, 3))

HVdata = diffData[,17]
LVdata = diffData[,18]
HLdiff = HVdata - LVdata

dfDprime <- data.frame(HVdata, LVdata, HLdiff, groupID)

#HLdiffANOVA <- aov(HLdiff ~ groupID)
#summary(HLdiffANOVA)

dfDprime$groupID <- factor(dfDprime$groupID, labels = c("left anode", "right anode", "sham"))

## Setting up separate contrasts
contrastLR = c(1, -1, 0)
#contrastLS = c(1, 0, -1)
#contrastRS = c(0, 1, -1)

contrasts(dfDprime$groupID) = cbind(contrastLR)
# contrasts(dfDprime$groupID) = 

aovDprimeCombined <- aov(dfDprime$HLdiff ~ dfDprime$groupID, data = dfDprime)
summary.lm(aovDprimeCombined)

#pairwise.t.test(HLdiff, groupID, p.adjust.method = 'bonf', alternative = 'less')
