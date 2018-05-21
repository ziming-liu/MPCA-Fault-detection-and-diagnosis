function final = func_SF(data)
[row,col]  = size(data);
SF = ones(row,col);
len = [1:row]
for j=1:col
    y = data(:,j);
%     flag = ones(row,1);
    time = 6 %窗口
    len2 = row-6;
    z_max= max([y(1:row-6,:),y(2:row-5,:),y(3:row-4,:),y(4:row-3,:),y(5:row-2,:),y(6:row-1,:),y(7:row,:)],[],2);
    z_min= min([y(1:row-6,:),y(2:row-5,:),y(3:row-4,:),y(4:row-3,:),y(5:row-2,:),y(6:row-1,:),y(7:row,:)],[],2);
    z_mean= mean([y(1:row-6,:),y(2:row-5,:),y(3:row-4,:),y(4:row-3,:),y(5:row-2,:),y(6:row-1,:),y(7:row,:)],2);
    SF(3:len2+2,j)= 100.*(z_max - z_min)./z_mean;

% %     for i=1:row
% %         start = i-time;
% %         final = i+time;
% %         if start>=1&&final<=row
% %             z_max = max(y(start:final,1));
% %             z_min = min(y(start:final,1));
% %             z_mean = mean(y(start:final,1));
% %             if z_mean~=0
% %                 SF(i,j) = 100*(z_max - z_min)/z_mean;
% %             end
% %         end
% %     end
end
flag = abs(sum(SF,2))  %按行求和
% figure
% subplot(2,1,1);
% plot(len,data(len,4),'k');
% % axis([1,row,-1,100000]);
% hold on;
r1 = find(flag<900);
r2 = find(flag>=900);
result = flag;
result(r1) = 1;
result(r2) = 0;
% subplot(2,1,2)
% plot(len,result,'k')
% hold on;
% axis([1,row,-1,2]);
[a1,a2,v] = find(result==1)
final = data(a1,:);
[row2,col2] = size(final)
len2 = [1:row2]
% figure
% subplot(2,1,1);
% plot(len,data(len,4),'k');
% % axis([1,row,-1,100000]);
% hold on;
% subplot(2,1,2);
% plot(len2,final(len2,4),'k');
% hold on
end

        
        
    