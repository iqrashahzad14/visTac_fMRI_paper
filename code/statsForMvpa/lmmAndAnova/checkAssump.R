#checking assumptions

install.packages("readxl")
library(readxl)
#check my decoding accu normality using shapiro test
setwd("/Users/shahzad/Documents/tryANOVAAssumptions")
myData<-read_excel(path = "anatExt_decodAccu.xlsx")

# checking for normality
qqnorm(myData$anat_lS1)
qqline(myData$anat_lS1)

# test of normality
# H0: normal distribution; H1: not a normal distribution
shapiro.test(myData$anat_lS1) 
shapiro.test(myData$anat_lS1)$p.value
# ???? are our data compatible with normal distribution
# p-value < 0.05 => reject H0
# p-value is 0.0327
#to reject H0 and accept H1, we should have p<0.05
#to accept H0 and reject H1, we should have p>0.05 => it is normal

qqnorm(myData$anat_lS1)
qqline(myData$anat_lS1)
shapiro.test(myData$anat_lS1) 
shapiro.test(myData$anat_lS1)$p.value

qqnorm(myData$anat_lMTt)
qqline(myData$anat_lMTt)
shapiro.test(myData$anat_lMTt) 
shapiro.test(myData$anat_lMTt)$p.value

qqnorm(myData$anat_rMTt)
qqline(myData$anat_rMTt)
shapiro.test(myData$anat_rMTt) 
shapiro.test(myData$anat_rMTt)$p.value

qqnorm(myData$anat_lhMT)
qqline(myData$anat_lhMT)
shapiro.test(myData$anat_lhMT) 
shapiro.test(myData$anat_lhMT)$p.value

qqnorm(myData$anat_rhMT)
qqline(myData$anat_rhMT)
shapiro.test(myData$anat_rhMT) 
shapiro.test(myData$anat_rhMT)$p.value

###
qqnorm(myData$ext_lS1)
qqline(myData$ext_lS1)
shapiro.test(myData$ext_lS1) 
shapiro.test(myData$ext_lS1)$p.value

qqnorm(myData$ext_lMTt)
qqline(myData$ext_lMTt)
shapiro.test(myData$ext_lMTt) 
shapiro.test(myData$ext_lMTt)$p.value

qqnorm(myData$ext_rMTt)
qqline(myData$ext_rMTt)
shapiro.test(myData$ext_rMTt) 
shapiro.test(myData$ext_rMTt)$p.value

qqnorm(myData$ext_lhMT)
qqline(myData$ext_lhMT)
shapiro.test(myData$ext_lhMT) 
shapiro.test(myData$ext_lhMT)$p.value

qqnorm(myData$ext_rhMT)
qqline(myData$ext_rhMT)
shapiro.test(myData$ext_rhMT) 
shapiro.test(myData$ext_rhMT)$p.value

###

