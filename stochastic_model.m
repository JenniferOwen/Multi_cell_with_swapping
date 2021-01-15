%This function takes two specie types and allows free movement in all
%directions with swapping with probability p_swap and averages over many repeats

%% parameters that do not change
[motility_ratem, motility_ratex, p_swap, tau_sum]=parameters();


%Use the initial conditions defined in...
[domain_matrix,~]=initial_conditions2(0.1);

[sizex,sizey]=size(domain_matrix);
countm=nnz(domain_matrix==1);
countx=nnz(domain_matrix==2);

t = 0;
% newday=0;

%% start individual simulation
while t < tau_sum
    
    a0 =  (motility_ratem*countm+motility_ratex*countx);
    tau  = (1/a0)*log(1/(rand()));
    t = t + tau;
    
    eventchooser = rand();
    
    [R] = randsample(sizex,1);
    [C] = randsample(sizey,1);
    
    %%DECIDE WHICH CELL WILL MOVE
    if (eventchooser < (motility_ratem*countm)/(a0))
        choose_element=1;
    else
        choose_element=2;
    end
    
    while (domain_matrix(R,C) ~= choose_element)
        [R] = randsample(sizex,1);
        [C] = randsample(sizey,1);
    end
    
    %% SELECT MOVEMENT (2D)
    movement_selector = rand();
    
    %left movement
    if (movement_selector < 0.25)
        if (C ~= 1 ...
                && domain_matrix(R, C-1) == 0)
            domain_matrix(R,C-1) = domain_matrix(R,C);
            domain_matrix(R,C) = 0;
        elseif (C ~= 1 ...
                && domain_matrix(R, C-1) ~= 0 && rand()<p_swap)
            store=domain_matrix(R,C-1);
            domain_matrix(R,C-1) = domain_matrix(R,C);
            domain_matrix(R,C) = store;
        end
        
        %right movement
    elseif (movement_selector < 0.5)
        if (C ~= sizey ...
                && domain_matrix(R, C+1) == 0)
            domain_matrix(R,C+1) = domain_matrix(R,C);
            domain_matrix(R,C) = 0;
        elseif (C ~= sizey ...
                && domain_matrix(R, C+1) ~= 0 && rand()<p_swap)
            store=domain_matrix(R,C+1);
            domain_matrix(R,C+1) = domain_matrix(R,C);
            domain_matrix(R,C) = store;
        end
    elseif (movement_selector <0.75)
        if (R ~= sizex ...
                && domain_matrix(R+1, C) == 0)
            domain_matrix(R+1,C) = domain_matrix(R,C);
            domain_matrix(R,C) = 0;
        end
    else
        if (R ~= 1 ...
                && domain_matrix(R-1, C) == 0)
            domain_matrix(R-1,C) = domain_matrix(R,C);
            domain_matrix(R,C) = 0;
        end        
    end
    t
end




