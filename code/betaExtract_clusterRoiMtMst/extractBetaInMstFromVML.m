%% the beta parameters from a ROI

%% extract beta estimates from VML task 
clear

% sub-pil001 and sub-pil002 have no localizer
%'sub-011' have no hMT;'sub-013' no (rhMT rMTt),'sub-014' no MTt
%'sub-008' have only right mst - !! do manually
subjectList= {'sub-001','sub-002','sub-003','sub-004','sub-005','sub-006','sub-007',...
             'sub-009','sub-010','sub-014','sub-015','sub-016','sub-017',...
             'sub-pil004','sub-pil005'}; 
% subjectList = {'sub-008'};
% subjectList = {'sub-004','sub-006'};%for right hemi - sub with good localization         
% opt.roi = {'lhMT','rhMT','lMst','rMst','rMst','rMst'};

%%
taskName= 'visualLocalizer2';

for iSub = 1:length(subjectList)
    subID= subjectList(iSub);
    
    %where is the glm
    glmDir =char(fullfile(fileparts(mfilename('fullpath')),'..', '..','outputs','derivatives','bidspm-stats-noResponses',char(subID),strcat('task-',taskName,'_space-IXI549Space_FWHM-6')));

    %!!!Always check the betas here
    %if glm-noresponse: motion=1,9; static = 2,10
    %if glm-withresponse: then sub 14,15,16 dont have any repsonse
    %motion=1,10; static = 2,11
    motionBetaA = load_nii(char(fullfile(glmDir,'beta_0001.nii')));
    
    staticBetaA = load_nii(char(fullfile(glmDir,'beta_0002.nii'))); 
    
    
    % where to read the rois
    opt.maskDir = fullfile(fileparts(mfilename('fullpath')),'..', '..','outputs','derivatives','ms-roi','subjectMstRoi',char(subID));
    maskDir = opt.maskDir;
    
    roiName1 = strcat(subID,'_lhMT_p001','.nii');
    roiName2 = strcat(subID,'_rhMT_p001','.nii');
    roiName3 = strcat(subID,'_lMst','.nii');
    roiName4 = strcat(subID,'_rMst','.nii');
    roiName5 = strcat(subID,'_lMT','.nii');
    roiName6 = strcat(subID,'_rMT','.nii');
    
    roi1 = load_nii(char(fullfile(maskDir,roiName1)));
    roi2 = load_nii(char(fullfile(maskDir,roiName2)));
    roi3 = load_nii(char(fullfile(maskDir,roiName3)));
    roi4 = load_nii(char(fullfile(maskDir,roiName4)));
    roi5 = load_nii(char(fullfile(maskDir,roiName5)));
    roi6 = load_nii(char(fullfile(maskDir,roiName6)));
   
    %find the beta for roi1
    %take the indices of the voxels=1 in roi1
    activeVox1 = find(roi1.img == 1);
    %find the value of voxel at that index and then take the mean 
    betaEstMotion1(iSub,1) = mean(motionBetaA.img(activeVox1(~isnan(motionBetaA.img(activeVox1)))));
    betaEstStatic1(iSub,1) = mean(staticBetaA.img(activeVox1(~isnan(staticBetaA.img(activeVox1)))));
    findNan1(iSub,1)= sum(isnan(motionBetaA.img(activeVox1))); % taking sum because we want to count the number of 1s
    
    %repeat for all rois
    activeVox2 = find(roi2.img == 1);
    betaEstMotion2(iSub,1) = mean(motionBetaA.img(activeVox2(~isnan(motionBetaA.img(activeVox2)))));
    betaEstStatic2(iSub,1) = mean(staticBetaA.img(activeVox2(~isnan(staticBetaA.img(activeVox2)))));
    findNan2(iSub,1)= sum(isnan(motionBetaA.img(activeVox2)));
    
    activeVox3 = find(roi3.img == 1);
    betaEstMotion3(iSub,1) = mean(motionBetaA.img(activeVox3(~isnan(motionBetaA.img(activeVox3)))));
    betaEstStatic3(iSub,1) = mean(staticBetaA.img(activeVox3(~isnan(staticBetaA.img(activeVox3)))));
    findNan3(iSub,1)= sum(isnan(motionBetaA.img(activeVox3))); % taking sum because we want to count the number of 1s
    
    activeVox4 = find(roi4.img == 1);
    betaEstMotion4(iSub,1) = mean(motionBetaA.img(activeVox4(~isnan(motionBetaA.img(activeVox4)))));
    betaEstStatic4(iSub,1) = mean(staticBetaA.img(activeVox4(~isnan(staticBetaA.img(activeVox4)))));
    findNan4(iSub,1)= sum(isnan(motionBetaA.img(activeVox4)));
    
    activeVox5 = find(roi5.img == 1);
    betaEstMotion5(iSub,1) = mean(motionBetaA.img(activeVox5(~isnan(motionBetaA.img(activeVox5)))));
    betaEstStatic5(iSub,1) = mean(staticBetaA.img(activeVox5(~isnan(staticBetaA.img(activeVox5)))));
    findNan5(iSub,1)= sum(isnan(motionBetaA.img(activeVox5))); % taking sum because we want to count the number of 1s
    
    activeVox6 = find(roi6.img == 1);
    betaEstMotion6(iSub,1) = mean(motionBetaA.img(activeVox6(~isnan(motionBetaA.img(activeVox6)))));
    betaEstStatic6(iSub,1) = mean(staticBetaA.img(activeVox6(~isnan(staticBetaA.img(activeVox6)))));
    
    subName(iSub,1) = string(subID);
       
end

betaVal = [subName, betaEstMotion1, betaEstStatic1,betaEstMotion2, betaEstStatic2,...
    betaEstMotion3, betaEstStatic3,betaEstMotion4, betaEstStatic4,...
    betaEstMotion5, betaEstStatic5,betaEstMotion6, betaEstStatic6];

T=array2table(betaVal,...
    'VariableNames',{'SubID','Motion_lhMT', 'Static_lhMT','Motion_rhMT', 'Static_rhMT',...
    'Motion_lMst', 'Static_lMst','Motion_rMst', 'Static_rMst',...
    'Motion_lMt', 'Static_lMt','Motion_rMt', 'Static_rMt'
    });
 
writetable(T,'betaFromMstFromVML.xlsx')