function[y] = fitness(x)
ISE = x(1,1);
t_r = x(1,2);
t_s = x(1,3);
M_p = x(1,4);
sum = 0;

if ~isnan(t_r)
    sum = sum + (1/t_r);
end

if ~isnan(t_s)
    sum = sum + (1/t_s);
end

if ~isnan(M_p)
   sum = sum + (1/M_p);
end

y = round((1/ISE) + sum, 2);