

close all;
clear all;
clc;
%% read  data 
[num,txt,raw] = xlsread('C:\Users\liu-z\Desktop\bumpData\data20162017.xlsx');
[row,col] = size(num);
data = num(:,5:56);
turn = num(:,1:4);
cold = data(:,1) .* data(:,2) ; %冷量


col = 52;%52个变量
%去除 负荷  COP 《=0的数据
m=1;
for i=1:row
    flag = 1;
    if cold(i,1) <=0 %冷量要大于0
        flag = 0;
    end
    if data(i,4)>data(i,5)  %源水侧进水<出水
        flag = 0;
    end
    if data(i,6)<data(i,7) %负载进水>出水
        flag = 0;
    end
    if data(i,13)>data(i,14) %集水器T<分水器T
        flag = 0;
    end
    if data(i,45)<=0||data(i,46)<=0||data(i,47)<=0||data(i,48)<=0  %功率和流量应该>0
        flag = 0;
    end
    
    for j=3:col
        if data(i,j)<-20||data(i,j)>100
            flag = 0;
            break;
        end
    end
    if flag==1
        data(m,:) = data(i,:);
        m = m +1;
    end
    i = i+1;
end
data = data(1:m-1,:);
row = m-1 ;

cold = data(:,1) .* data(:,2) ; %冷量
set_tem = data(:,3);
ysh = data(:,4:5);
ysh_t=ysh(:,2)-ysh(:,1);
fz  = data(:,6:7);
fz_t = fz(1,:)-fz(2,:);
jishui = data(:,8:13);
fenshui = data(:,14) ;
J1 = data(:,15:19);
J2 = data(:,20:24);
J3 = data(:,25:29);
J4 = data(:,30:34);
J5 = data(:,35:39);
jingxiang = data(:,40:44);
bumpload_dy = data(:,45);
liuliang_dy = data(:,46);
bumpload_kt = data(:,47);
liuliang_kt = data(:,48);
panguan = data(:,49:52);

% figure
% plot(1:row,J1(1:row,1:5),'r');   % 地热管  垂直测点呈现  线性关系
% hold on;
% figure
% plot(1:row,J2(1:row,1:5),'r');   % 地热管  垂直测点呈现  线性关系
% hold on;
% figure
% plot(1:row,J3(1:row,1:5),'r');   % 地热管  垂直测点呈现  线性关系
% hold on;
% figure
% plot(1:row,J4(1:row,1:5),'r');   % 地热管  垂直测点呈现  线性关系
% hold on;
% figure
% plot(1:row,J5(1:row,1:5),'r');   % 地热管  垂直测点呈现  线性关系
% hold on;
% figure
% plot(1:row,jingxiang(1:row,1),'b',1:row,jingxiang(1:row,2),'r',1:row,jingxiang(1:row,3),'k',1:row,jingxiang(1:row,4),'y',1:row,jingxiang(1:row,5),'g'); 
% title('地热管2号径向温度');
% hold on;
% 
% figure
% plot(1:row,data(1:row,2),'b');   % 系统功耗
% title('系统功耗');
% hold on;

% figure
% plot(1:row,set_tem(1:row,:),'b'); 
% title('设定温度');
% hold on;
% 
% figure
% plot(1:row,ysh(1:row,:),'b'); 
% title('原水侧温度');
% hold on;
% 
% figure
% plot(1:row,fz(1:row,:),'b'); 
% title('负载侧温度');
% hold on;
% 
% figure
% plot(1:row,jishui(1:row,:),'b'); 
% title('集水器温度');
% hold on;
% figure
% plot(1:row,fenshui(1:row,:),'k'); 
% title('分水器温度');
% hold on;
% 
% figure
% plot(1:row,panguan(1:row,1:2),'r',1:row,panguan(1:row,3:4),'b'); 
% title('风机盘管进出1红2绿');
% hold on;
% 
% figure
% plot(1:row,liuliang_dy(1:row,:),'r',1:row,liuliang_kt(1:row,:),'b'); 
% title('流量1地缘测红2空调侧兰');
% hold on;
% % 
% figure
% subplot(2,1,1)
% plot(1:row,bumpload_dy(1:row,:),'r'); 
% title('水泵功率原始数据(地源侧)');
% hold on;
% 
% subplot(2,1,2)
% plot(1:row,D(1:row,45),'r'); 
% axis([1 1000 1 100]);
% title('剔除异常值的数据');
% hold on;
% 
% figure
% subplot(2,1,1)
% plot(1:row,bumpload_dy(1:row,:),'r'); 
% title('流量原始数据(地源侧)');
% hold on;
% 
% subplot(2,1,2)
% plot(1:row,D(1:row,45),'r'); 
% axis([1 1000 1 100]);
% title('剔除异常值的数据');
% hold on;

% % figure
% % plot(1:row,panguan(1:row,1:2),'r'); 
% % axis([1 1000 1 30]);
% % title('风机盘管进出1红2绿');
% % hold on;
% 
D1 = data_clean(data,10);   %D1是剔除异常值过的数据
[row,col] = size(D1);
cold = D1(:,1).*D1(:,2);
D1 = [cold,D1(:,3:col)]; %计算出制冷量
[row,col] = size(D1);
%%
% save('dealed_data','D1');
% xlswrite('dealed_data1', D1)
%%
% figure
% subplot(2,1,1)
% plot(1:row,D1(1:row,2),'r'); 
% axis([1 1000 0 5]);
% title('水泵功率原始数据(地源侧)');
% hold on;

