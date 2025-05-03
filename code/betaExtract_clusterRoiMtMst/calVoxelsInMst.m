%% cal voxels in Mst
% Mst clusters from unsmoothed data
% dim is 2.6 mm iso
clear

% sub-pil001 and sub-pil002 have no localizer
%'sub-011' have no hMT;'sub-013' no (rhMT rMTt),'sub-014' no MTt
%'sub-008' have only right mst - !! do manually
subjectList= {'sub-001','sub-002','sub-003','sub-004','sub-005','sub-006','sub-007',...
             'sub-009','sub-010','sub-014','sub-015','sub-016','sub-017',...
             'sub-pil004','sub-pil005'}; 
% subjectList = {'sub-008'};

% opt.roi = {'lMst','rMst'};

for iSub = 1:length(subjectList)
    subID= subjectList(iSub);
    
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
    countVox1(iSub,:) = length(find(roi1.img>0));
    
    roi2 = load_nii(char(fullfile(maskDir,roiName2)));
    countVox2(iSub,:) = length(find(roi2.img>0));
    
    roi3 = load_nii(char(fullfile(maskDir,roiName3)));
    countVox3(iSub,:) = length(find(roi3.img>0));
    
    roi4 = load_nii(char(fullfile(maskDir,roiName4)));
    countVox4(iSub,:) = length(find(roi4.img>0));
    
    roi5 = load_nii(char(fullfile(maskDir,roiName5)));
    countVox5(iSub,:) = length(find(roi5.img>0));
    
    roi6 = load_nii(char(fullfile(maskDir,roiName6)));
    countVox6(iSub,:) = length(find(roi6.img>0));
    
    subName(iSub,1) = string(subID);
       
end

betaVal = [subName,countVox1, countVox2, countVox3, countVox4, countVox5, countVox6];

% T=array2table(betaVal,...
%     'VariableNames',{'subName','nbVox_lhMT', 'nbVox_rhMT','nbVox_lMst', 'nbVox_rMst','nbVox_lMT', 'nbVox_rMT'});
%  
% writetable(T,'nbVoxMstMT.xlsx')