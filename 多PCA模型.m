% % 采用第五届泰迪杯数据竞赛中美国伊利诺伊大学新加坡高等数字科学中心提供的
% % 三机组水冷中央空调系统数据集。
% % 本程序实现多模式匹配的PCA模型。
% % 刘子铭
% % 5.3.2018


close all;
clear all;
clc;
%% read  data 
[num,txt,raw] = xlsread('C:\Users\liu-z\data\data_pre.xlsx');
%num =[num(14326:14825,1:2),num(14326:14825,4:5)];
%  num  =[num(1:5000,1:2),num(1:5000,4:5)];
% xtrain = [num(11674:13565,1:6);num(79482:79750,1:6);num(43867:44367,1:6)];
% xtest = num(17614:18645,1:6);
xtrain = num(1:80000,1:6);
xtest  = num(20001:21000,1:6);


% len = [1:20000];
% figure
% plot(len,xtrain,'r')
% axis([1,20000,0,40])
% hold on;
% t = [1:250]'
% t0 = ones(250,1)

xtest(:,2)= xtest(:,2).*1.1
% t = [1:1032]'
% t0=ones(1032,1);
% xtest(:,1) = xtest(:,1)+((t-t0).*0.0025)
%%%%%%%%%%%%%%%%%%%%data process %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % [x_train1] = func_process(xtrain);
% % % [x_test1] = func_process(xtest);
% % 可视化%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [row,col] = size(x_train1);
% len = [1:row]
% % figure
% % subplot(2,1,1)
% plot(len,x_train1(len,1),'r',len,x_train1(len,2),'b');
% hold on;
% % grid on
% % subplot(2,1,2)
% % plot(len,x_train1(len,10),'y')
% % hold on
% % grid on
% 
% figure 
% plot(len,x_train1(len,3),'r',len,x_train1(len,6),'b');
% hold on;
% grid on;

% figure
% plot(len,x_train1(len,8),'r',len,x_train1(len,9),'b')
% hold on;
% grid on;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%state detection%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:5 % 迭代次数
x_train1=func_SF(xtrain);

x_test1= func_SF(xtest);

end
% % % 可视化%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % [row,col] = size(x_train1);
% % len = [1:row]
% % figure
% % % subplot(2,1,1)
% % plot(len,x_train1(len,1),'r',len,x_train1(len,2),'b');
% % hold on;
% % grid on
% % % subplot(2,1,2)
% % % plot(len,x_train1(len,10),'y')
% % % hold on
% % % grid on
% % 
% % figure 
% % plot(len,x_train1(len,3),'r',len,x_train1(len,6),'b');
% % hold on;
% % grid on;
% 
% % figure
% % plot(len,x_train1(len,8),'r',len,x_train1(len,9),'b')
% % hold on;
% % grid on;
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % [row_train1,col_train1] = size(x_train1);
% % len=[1:row_train1];
% % figure
% % subplot(2,1,1)
% % plot(len,x_train1(len,1),'r',len,x_train1(len,2),'b');
% % hold on;
% % grid on
% % subplot(2,1,2)
% % plot(len,x_train1(len,10),'y')
% % hold on
% % grid on
% % 
% % figure 
% % plot(len,x_train1(len,3),'r',len,x_train1(len,6),'b');
% % hold on;
% % grid on;
% % 
% % figure
% % plot(len,x_train1(len,8),'r',len,x_train1(len,9),'b')
% % hold on;
% % grid on;
% %%%%%%%%%%%%%%%%%%%%%%模型划分%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % 
% % save('traindata','x_train1');
% % % xlswrite('testdata', x_train1);
% % save('testdata','x_test1');
% % % xlswrite('testdata', x_test1);
% %%
% % x_test1 = x_test1(2001:2300,:)
% % [row2,col2] = size(x_test1)
% % bl = 1
% % a1 = int8(row2/2)
% % x_test1(:,bl) = x_test1(:,bl)+5.*ones(300,1)
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% % 
% % % 聚类

options = statset('Display','final');
gm = gmdistribution.fit(x_train1,3,'Options',options);
idx = cluster(gm,x_train1);
cluster1 = (idx == 1);
cluster2 = (idx == 2);
cluster3 = (idx == 3);
% % cluster4 = (idx == 4);
% % cluster5 = (idx == 5);
% % % cluster6 = (idx == 6);
% % % cluster7 = (idx == 7);
% % % scatter3(data(cluster1,1),data(cluster1,2),data(cluster1,3),10,'r+');
% % % hold on
% % % scatter3(data(cluster2,1),data(cluster2,2),data(cluster2,3),10,'bo');
% % % hold on
% % % scatter3(data(cluster3,1),data(cluster3,2),data(cluster3,3),10,'k*');
% % % hold on
% % % scatter3(data(cluster4,1),data(cluster4,2),data(cluster4,3),10,'g>');
% % % hold on
% % % scatter3(data(cluster5,1),data(cluster5,2),data(cluster5,3),10,'y<');
% % % % hold on
% % % % scatter3(data(cluster6,1),data(cluster6,2),data(cluster6,3),10,'m+');
% % % % hold on
% % % % scatter3(data(cluster7,1),data(cluster7,2),data(cluster7,3),10,'c*');
% % % hold off
% % 
% % 

TTT1 = x_train1(cluster1,:);
TTT2 = x_train1(cluster2,:);
TTT3 = x_train1(cluster3,:);
% % TTT4 = x_train1(cluster4,:);
% % TTT5 = x_train1(cluster5,:);
% % % TTT6 = x_train1(cluster6,:);
% % % TTT7 = x_train1(cluster7,:);
% % 
% % 
% % %%%%%%%%%%%%%%%%%%%%%%%%在线测试%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % 
% % 
% % % 在线监测：
% % % 模式
% % % 匹配
idx = cluster(gm,x_test1);
c1 = (idx == 1);
c2 = (idx == 2);
c3 = (idx == 3);
% % c4 = (idx == 4);
% % c5 = (idx == 5);
% % % c6 = (idx == 6);
% % % c7 = (idx == 7);
test_c1 = x_test1(c1,:);
test_c2 = x_test1(c2,:);
test_c3 = x_test1(c3,:);
% % test_c4 = x_test1(c4,:);
% % test_c5 = x_test1(c5,:);
% % % test_c6 = x_test1(c6,:);
% % % test_c7 = x_test1(c7,:);

[T2UCL1,QUCL1] = func_PCA_detection(TTT1,test_c1);
[T2UCL2,QUCL2] = func_PCA_detection(TTT2,test_c2);
[T2UCL3,QUCL3] = func_PCA_detection(TTT3,test_c3);
% % [T2UCL4,QUCL4] = func_PCA_detection(TTT4,test_c4);
% % [T2UCL5,QUCL5] = func_PCA_detection(TTT5,test_c5);
% % % [T2UCL4,QUCL4] = func_PCA_detection(TTT6,test_c6);
% % % [T2UCL5,QUCL5] = func_PCA_detection(TTT7,test_c7);

func_PCA_detection(x_train1,x_test1);
























% % 测试集
% % [num,txt,raw] = xlsread('C:\Users\liu-z\data\data_3.xlsx');
% % [row2,col2] = size(num);
% % x_origin = num;
% % x_process = [x_origin(:,1:6),x_origin(:,16:17),x_origin(:,28),x_origin(:,50)];
% % len2 = [1:row2]
% % figure
% % plot(len2,x_process(len2,8),'r',len2,x_process(len2,9),'b')
% % hold on;
% % grid on;


