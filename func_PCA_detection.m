function [T2UCL1,QUCL]=func_PCA_detection(Xtrain,Xtest)
[X_row,X_col] = size(Xtrain);
%标准化处理：
X_mean = mean(Xtrain);  %按列求Xtrain平均值                           
X_std = std(Xtrain);    %求标准差                      
[X_row,X_col] = size(Xtrain); %求Xtrain行、列数               

Xtrain=(Xtrain-repmat(X_mean,X_row,1))./repmat(X_std,X_row,1);

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
disp('主元个数为');disp(num_pc);
disp('***********************************************');
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
Xtest=(Xtest-repmat(X_mean,n,1))./repmat(X_std,n,1);

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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 误报率
count=0;
N= n;
for i=1:N
    if T2(i)>T2UCL1
        count=count+1;
    end
end
false_alarm=count/n
count2=0;
for i=1:N
    if Q(i)>QUCL 
        count2=count2+1;
    end
end
false_alarm2=count2/n

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%绘图
    figure
    subplot(3,1,1);
    plot(1:n,T2,'k');                                    
    title('主元分析统计量变化图');
    %xlabel('采样数');
    ylabel('T^2');
    hold on;
    line([0,n],[T2UCL1,T2UCL1],'LineStyle','--','Color','r');

    subplot(3,1,2);
    plot(1:n,Q,'k');
   % xlabel('采样数');
    ylabel('SPE');
    hold on;
    line([0,n],[QUCL,QUCL],'LineStyle','--','Color','r');
    hold on;
 %计算控制限
alpha=0.9;
S=lamda(X_col-num_pc+1:X_col,X_col-num_pc+1:X_col);
FAI=P*pinv(S)*P'/T2UCL1+(eye(X_col)-P*P')/QUCL;
S=cov(Xtrain);
g=trace((S*FAI)^2)/trace(S*FAI);
h=(trace(S*FAI))^2/trace((S*FAI)^2);
kesi =g*chi2inv(alpha,h);
 %% 综合指标
subplot(3,1,3)
fai=(Q/QUCL)+(T2/T2UCL1);
plot(fai)
ylabel('ψ');
hold on;
line([0,n],[kesi,kesi],'LineStyle','--','Color','r');
title('混合指标');

count3=0;
for i=1:N
    if fai(i)>kesi 
        count3=count3+1;
    end
end
false_alarm3=count3/n

% % %     
% % % %贡献图
% % % %1.确定造成失控状态的得分
% % % S = Xtest(51,:)*P(:,1:num_pc);
% % % r = [ ];
% % % for i = 1:num_pc
% % %     if S(i)^2/lamda(i) > T2UCL1/num_pc
% % %         r = cat(2,r,i);
% % %     end
% % % end
% % % 
% % % %2.计算每个变量相对于上述失控得分的贡献
% % % cont = zeros(length(r),X_col);
% % % for i = length(r)
% % %     for j = 1:X_col
% % %         cont(i,j) = abs(S(i)/D(i)*P(j,i)*Xtest(51,j));
% % %     end
% % % end
% % % 
% % % %3.计算每个变量的总贡献
% % % CONTJ = zeros(X_col,1);
% % % for j = 1:X_col
% % %     CONTJ(j) = sum(cont(:,j));
% % % end
% % % 
% % % %4.计算每个变量对Q的贡献
% % % e = Xtest(51,:)*(I - P*P');
% % % contq = e.^2;
% % % 
% % % %5. 绘制贡献图
% % %     figure;
% % % % %     subplot(2,1,1);
% % % % %     bar(CONTJ,'k');
% % % % %     xlabel('变量号');
% % % % %     ylabel('T^2贡献率 %');
% % % % % 
% % % % %     subplot(2,1,2);
% % % % %     bar(contq,'k');
% % % % %     xlabel('变量号');
% % % % %     ylabel('Q贡献率 %');
% % % subplot(121),bar(CONTJ),title('T^2统计量贡献图');
% % % subplot(122),bar(contq),title('SPE统计量贡献图');
% % % 
% % % %% 可视化
% % % figure
% % % boxplot(Xtest)
