library(openxlsx) # import excel file
library(reshape2) # reshape data 
library(ggplot2) # plots
library(lmerTest) # linear mixed model
library(emmeans) # multiple comparisons

donnees <- read.xlsx("anatExt_decodAccu.xlsx")
donnees$subID <- factor(donnees$subID)

donnees <- melt(donnees)
donnees$FoR <- sub("_.*", "", donnees$variable)
donnees$ROI <- sub(".*_", "", donnees$variable)

#write.xlsx(donnees, file = "data_longFormat.xlsx")
setwd("/Users/shahzad/Documents/tryANOVAAssumptions/reoprt_lmm_decodingAccu")
donnees <- read.xlsx("data_longFormat.xlsx")

ggplot(donnees, aes(x = ROI, y = value, fill = FoR)) + geom_boxplot()

res <- lmer(value ~ ROI*FoR + (1|subID), data = donnees)
plot(res) # homoscedasticity fine

qqnorm(residuals(res)) 
qqline(residuals(res))
qqnorm(ranef(res)$subID[,1])
qqline(ranef(res)$subID[,1])
# residuals fine

# multiple comparisons 
multComp <- contrast(emmeans(res, ~ROI:FoR), method = "pairwise", simple = "each", combine = TRUE, adjust = "holm")
plot(multComp) + 
  geom_vline(xintercept = 0, linetype = "dotted")

emmip(res, FoR ~ ROI, CIs = TRUE)
emmip(res, ROI ~ FoR | ROI, CIs = TRUE)

anova(res, ddf = "Kenward-Roger")
