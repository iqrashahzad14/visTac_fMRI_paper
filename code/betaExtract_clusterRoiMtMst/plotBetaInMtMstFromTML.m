%% plot tactile beta
% from the  mask fo indivudual ms ROi

%%
%settings for plots
shape='.';
%%set the size of the shape 
sz=50;
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

model_series = [mean(betaEstMotion1), mean(betaEstStatic1);...
    mean(betaEstMotion2), mean(betaEstStatic2);...
    mean(betaEstMotion3), mean(betaEstStatic3);...
    mean(betaEstMotion4), mean(betaEstStatic4);...
    mean(betaEstMotion5), mean(betaEstStatic5);...
    mean(betaEstMotion6), mean(betaEstStatic6)];

model_error = [std(betaEstMotion1)/sqrt(length(betaEstMotion1)), std(betaEstStatic1)/sqrt(length(betaEstStatic1));...
    std(betaEstMotion2)/sqrt(length(betaEstMotion2)), std(betaEstStatic2)/sqrt(length(betaEstStatic2));...
    std(betaEstMotion3)/sqrt(length(betaEstMotion3)), std(betaEstStatic3)/sqrt(length(betaEstStatic3));...
    std(betaEstMotion4)/sqrt(length(betaEstMotion4)), std(betaEstStatic4)/sqrt(length(betaEstStatic4));...
    std(betaEstMotion5)/sqrt(length(betaEstMotion5)), std(betaEstStatic5)/sqrt(length(betaEstStatic5));...
    std(betaEstMotion6)/sqrt(length(betaEstMotion6)), std(betaEstStatic6)/sqrt(length(betaEstStatic6))];

% b = bar(model_series, 'grouped');
b = bar(model_series, 'grouped','FaceColor','flat', 'LineWidth',LineWidthMean/2 );

b(1).EdgeColor = darkGreen;
b(2).EdgeColor = lightGreen;

b(1).CData(1,:) = darkGreen;% % group 1 1st bar
b(1).CData(2,:) = darkGreen;% % group 1 2nd bar
b(1).CData(3,:) = darkGreen;% % 
b(1).CData(4,:) = darkGreen;% % 
b(1).CData(5,:) = darkGreen;% % 
b(1).CData(6,:) = darkGreen;% % 

b(2).CData(1,:) = lightGreen;% % group 2 1st bar
b(2).CData(2,:) = lightGreen;% % group 2 2nd bar
b(2).CData(3,:) = lightGreen;% % 
b(2).CData(4,:) = lightGreen;% % 
b(2).CData(5,:) = lightGreen;% % 
b(2).CData(6,:) = lightGreen;% % 


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

hold on
% Plot Dots
% scatter(repmat(x(1,1), length(betaEstMotion1), 1),betaEstMotion1,sz,'MarkerEdgeColor','k','MarkerFaceColor','k');
% scatter(repmat(x(2,1), length(betaEstStatic1), 1),betaEstStatic1,sz,'MarkerEdgeColor','k','MarkerFaceColor','k');
% 
% scatter(repmat(x(1,2), length(betaEstMotion2), 1),betaEstMotion2,sz,'MarkerEdgeColor','k','MarkerFaceColor','k');
% scatter(repmat(x(2,2), length(betaEstStatic2), 1),betaEstStatic2,sz,'MarkerEdgeColor','k','MarkerFaceColor','k');
% 
% scatter(repmat(x(1,3), length(betaEstMotion3), 1),betaEstMotion3,sz,'MarkerEdgeColor','k','MarkerFaceColor','k');
% scatter(repmat(x(2,3), length(betaEstStatic3), 1),betaEstStatic3,sz,'MarkerEdgeColor','k','MarkerFaceColor','k');
% 
% scatter(repmat(x(1,4), length(betaEstMotion4), 1),betaEstMotion4,sz,'MarkerEdgeColor','k','MarkerFaceColor','k');
% scatter(repmat(x(2,4), length(betaEstStatic4), 1),betaEstStatic4,sz,'MarkerEdgeColor','k','MarkerFaceColor','k');
% 
% scatter(repmat(x(1,5), length(betaEstMotion5), 1),betaEstMotion5,sz,'MarkerEdgeColor','k','MarkerFaceColor','k');
% scatter(repmat(x(2,5), length(betaEstStatic5), 1),betaEstStatic5,sz,'MarkerEdgeColor','k','MarkerFaceColor','k');
% 
% scatter(repmat(x(1,6), length(betaEstMotion6), 1),betaEstMotion6,sz,'MarkerEdgeColor','k','MarkerFaceColor','k');
% scatter(repmat(x(2,6), length(betaEstStatic6), 1),betaEstStatic6,sz,'MarkerEdgeColor','k','MarkerFaceColor','k');


% Plot connected lines
% for iiSub=1:length(subjectList)
%     hold on 
%     plot([x(1,1), x(2,1)],[betaEstMotion1(iiSub,1), betaEstStatic1(iiSub,1)],'k')
%     hold on 
%     plot([x(1,2), x(2,2)],[betaEstMotion2(iiSub,1), betaEstStatic2(iiSub,1)],'k') 
%     
%     plot([x(1,3), x(2,3)],[betaEstMotion3(iiSub,1), betaEstStatic3(iiSub,1)],'k')
%     hold on 
%     plot([x(1,4), x(2,4)],[betaEstMotion4(iiSub,1), betaEstStatic4(iiSub,1)],'k') 
%     
%     plot([x(1,5), x(2,5)],[betaEstMotion5(iiSub,1), betaEstStatic5(iiSub,1)],'k')
%     hold on 
%     plot([x(1,6), x(2,6)],[betaEstMotion6(iiSub,1), betaEstStatic6(iiSub,1)],'k') 
% 
% end

hold off


legend({'motion','static'},'Location','northeastoutside')
legend boxoff
xlabel('ROI') 
ylabel('Beta estimate (a.u.)')
xticklabels({'lhMT','rhMT','lMst','rMst','lMt','rMt'})
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