% subplot(2,1,2)
% plot(1:row,D(1:row,45),'r'); 
% axis([1 1000 20 60]);
% title('剔除异常值的数据');
% hold on;
% 
% figure
% subplot(2,1,1)
% plot(1:row,liuliang_dy(1:row,:),'r'); 
% axis([1 1000 1 3]);
% title('流量原始数据(地源侧)');
% hold on;
% 
% subplot(2,1,2)
% plot(1:row,D(1:row,46),'r'); 
% axis([1 1000 1 3]);
% title('剔除异常值的数据');
% hold on;
%%  去噪
D2 =D1;
for i=48:51
[D2(:,i),xd,lxd] = wden(D1(:,i),'minimaxi','s','one',6,'db2');  %小波去噪
end
for i=3:7
    [D2(:,i),xd,lxd] = wden(D1(:,i),'minimaxi','s','one',6,'db2');  %小波去噪
end
[D2(:,1),xd,lxd] = wden(D1(:,1),'minimaxi','s','one',6,'db2');  %小波去噪 制冷量
[D2(:,13),xd,lxd] = wden(D1(:,13),'minimaxi','s','one',6,'db2');  %小波去噪  分水器
% for i=1:col
% figure
% subplot(2,1,1)
% plot(1:row,D1(1:row,i),'r'); 
% % axis([1 1000 0 5]);
% title('D1');
% hold on;
% subplot(2,1,2)
% plot(1:row,D2(1:row,i),'r'); 
% % axis([1 1000 0 5]);
% title('D2');
% hold on;
% end

%%  数据标准化
%提取符合正太分布的变量作为特征变量
% 数据矩阵标准化
% 标准化的数据均值为0，标准差为1
% 标准化函数zscore(x)
% 就是原数据减去均值，再除以标准差（无偏估计）
D3 = zeros(row,11);
D3 = [D2(:,1),D2(:,3:7),D2(:,13),D2(:,48:51)];
D3=zscore(D3); %标准化数据；

[row,col] = size(D3);
% figure
% plot(1:row,D3(1:row,1),'r');
% hold on;

%% 稳态检测
SF=func_SF(D3);
% for i = 1:col
% figure
% subplot(2,1,1)
% plot(1:row,SF(1:row,i),'k');
% hold on;
% subplot(2,1,2)
% plot(1:row,D3(1:row,i),'k');
% hold on;
% end
m=1;
for i=1:row
    flag = 1;
    for j=1:col
        t=1;
        if SF(i,j)>1000
            t = 0;
        end
        flag = flag*t;
    end
    if flag==1
        D3(m,:)=D3(i,:)
        m=m+1;
    end
end
D4 = D3(1:m-1,:);
l = row;
[row,col] = size(D4);
% for i = 1:col
% figure
% subplot(2,1,1)
% plot(1:l,SF(1:l,i),'k');
% hold on;
% subplot(2,1,2)
% plot(1:row,D4(1:row,i),'k');
% hold on;
% end
%%  测试数据
test = D4(201:300,:);
test(1:100,2) =1.5.*ones(100,1)+ test(1:100,2) 
% D4 = [D4(1:99,:);D4(151:col,:)];
% [row,col] = size(D4);

%% 聚类
% data = [D4(:,1:2),D4(:,4)];
options = statset('Display','final');
gm = gmdistribution.fit(D4,2,'Options',options);

idx = cluster(gm,D4);
cluster1 = (idx == 1);
cluster2 = (idx == 2);
% cluster3 = (idx == 3);
% cluster4 = (idx == 4);
% cluster5 = (idx == 5);
% cluster6 = (idx == 6);
% cluster7 = (idx == 7);
% scatter3(data(cluster1,1),data(cluster1,2),data(cluster1,3),10,'r+');
% hold on
% scatter3(data(cluster2,1),data(cluster2,2),data(cluster2,3),10,'bo');
% hold on
% scatter3(data(cluster3,1),data(cluster3,2),data(cluster3,3),10,'k*');
% hold on
% scatter3(data(cluster4,1),data(cluster4,2),data(cluster4,3),10,'g>');
% hold on
% scatter3(data(cluster5,1),data(cluster5,2),data(cluster5,3),10,'y<');
% % hold on
% % scatter3(data(cluster6,1),data(cluster6,2),data(cluster6,3),10,'m+');
% % hold on
% % scatter3(data(cluster7,1),data(cluster7,2),data(cluster7,3),10,'c*');
% hold off
% 

%% 
TTT1 = D4(cluster1,:);
TTT2 = D4(cluster2,:);
% TTT3 = D4(cluster3,:);
% TTT4 = D4(cluster4,:);
% TTT5 = D4(cluster5,:);



%% %%%%%%%%%%%%%%%%%%%%%%%%%在线测试%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%在线监测：

%匹配模式
idx = cluster(gm,test);
c1 = (idx == 1);
c2 = (idx == 2);
% c3 = (idx == 3);
% c4 = (idx == 4);
% c5 = (idx == 5);
test_c1 = test(c1,:);
test_c2 = test(c2,:);
% test_c3 = test(c3,:);
% test_c4 = test(c4,:);
% test_c5 = test(c5,:);

[T2UCL1,QUCL1] = func_PCA_detection(TTT1,test_c1);
[T2UCL2,QUCL2] = func_PCA_detection(TTT2,test_c2);
% [T2UCL3,QUCL3] = func_PCA_detection(TTT3,test_c3);
% [T2UCL4,QUCL4] = func_PCA_detection(TTT4,test_c4);
% [T2UCL5,QUCL5] = func_PCA_detection(TTT5,test_c5);



