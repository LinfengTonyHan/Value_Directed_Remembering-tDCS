## This script is for high and low value analysis
# First, load the data (.sav)
library(haven)
library(ggplot2)
library(tidyverse)
library(ggpubr)
library(rstatix)

dataFull <- read_sav("/Users/linfenghan/Dropbox (Personal)/Tony-Jesse_shared/tDCS_Project/Data_Analysis&Statistics/Analysis_Codes_V2/RoFmlData.sav") 

## Gather the columns DprimeHV, DprimeLV into long format
## Convert StimGroup and value into factor variables
dataFull <- dataFull %>%
  # gather(key = "Value", value = "DprimeChange", RoHV, RoLV) %>%
  gather(key = "Value", value = "DprimeChange", DprimeHV, DprimeLV) %>%
  convert_as_factor(StimGroup, Value)

# Randomly inspect three data-points in each stim group
# Two rows may be from one single subject...
set.seed(2022)
dataFull %>% sample_n_by(StimGroup, size = 3) 

dataFull %>%
  group_by(StimGroup, Value) %>%
  get_summary_stats(DprimeChange, type = "mean_sd")

bxp <- ggboxplot(dataFull, x = "StimGroup", y = "DprimeChange", color = "Value")
bxp # Display the boxplot: initially inspection of the data

dataFull %>%
  identify_outliers(DprimeChange) %>%
  shapiro_test(DprimeChange) # Yes, it follows normal distribution

mixAov <- anova_test(data = dataFull, dv = DprimeChange, wid = SubID, between = StimGroup, within = Value)
get_anova_table(mixAov)
  
# Effect of stimgroup at each value level (simple effect analysis)
one.way <- dataFull %>%
  group_by(Value) %>%
  anova_test(dv = DprimeChange, wid = SubID, between = StimGroup) %>%
  get_anova_table() %>%
  adjust_pvalue(method = "holm") # Holm or none
one.way

# Pairwise comparisons between stimulation groups
pwc <- dataFull %>%
  group_by(Value) %>%
  pairwise_t_test(DprimeChange ~ StimGroup, p.adjust.method = "holm")
pwc  