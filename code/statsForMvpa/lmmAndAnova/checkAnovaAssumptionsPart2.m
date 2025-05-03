load('anatExt_table.mat')
load('anatExt_decodAccu.mat')

anat_lS1=decodAccu(:,3);
anat_lhMT=decodAccu(:,1);
anat_rhMT=decodAccu(:,2);
anat_lMTt=decodAccu(:,6);
anat_rMTt=decodAccu(:,7);

ext_lS1=decodAccu(:,10);
ext_lhMT=decodAccu(:,8);
ext_rhMT=decodAccu(:,9);
ext_lMTt=decodAccu(:,13);
ext_rMTt=decodAccu(:,14);

%%%
% 1. samples are independent and identically distributed
% 2. Residual errors follow normal distribution => y_i=ymean -> q-q plot
% 3. homodescedasticity (var1 = var2 =... varn) 
% equal or similar variances in different groups being compared
%%%

%1. samples are iid
subplot(2,5,1); histogram(anat_lS1)
subplot(2,5,2);histogram(anat_lMTt)
subplot(2,5,3);histogram(anat_rMTt)
subplot(2,5,4);histogram(anat_lhMT)
subplot(2,5,5);histogram(anat_rhMT)

subplot(2,5,6); histogram(ext_lS1)
subplot(2,5,7);histogram(ext_lMTt)
subplot(2,5,8);histogram(ext_rMTt)
subplot(2,5,9);histogram(ext_lhMT)
subplot(2,5,10);histogram(ext_rhMT)


%2. residuals
er_anat_lS1=anat_lS1(:)-mean(anat_lS1); subplot(2,5,1); normplot(er_anat_lS1)
er_anat_lMTt=anat_lMTt(:)-mean(anat_lMTt); subplot(2,5,2);normplot(er_anat_lMTt)
er_anat_rMTt=anat_lMTt(:)-mean(anat_lMTt); subplot(2,5,3);normplot(er_anat_rMTt)
er_anat_lhMT=anat_lMTt(:)-mean(anat_lMTt); subplot(2,5,4);normplot(er_anat_lhMT)
er_anat_rhMT=anat_lMTt(:)-mean(anat_lMTt); subplot(2,5,5);normplot(er_anat_rhMT)

er_ext_lS1=ext_lS1(:)-mean(ext_lS1); subplot(2,5,6);normplot(er_ext_lS1)
er_ext_lMTt=ext_lMTt(:)-mean(ext_lMTt); subplot(2,5,7);normplot(er_ext_lMTt)
er_ext_rMTt=ext_lMTt(:)-mean(ext_lMTt); subplot(2,5,8);normplot(er_ext_rMTt)
er_ext_lhMT=ext_lMTt(:)-mean(ext_lMTt); subplot(2,5,9);normplot(er_ext_lhMT)
er_ext_rhMT=ext_lMTt(:)-mean(ext_lMTt); subplot(2,5,10);normplot(er_ext_rhMT)

%3. variance
varianceG =[var(anat_lS1),...
var(anat_lMTt),...
var(anat_rMTt),...
var(anat_lhMT),...
var(anat_rhMT);

var(ext_lS1),...
var(ext_lMTt),...
var(ext_rMTt),...
var(ext_lhMT),...
var(ext_rhMT)]


t=readtable('anatExt_decodAccu.xlsx')