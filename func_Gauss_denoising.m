
function f=func_Gauss_denoising(num,K)
L=size(num,1); %行数
%高斯的迭代次数K
k=0;
f=num;
F=num;
M = 4; %窗口值为2N+1
while (k<K)
    % 求所有点导数平均值
    sum =1;
    dao = zeros(L,1);
    for m=2:1:L-1
        a = f(m+1,1);
        b = f(m-1,1);
        c =0.5*(a-b);
        sum=sum+c;
    end
 
    d_ave = sum/L;
    % 计算 权值w
    kesi = d_ave;
    w_k(1:L,1)=0;
    for m=1:L
        w_k(m) = exp(-(dao(m)*dao(m))/(2*kesi*kesi));
    end
    for m=1+M:L-M
        A=0;
        B=0;
        for j=-M:1:M
            A = A + f(m+j)*w_k(m+j);
            B = B + w_k(m+j);
        end
        f(m) = A/B;
    end
    k = k+1;
end
end



