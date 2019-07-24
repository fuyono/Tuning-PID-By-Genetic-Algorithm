population = 50;
generation = 250;
p_crossover = 0.6;
p_mutation = 0.25;

% generate init solution with polulation size
kp_range = [2, 18];
ti_range = [1.05, 9.42];
td_range = [0.26, 2.37];

kp_solution = transpose((kp_range(1,2) - kp_range(1,1)).*rand(population,1) + kp_range(1,1));
kp_solution = round(kp_solution, 2);

ti_solution = transpose((ti_range(1,2) - ti_range(1,1)).*rand(population,1) + ti_range(1,1));
ti_solution = round(ti_solution, 2);

td_solution = transpose((td_range(1,2) - td_range(1,1)).*rand(population,1) + td_range(1,1));
td_solution = round(td_solution, 2);

solution = [kp_solution; ti_solution; td_solution; zeros(1,population)];

% variables that would be used in the loop
best_fitness_list = [];
generation_list = [];
child_list = [];
% maximum 150 generation
for i = 1 : generation
    % Roulette Wheel Selection to select parent 
    fitness_list = zeros(1, population);
    fitness_sum = 0;
    % loop each individul to calculate total fitness
    for j = 1: population
        [ISE,t_r,t_s,M_p] = perfFCN(solution(:,j));
        current_fitness = fitness([ISE,t_r,t_s,M_p]);
        fitness_list(1, j) = current_fitness;
        solution(4,j) = current_fitness;
        fitness_sum = fitness_sum + current_fitness;
    end
    
    sum_probability = 0;
    probability_list = zeros(1, population);
    % calcualte probility for each individual
    for j = 1 : population
        sum_probability = sum_probability + (fitness_list(1, j) / fitness_sum);
        probability_list(1, j) = sum_probability;
    end
    
    % parent selection
    parent_selection_count = 0;
    parent_selection_soltuion = [];
    % only select 2 parents
    % pay attention to duplicate parents
    while parent_selection_count < 2
        rand_num = rand();
        for j = 1: population
            if j == 1
                if rand_num < probability_list(1, j)
                    parent_selection_soltuion = [parent_selection_soltuion, solution(:,j)];
                    parent_selection_count = parent_selection_count + 1;
                end
            elseif j > 1 && j < population
                if rand_num > probability_list(1, j) && rand_num < probability_list(1, j+1)
                    parent_selection_soltuion = [parent_selection_soltuion, solution(:,j)];
                    parent_selection_count = parent_selection_count + 1;
                end
            else
                if rand_num > probability_list(1, j)
                    parent_selection_soltuion = [parent_selection_soltuion, solution(:,j)];
                    parent_selection_count = parent_selection_count + 1;
                end
            end
        end
    end
    
    child_list = crossover(parent_selection_soltuion);
    child_1 = mutation(child_list(:,1));
    child_2 = mutation(child_list(:,2));
    
    [ISE,t_r,t_s,M_p] = perfFCN(child_1);
    current_fitness = fitness([ISE,t_r,t_s,M_p]);
    child_1 = [child_1; current_fitness];
    
    [ISE,t_r,t_s,M_p] = perfFCN(child_2);
    current_fitness = fitness([ISE,t_r,t_s,M_p]);
    child_2 = [child_2; current_fitness];
    
    parent_selection_soltuion = [child_1,child_2];
   
    % sort parent_selection_solution and solution bases on fitness in
    % ascending order
    
    [temp, order] = sort(parent_selection_soltuion(4,:));
    parent_selection_soltuion = parent_selection_soltuion(:, order);
    
    [temp, order] = sort(solution(4,:));
    solution = solution(:, order);

    % survival selection
    if parent_selection_soltuion(4, 2) > solution(4,1)
        % replace the worst solution with best parent selection
        solution(:,1) = parent_selection_soltuion(:,2);
        % replace the second worst solution with second best parent
        % selection
        solution(:,2) = parent_selection_soltuion(:,1);
    end
    
    best_fitness_list = [best_fitness_list, solution(4,end)];
    generation_list = [generation_list, i];
    if i == generation
        disp(solution(:,end))
    end
end

plot(generation_list, best_fitness_list)
title('Best Fitness Value for 250 Generations')
xlabel('Generations') 
ylabel('Fitness of the Best Solution in each Generation') 

