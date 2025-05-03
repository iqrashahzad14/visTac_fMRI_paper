%% stats on behavioural data
% two-sample t-test in wilcoxon
% the data are not normal - as checked in Jamovi/R
% so do the wilcoxon test
% signrank treats NaNs in x and y as missing values and ignores them.

clear
data =readtable("behavAccu.xlsx");
data = table2array(data(1:20,2:end));

% col1 = data.visVer;
% col2 = data.visHor;
% [p,h,stats] = signrank(col1, col2)

for col = 1:2:(size(data,2)-1)
    [p(col),h(col),stats] = signrank(data(:,col), data(:,col+1));
    statsVal(col) = stats.signedrank; 
end
resultArray =[p', statsVal'];

% for col = 1:2:(size(data,2)-1)
%     [h(col),p(col),ci, stats] = ttest(data(:,col), data(:,col+1));
%     statsVal(col) = stats.tstat; 
%     dfVal(col) = stats.df;
%     sdVal(col) = stats.sd;
%     ciVal (col) = ci';
% end
% resultArray =[p',h', statsVal', dfVal', sdVal'];