function S=func_R_test(num,row)
L=row;
X = num ;
x_f = zeros(L,1);
S  = zeros(L,1);
v = zeros(L,1);
kexi =zeros(L,1);
R = zeros(L,1);
lamda1 = 0.5;
lamda2 = 0.1;
lamda3 = 0.01;
R_crit = 1.54;
sum = 0;
for i=1:10
    a = X(i,1);
    sum = sum+a;
end
mean = sum/10;
x_f(1,1) = mean ; 
sum = 0;
for i=1:10
    t = X(i,1);
    sum = sum + (t - mean)*(t - mean);
end
v0 = sum/10;
v(1,1) = v0;
kexi(1,1) = 2*v0;
for i = 2:L
    x_f(i,1) = lamda1*X(i,1) + (1-lamda1)*x_f(i-1,1);
    v(i,1) = lamda2 * (X(i,1) - x_f(i-1,1))^2 + (1-lamda2) * v(i-1,1);
    kexi(i,1) = lamda3 * (X(i,1) -  X(i-1,1))^2 + (1-lamda3) * kexi(i-1,1);
    a = v(i,1);
    s1 = ((2-lamda1)/2)*a;
    b = kexi(i,1);
    s2 = 0.5*b ;
    if s2~=0
        R(i,1) = s1/s2;
    end
    if R(i,1) < R_crit
        S(i,1) = 1;  %ÎÈÌ¬
    else
        S(i,1) = 0;
    end
end
end
