function SF = func_SF(data)
[row,col]  = size(data);
SF = ones(row,col);
for j=1:col
    y = data(:,j);
    flag = ones(row,1);
    time = 5 %´°¿Ú
    for i=1:row
        start = i-time;
        final = i+time;
        if start>=1&&final<=row
            z_max = max(y(start:final,1));
            z_min = min(y(start:final,1));
            z_mean = mean(y(start:final,1));
            if z_mean~=0
                SF(i,j) = 100*(z_max - z_min)/z_mean;
            end
        end
    end
end
end

        
        
    