function [T2UCL1,QUCL]=func_PCA_detection(Xtrain,Xtest)
[X_row,X_col] = size(Xtrain);

%求协方差矩阵
sigmaXtrain = cov(Xtrain);
%对协方差矩阵进行特征分解，lamda为特征值构成的对角阵，T的列为单位特征向量，且与lamda中的特征值一一对应：
[T,lamda] = eig(sigmaXtrain);                            
% disp('特征根（由小到大）');
% disp(lamda);
% disp('特征向量：');
% disp(T);                                            

%取对角元素(结果为一列向量)，即lamda值，并上下反转使其从大到小排列，主元个数初值为1，若累计贡献率小于90%则增加主元个数
D = flipud(diag(lamda));                            
num_pc = 1;                                         
while sum(D(1:num_pc))/sum(D) < 0.9   
num_pc = num_pc +1;
end                                                 

%取与lamda相对应的特征向量
P = T(:,X_col-num_pc+1:X_col);                            
TT=Xtrain*T;
TT1=Xtrain*P;
%求置信度为99%、95%时的T2统计控制限                       
T2UCL1=num_pc*(X_row-1)*(X_row+1)*finv(0.95,num_pc,X_row - num_pc)/(X_row*(X_row - num_pc));


%置信度为95%的Q统计控制限
for i = 1:3
    theta(i) = sum((D(num_pc+1:X_col)).^i);
end
h0 = 1 - 2*theta(1)*theta(3)/(3*theta(1)^2);
ca = norminv(0.95,0,1);
QUCL = theta(1)*(h0*ca*sqrt(2*theta(2))/theta(1) + 1 + theta(2)*h0*(h0 - 1)/theta(1)^2)^(1/h0);                           

%在线监测：
%标准化处理
n = size(Xtest,1);
% Xtest=(Xtest-repmat(X_mean,n,1))./repmat(X_std,n,1);

%求T2统计量，Q统计量
[r,y] = size(P*P');
I = eye(r,y);

T2 = zeros(n,1);
Q = zeros(n,1);
for i = 1:n
    T2(i)=Xtest(i,:)*P*pinv(lamda(X_col-num_pc+1:X_col,X_col-num_pc+1:X_col))*P'*Xtest(i,:)';  
    Q(i) = Xtest(i,:)*(I - P*P')*(I - P*P')'*Xtest(i,:)';                                                                                    
end

% sigma = cov(data);%M*M矩阵，获得协方差矩阵
% [v d] = eig(sigma);  %求矩阵sigma的全部特征值，存成对角阵d ； 特征向量存在矩阵 v 中
%                     %eig() 返回 归一化的正交特征向量 
% d1=diag(d);         %获取d的对角线元素 
% [d2,index]=sort(d1);  %升序排列特征值
% cols =size(v,2);    %特征向量矩阵的列数
% vsort = ones(row,cols);
% dsort = ones(row,1);
% for i=1:cols
%     vsort(:,i)=v(:,index(cols-i+1));%降序特征向量
%     dsort(i)=d1(index(cols-i+1));%降序特征值
% end %Matlab中给一维向量排序是使用sort函数：sort（X），其中x为待排序的向量
% 
% num_pc = 1;                                         
% while sum(dsort(1:num_pc))/sum(dsort) < 0.90   
%     num_pc = num_pc +1;
% end         
% 
% %取与lamda相对应的特征向量
% P = vsort(:,1:num_pc);                            
% TT=data*vsort;
% TT1=data*P;
% %求置信度为99%、95%时的T2统计控制限                       
% T2UCL=num_pc*(row-1)*(row+1)*finv(0.95,num_pc,row - num_pc)/(row*(row - num_pc));
% 
% 
% %置信度为95%的Q统计控制限
% for i = 1:3
%     theta(i) = sum((dsort(num_pc+1:col)).^i);
% end
% h0 = 1 - 2*theta(1)*theta(3)/(3*theta(1)^2);
% ca = norminv(0.95,0,1);
% QUCL = theta(1)*(h0*ca*sqrt(2*theta(2))/theta(1) + 1 + theta(2)*h0*(h0 - 1)/theta(1)^2)^(1/h0);    
% 
% %%  在线检测
% %标准化处理
% test=zscore(test); %标准化数据；
% 
% %求T2统计量，Q统计量
% [r,y] = size(P*P');
% I = eye(r,y);
% n = size(test,1);
% T2 = zeros(n,1);
% Q = zeros(n,1);
% for i = 1:n
%     T2(i)=test(i,:)*P*pinv(d(1:num_pc,1:num_pc))*P'*test(i,:)';  
%     Q(i) = test(i,:)*(I - P*P')*(I - P*P')'*test(i,:)';                                                                                    
% end

%绘图
    figure
    subplot(2,1,1);
    plot(1:n,T2,'k');                                    
    title('主元分析统计量变化图');
    xlabel('采样数');
    ylabel('T^2');
    hold on;
    line([0,n],[T2UCL1,T2UCL1],'LineStyle','--','Color','r');

    subplot(2,1,2);
    plot(1:n,Q,'k');
    xlabel('采样数');
    ylabel('SPE');
    hold on;
    line([0,n],[QUCL,QUCL],'LineStyle','--','Color','r');


