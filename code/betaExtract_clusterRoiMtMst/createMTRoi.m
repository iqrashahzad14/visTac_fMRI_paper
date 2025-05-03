%% create MS individual ROI = overlap Roi 
% save the individual clusters of hMT and MTt
% overlap of individual hMT and MTt and then make their ROI mask
clear all

% sub-pil001 and sub-pil002 have no localizer
%'sub-011' have no hMT;'sub-013' no (rhMT rMTt),'sub-014' no MTt
%'sub-008' have only right mst - !! do manually
subjectList= {'sub-001','sub-002','sub-003','sub-004','sub-005','sub-006','sub-007',...
             'sub-009','sub-010','sub-014','sub-015','sub-016','sub-017',...
             'sub-pil004','sub-pil005'}; %{'sub-008'};
         
opt.roi = {'lhMT','rhMT','lMTt','rMTt' };

roiPairList={'lhMT-lMst', 'rhMT-rMst'};

for iSub = 1:length(subjectList)
    subID= subjectList(iSub);

    % where to read the rois
    opt.maskDir = fullfile(fileparts(mfilename('fullpath')),'..', '..','outputs','derivatives','ms-roi','subjectMstRoi',char(subID));
    maskDir = opt.maskDir;
    
    roiName1 = strcat(subID,'_lhMT_p001','.nii');
    roiName2 = strcat(subID,'_rhMT_p001','.nii');
    roiName3 = strcat(subID,'_lMst','.nii');
    roiName4 = strcat(subID,'_rMst','.nii');
    leftRoiName = strcat(subID,'_lMT','.nii');
    rightRoiName = strcat(subID,'_rMT','.nii');
    
    roi1 = load_nii(char(fullfile(maskDir,roiName1))); 
    roi2 = load_nii(char(fullfile(maskDir,roiName2)));
    roi3 = load_nii(char(fullfile(maskDir,roiName3)));
    roi4 = load_nii(char(fullfile(maskDir,roiName4)));
    
    %check the unique elements of roi images, to see if they are binarised
    uniqRoi1(iSub,:) = length(unique(roi1.img));
    uniqRoi2(iSub,:) = length(unique(roi2.img));
    uniqRoi3(iSub,:) = length(unique(roi3.img));
    uniqRoi4(iSub,:) = length(unique(roi4.img));
    
    for iRoiPair = 1:length(roiPairList)
        roiPairLabel= roiPairList(iRoiPair);
        
        if strcmp(roiPairLabel,'lhMT-lMst')==1
            %sum the masks: 0 is neither, 1 is either, 2 is both (overlap)
            overlap = roi1.img & roi3.img; % Logical AND to find overlap
            roi1.img(overlap) = 0;
%             overlap = roi1.img + roi3.img;
%             msRoi.img = single((overlap ==0)|(overlap ==1)); % it firsts gives a logical array of 0 and 1; 1 if the voxels has value of 2 and then civerts to single format
%             roi1.img = msRoi.img;
            % save new ROIs   
            opt.outputMask = fullfile(fileparts(mfilename('fullpath')),'..', '..','outputs','derivatives','ms-roi','subjectMstRoi',char(subID));
            save_nii(roi1,fullfile(opt.outputMask, char(leftRoiName)));
            
        elseif strcmp(roiPairLabel,'rhMT-rMst')==1
            %sum the masks: 0 is neither, 1 is either, 2 is both (overlap)
            overlap = roi2.img & roi4.img; % Logical AND to find overlap
            roi2.img(overlap) = 0;
%             overlap = roi2.img + roi4.img;
%             msRoi.img = single((overlap ~=2)); % it firsts gives a logical array of 0 and 1; 1 if the voxels has value of 2 and then civerts to single format
%             roi2.img = msRoi.img;
            % save new ROIs   
            opt.outputMask = fullfile(fileparts(mfilename('fullpath')),'..', '..','outputs','derivatives','ms-roi','subjectMstRoi',char(subID));
            save_nii(roi2,fullfile(opt.outputMask, char(rightRoiName)));
        end
                  
    end
    subName(iSub,1) = string(subID);
end