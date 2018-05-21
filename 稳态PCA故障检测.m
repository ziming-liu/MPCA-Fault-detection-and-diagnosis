

close all;
clear all;
clc;
% 读取数据
[num,txt,raw] = xlsread('C:\Users\liu-z\data\data_pre.xlsx');
xtrain = num(11674:13565,1:6);
xtest = num(17961:18600,1:6);
%构造漂移故障
t = [1:640]'
t0 = ones(640,1)
xtest(1:640,6) = xtest(1:640,6)+((t-t0).*0.3125)
%调用故障检测与诊断算法
func_PCA_detection(xtrain,xtest)


% N=size(xtest,1);
% monitortime=200;
% %% 调用自编的PCA函数
% [P,T_test,SPE,T_alpha,SPE_alpha,contri6,t4,x,test_x,Latent]=detect(xtrain,xtest,N,monitortime);
% %%  绘制必要的曲线图形
% %********************************************
% figure(1);
% subplot(211),
% x_row=1:N;  
% T_alpha=T_alpha*(ones(size(x_row)));
% plot(x_row,T_alpha,'r-','LineWidth',2.5),hold on
% plot(T_test,'b-'); grid on;   xlabel('样本点');ylabel('T^2统计量');
% subplot(212),
% x_row=1:N;   
% SPE_alpha=SPE_alpha*(ones(size(x_row)));
% plot(x_row,SPE_alpha,'r-','LineWidth',2.5),hold on
% plot(SPE,'b-'); grid on;  xlabel('样本点');ylabel('SPE统计量');
% % 误报率
% 
% 
% count=0;
% for i=1:N
%     if T_test(i)>T_alpha(i)
%         count=count+1;
%     end
% end
% false_alarm=count/N
% count2=0;
% for i=1:N
%     if SPE(i)>SPE_alpha(i)
%         count2=count2+1;
%     end
% end
% false_alarm2=count2/N
% figure(2);
% subplot(121),bar(t4),title('T^2统计量贡献图');
% subplot(122),bar(contri6),title('SPE统计量贡献图');
% figure(3)
% boxplot(test_x)
% 







