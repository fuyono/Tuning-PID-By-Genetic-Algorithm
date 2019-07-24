%uniform mutation
function new_child = mutation(child)
p_mutation = 0.25;
range = [2 18; 1.05 9.42; 0.26 2.37];
new_child = zeros(3, 1);
for i = 1:3
    rand_num = rand();
    if(rand_num > p_mutation)
        new_child(i, 1) = child(i, 1);
    else
        new_child(i) = round(range(i, 1) + (range(i, 1)-range(i, 2))*rand, 2);
    end   
end
end