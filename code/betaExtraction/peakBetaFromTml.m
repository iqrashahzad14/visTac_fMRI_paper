%% extract the beta parameters from ROIS
%from peak coordinates or centre of individual ROIs

% TACTILE MOTION LOCALIZER
% across two runs
clear all
%% from peak cooridinates
%get roi coordinates
r=readtable('/Volumes/IqraMacFmri/visTac/fMRI_analysis/code/roi/coordinates4.xlsx');
% check the roi label order
roiLabels = {'lhMT', 'rhMT', 'lS1' , 'lPC', 'rPC' , 'lMTt', 'rMTt' };
rt = table2cell(r(:,2:8));
%% extract beta estimates from TML task and hMT

% roiType = 'subjectSphere';
% radiusNb='8';
taskName= 'tactileLocalizer2';

subjectList={'sub-001','sub-002','sub-003','sub-004','sub-005','sub-006','sub-007','sub-008',...
    'sub-009','sub-010','sub-011', 'sub-013','sub-014','sub-015','sub-016','sub-017',...
    'sub-pil004','sub-pil005'}; %'sub-pil001','sub-pil002',,

% opt.roi = {'lS1','lPC','rPC','lMTt','rMTt','lhMT','rhMT' };

for iSub = 1:length(subjectList)
    subID= subjectList(iSub);
    
    %where is the glm
    glmDir =char(fullfile(fileparts(mfilename('fullpath')),'..', '..','outputs','derivatives','bidspm-stats-noResponses',char(subID),strcat('task-',taskName,'_space-IXI549Space_FWHM-6')));

    %!!!Always check the betas here
    %if glm-noresponse: motion=1,9; static = 2,10
    %if glm-withresponse: then sub 14,15,16 dont have any repsonse
    %motion=1,10; static = 2,11
    motionBetaA = fullfile(glmDir,'beta_0001.nii');
    motionBetaB = fullfile(glmDir,'beta_0009.nii');
    staticBetaA = fullfile(glmDir,'beta_0002.nii'); 
    staticBetaB = fullfile(glmDir,'beta_0010.nii');
    
    for iRoi = 1:length (roiLabels)
        roiCoord = rt(iSub, iRoi);
        roiCoord = str2num(char(roiCoord));
        [betaValMotionA(iSub,iRoi), ~]=spm_summarise(motionBetaA,struct('def','box', 'spec',[2.6 2.6 2.6], 'xyz',roiCoord')); %2.6 iso is the size of voxel
        [betaValMotionB(iSub,iRoi), ~]=spm_summarise(motionBetaB,struct('def','box', 'spec',[2.6 2.6 2.6], 'xyz',roiCoord'));
        [betaValStaticA(iSub,iRoi), ~]=spm_summarise(staticBetaA,struct('def','box', 'spec',[2.6 2.6 2.6], 'xyz',roiCoord'));
        [betaValStaticB(iSub,iRoi), ~]=spm_summarise(staticBetaB,struct('def','box', 'spec',[2.6 2.6 2.6], 'xyz',roiCoord'));
    
    end
       
end

% element by element mean cannot happen in matlab fucntion, so compute it!
motionBeta = [betaValMotionA + betaValMotionB]./2;
staticBeta = [betaValStaticA + betaValStaticB]./2;
% motionBeta = betaValMotionA ;
% staticBeta = betaValStaticA ;

%%
%settings for plots
shape='.';
%%set the size of the shape 
% sz=50;
%%set the width of the edge of the markers
LineWidthMarkers=1.5;
%%set the width of the edge of the mean line
LineWidthMean=4;
%%set the length of the mean line
LineLength=0.4; %the actual length will be the double of this value%%%set the transparency of the markers
Transparency=1;%0.7;
%%set the color for each condition in RGB (and divide them by 256 to be matlab compatible)
lightGreen=[105 170 153]/256; % Light green
darkGreen=[24 96 88]/256;% Dark green
lightOrange=[255 158 74]/256; % Light Orange
darkOrange=[208 110 48]/256;% Dark Orange
lightPurple=[198 131 239]/256;% Light Purple
darkPurple=[121 57 195]/256; %Dark Purple
Col_A=[105 170 153]/256; %
Col_B=[24 96 88]/256;%
Col_C=[255 158 74]/256; %
Col_D=[208 110 48]/256;%
Col_E=[198 131 239]/256;%
Col_F=[121 57 195]/256; %
Colors=[Col_A;Col_B;Col_C;Col_D;Col_E;Col_F];

%%set the font styles
FontName='Avenir'; %set the style of the labels
FontSize=17; %%set the size of the labels

figure(1)

model_series = [mean(motionBeta(:,1)), mean(staticBeta(:,1));...
    mean(motionBeta(:,2)), mean(staticBeta(:,2));...
    mean(motionBeta(:,3)), mean(staticBeta(:,3));...
    mean(motionBeta(:,4)), mean(staticBeta(:,4));...
    mean(motionBeta(:,5)), mean(staticBeta(:,5));...
    mean(motionBeta(:,6)), mean(staticBeta(:,6));...
    mean(motionBeta(:,7)), mean(staticBeta(:,7))];

model_error = [std(motionBeta(:,1))/sqrt(length(motionBeta(:,1))), std(staticBeta(:,1))/sqrt(length(staticBeta(:,1)));...
    std(motionBeta(:,2))/sqrt(length(motionBeta(:,2))), std(staticBeta(:,2))/sqrt(length(staticBeta(:,2)));...
    std(motionBeta(:,3))/sqrt(length(motionBeta(:,3))), std(staticBeta(:,3))/sqrt(length(staticBeta(:,3)));...
    std(motionBeta(:,4))/sqrt(length(motionBeta(:,4))), std(staticBeta(:,4))/sqrt(length(staticBeta(:,4)));...
    std(motionBeta(:,5))/sqrt(length(motionBeta(:,5))), std(staticBeta(:,5))/sqrt(length(staticBeta(:,5)));...
    std(motionBeta(:,6))/sqrt(length(motionBeta(:,6))), std(staticBeta(:,6))/sqrt(length(staticBeta(:,6)));...
    std(motionBeta(:,7))/sqrt(length(motionBeta(:,7))), std(staticBeta(:,7))/sqrt(length(staticBeta(:,7)))];

% b = bar(model_series, 'grouped');
b = bar(model_series, 'grouped','FaceColor','flat', 'LineWidth',LineWidthMean/2 );

b(1).EdgeColor = darkGreen;
b(2).EdgeColor = lightGreen;

b(1).CData(1,:) = darkGreen;%'w';%Colors(2,:); % group 1 1st bar
b(1).CData(2,:) = darkGreen;%'w';%Colors(2,:); % group 1 2nd bar
b(1).CData(3,:) = darkGreen;%'w';%Colors(2,:); % group 1 3rd bar
b(1).CData(4,:) = darkGreen;%'w';%Colors(2,:); % group 1
b(1).CData(5,:) = darkGreen;%'w';%Colors(2,:); % group 1
b(1).CData(6,:) = darkGreen;%'w';%Colors(2,:); % group 1
b(1).CData(7,:) = darkGreen;%'w';%Colors(2,:); % group 1

b(2).CData(1,:) = lightGreen;%'w';%Colors(4,:); % group 2 1st bar
b(2).CData(2,:) = lightGreen;%'w';%Colors(4,:); % group 2 2nd bar
b(2).CData(3,:) = lightGreen;%'w';%Colors(4,:); % group 2 3rd bar
b(2).CData(4,:) = lightGreen;%'w';%Colors(4,:); % group 2 
b(2).CData(5,:) = lightGreen;%'w';%Colors(4,:); % group 2 
b(2).CData(6,:) = lightGreen;%'w';%Colors(4,:); % group 2 
b(2).CData(7,:) = lightGreen;%'w';%Colors(4,:); % group 2 

% Calculate the number of groups and number of bars in each group
[ngroups,nbars] = size(model_series);

% Get the x coordinate of the bars
x = nan(nbars, ngroups);
for i = 1:nbars
    x(i,:) = b(i).XEndPoints;
end
hold on

% Plot the errorbars
errorbar(x',model_series,model_error,'k','linestyle','none','LineWidth',LineWidthMean/2);

sz=20;
scatter(repmat(x(1,1), length(motionBeta(:,1)), 1),motionBeta(:,1),sz,'MarkerEdgeColor','k','MarkerFaceColor','k');
scatter(repmat(x(2,1), length(staticBeta(:,1)), 1),staticBeta(:,1),sz,'MarkerEdgeColor','k','MarkerFaceColor','k');

scatter(repmat(x(1,2), length(motionBeta(:,2)), 1),motionBeta(:,2),sz,'MarkerEdgeColor','k','MarkerFaceColor','k');
scatter(repmat(x(2,2), length(staticBeta(:,2)), 1),staticBeta(:,2),sz,'MarkerEdgeColor','k','MarkerFaceColor','k');

scatter(repmat(x(1,3), length(motionBeta(:,3)), 1),motionBeta(:,3),sz,'MarkerEdgeColor','k','MarkerFaceColor','k');
scatter(repmat(x(2,3), length(staticBeta(:,3)), 1),staticBeta(:,3),sz,'MarkerEdgeColor','k','MarkerFaceColor','k');

scatter(repmat(x(1,4), length(motionBeta(:,4)), 1),motionBeta(:,4),sz,'MarkerEdgeColor','k','MarkerFaceColor','k');
scatter(repmat(x(2,4), length(staticBeta(:,4)), 1),staticBeta(:,4),sz,'MarkerEdgeColor','k','MarkerFaceColor','k');

scatter(repmat(x(1,5), length(motionBeta(:,5)), 1),motionBeta(:,5),sz,'MarkerEdgeColor','k','MarkerFaceColor','k');
scatter(repmat(x(2,5), length(staticBeta(:,5)), 1),staticBeta(:,5),sz,'MarkerEdgeColor','k','MarkerFaceColor','k');

scatter(repmat(x(1,6), length(motionBeta(:,6)), 1),motionBeta(:,6),sz,'MarkerEdgeColor','k','MarkerFaceColor','k');
scatter(repmat(x(2,6), length(staticBeta(:,6)), 1),staticBeta(:,6),sz,'MarkerEdgeColor','k','MarkerFaceColor','k');

scatter(repmat(x(1,7), length(motionBeta(:,7)), 1),motionBeta(:,7),sz,'MarkerEdgeColor','k','MarkerFaceColor','k');
scatter(repmat(x(2,7), length(staticBeta(:,7)), 1),staticBeta(:,7),sz,'MarkerEdgeColor','k','MarkerFaceColor','k');

% % Plot connected lines
for iiSub=1:length(subjectList)
    hold on 
    plot([x(1,1), x(2,1)],[motionBeta(iiSub,1), staticBeta(iiSub,1)],'k')
    hold on 
    plot([x(1,2), x(2,2)],[motionBeta(iiSub,2), staticBeta(iiSub,2)],'k') 
    hold on 
    plot([x(1,3), x(2,3)],[motionBeta(iiSub,3), staticBeta(iiSub,3)],'k')  
    hold on 
    plot([x(1,4), x(2,4)],[motionBeta(iiSub,4), staticBeta(iiSub,4)],'k')
    hold on 
    plot([x(1,5), x(2,5)],[motionBeta(iiSub,5), staticBeta(iiSub,5)],'k')    
    hold on 
    plot([x(1,6), x(2,6)],[motionBeta(iiSub,6), staticBeta(iiSub,6)],'k')
    hold on 
    plot([x(1,7), x(2,7)],[motionBeta(iiSub,7), staticBeta(iiSub,7)],'k')
end

% hold on
% %plot chance level
% % yline(0, '-','LineWidth',LineWidthMean/3)

hold off


% ylim([-0.4 1.5]) % no lines for each subject
% ylim([-1.2 2.8]) 
legend({'motion','static'},'Location','northeastoutside')
legend boxoff
xlabel('ROI') 
ylabel('Beta estimate (a.u.)')
xticklabels(roiLabels);%{'lhMT','rhMT'})
head1= strcat('motion and static beta estimates for task- ',taskName); 
head2='';
title(head1, head2)


%format plot
set(gcf,'color','w');
ax=gca;

set(ax,'FontName',FontName,'FontSize',FontSize, 'FontWeight','bold',...
    'LineWidth',2.5,'TickDir','out', 'TickLength', [0,0],...
    'FontSize',FontSize);
box off


figureName=strcat('betaEstimates','spherical','.png');
% derivativeDir= fullfile(fileparts(mfilename('fullpath')),'..','..','..','derivatives');
% saveas(gcf,fullfile(derivativeDir,'cosmoMvpa', 'figure',figureName))


%% stats on the plot
% data = [betaEstMotion6, betaEstStatic6,...
%     betaEstMotion7, betaEstStatic7];
% 
% %one sample ttest on each condition
% % [hA,pS,ciA,statsA] = ttest(betaEstMotion6)
% % [hB,pB,ciB,statsB] = ttest(betaEstStatic6)
% % [hC,pC,ciC,statsC] = ttest(betaEstMotion7)
% % [hD,pD,ciD,statsD] = ttest(betaEstStatic7)
% 
% % paired ttest
% [hA,pA] = ttest(betaEstMotion6,betaEstStatic6) % n.s. p=0.0619
% [hB,pB] = ttest(betaEstMotion7,betaEstStatic7) % s. p =0.0458
