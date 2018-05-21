function x=data_clean(data,n)

w = 1+0.4*log(n);%Ğ¤Î¬ÀÕÏµÊı£»
[row,col] = size(data);
flag = ones(row,1);
for i=1:col
    x_mean = sum(data(:,i))/row;
    S = std(data(:,i));
    for j=1:row
        if abs(data(j,i)-x_mean)>w*S
            flag(j,1) = 0;
        end
    end
end

% % 
% % for i=5:13
% %     x_mean = sum(data(:,i))/row;
% %     S = std(data(:,i));
% %     for j=1:row
% %         if abs(data(j,i)-x_mean)>w*S
% %             flag(j,1) = 0;
% %         end
% %     end
% % end
% % cold = data(:,1);
% % x_mean = sum(cold)/row;
% %     S = std(cold);
% %     for j=1:row
% %         if abs(cold(j,1)-x_mean)>w*S
% %             flag(j,1) = 0;
% %         end
% %     end

m=1;
for i=1:row
    if flag(i,1)==1
        data(m,:)=data(i,:);
        m=m+1;
    end
end
x = data(1:m-1,:);
end



