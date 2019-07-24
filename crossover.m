% uniform arthmetic crossover
function child_list = crossover(parent_selection_solution)
rand_num = rand();
p_crossover = 0.6;
parent_1 = parent_selection_solution(:,1);
parent_2 = parent_selection_solution(:,2);
child_list = [];

if(rand_num > p_crossover)
    child_list = parent_selection_solution;
else   
   child_1(1) = round(rand_num*parent_1(1) + (1-rand_num)*parent_2(1), 2); 
   child_1(2) = round(rand_num*parent_1(2) + (1-rand_num)*parent_2(2), 2);
   child_1(3) = round(rand_num*parent_1(3) + (1-rand_num)*parent_2(2), 2);
   
   child_2(1) = round((1-rand_num)*parent_1(1) + rand_num*parent_2(1), 2); 
   child_2(2) = round((1-rand_num)*parent_1(2) + rand_num*parent_2(2), 2);
   child_2(3) = round((1-rand_num)*parent_1(3) + rand_num*parent_2(2), 2);
   
   child_list = [child_list, transpose(child_1), transpose(child_2)];
end
end