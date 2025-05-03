clear all;
% data=dlmread('data4.txt');
data=readtable('anatExt_decodAccu.xlsx');

X = ones(size(data,1),size(data,2));
X(:,2:size(data,2)) =data(:,2:size(data,2));  %explanatory variables
%X=data(:,2:4);  %explanatory variables
H=X*(inv(X'*X))*X';   %hat matrix
Y_hat=H*data(:,1);  %second column is the response variable

%residuals
e=data(:,1)-Y_hat;  %estimated residual
RSS=e'*e;  %residual sum of squares
TSS=sum((data(:,1)-mean(data(:,1))).^2);    %total sum of squares
Rsq=1-(RSS/TSS);%R square
MSres=RSS/(length(data)-4);%residual mean square
d=e/sqrt(MSres);    %standardised residuals

std_res=zeros(length(H),1); %studentised residuals
for j=1:length(data)
    std_res(j)=e(j)/sqrt(MSres*(1-H(j,j)));%H(j,j) is the diagonal elements of H materix
    
end
figure(1)
subplot(1,2,1)
histogram(std_res,15);%plotting residuals
title('distribution of studentised residuals')
ylabel('studentised residuals')
xlabel('x')
subplot(1,2,2)
qqplot(std_res)%qqplot

fprintf('The value of R^2 is %0.4f', Rsq)
