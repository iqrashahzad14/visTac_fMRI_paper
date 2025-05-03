%paired comparisons ttest
clear all

load('/Volumes/IqraMacFmri/visTac/fMRI_analysis/outputs/derivatives/mvpaStats_pseudo/statsPseudo_anat_HDPT_HUPT_vs_HDFW_HUFW_beta_202404182045.mat')
anatSubAccu=mvpaStats.subAccu ;
roiList=mvpaStats.roiList  

load('/Volumes/IqraMacFmri/visTac/fMRI_analysis/outputs/derivatives/mvpaStats_pseudo/statsPseudo_ext_HUPT_HDFW_vs_HDPT_HUFW_beta_202404182047.mat')
extSubAccu=mvpaStats.subAccu ;
roiList=mvpaStats.roiList  

%%
% % distribution of paired differences
% for iRoi=1:length(roiList)
%     diff(:,iRoi)=[anatSubAccu(:,iRoi)-extSubAccu(:,iRoi)];
% end
% for iRRoi = 1:length(roiList)
%     subplot(2,3,iRRoi)
%     histogram(diff(:,iRRoi))
%     title(cell2mat(roiList(iRRoi)))
% end
% sgtitle(strcat('pairedTTest', '-','distribution'))
% saveas(gcf,strcat('groupNullDis', '_',decodTitle,'_',decodingCondition,'_',im,'.png'))
%%
%paired t-test %%wilcoxon
for iRoi=1:length(roiList)
    [h(iRoi),p(iRoi), ci{iRoi}, stats{iRoi}]=ttest(anatSubAccu(:,iRoi),extSubAccu(:,iRoi),0.5);
%     [p(iRoi),h(iRoi),stats{iRoi}]=signrank(anatSubAccu(:,iRoi),extSubAccu(:,iRoi),0.5);
end

%fdr correction
fdrCorrPVal=mafdr(p, 'BHFDR', 'true');

%%%%%
%paired Ttest on tactile anat ext decoding
data = readtable("/Volumes/IqraMacFmri/visTac/fMRI_analysis/outputs/derivatives/decoding/glm_noResponse_forIMRF_includesAllSub/anatExt_decodAccu.xlsx");
cd ('/Volumes/IqraMacFmri/visTac/fMRI_analysis/code/mvpa')
run PlotAcrossHandAnatExt2.m
anatSubAccu =[anat_lS1,anat_lMTt, anat_rMTt, anat_lhMT, anat_rhMT ];
extSubAccu =[ext_lS1, ext_lMTt, ext_rMTt, ext_lhMT,ext_rhMT ];

roiList={'lS1','lMTt', 'rMTt','lhMT','rhMT'};
for iRoi=1:length(roiList)
    [h(iRoi),p(iRoi), ci{iRoi}, stats{iRoi}]=ttest(anatSubAccu(:,iRoi),extSubAccu(:,iRoi),0.5);
%     [p(iRoi),h(iRoi),stats{iRoi}]=signrank(anatSubAccu(:,iRoi),extSubAccu(:,iRoi),0.5);
end
