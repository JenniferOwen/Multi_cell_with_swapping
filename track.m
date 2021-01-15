%This function takes two specie types and allows free movement in all
%directions with swapping and tracks the total distance moved of each cell
%in the simulation.

relationship_p=zeros(5,5);

%% parameters that do not change
for c=1:5 %for all different densities
    for rho=1:5 %for all possible rhos
        conc=c*0.2;
        p_swap=rho*0.25-0.25;
        
        
        num_repeats=20;
        tau_sum=30;
        
        motility_ratem=1;
        
        domain_matrix=rand(num_repeats, 200);
        if conc~=1
            domain_matrix(domain_matrix<(1-conc))=0;
            domain_matrix(domain_matrix>=(1-conc))=1; 
        else
            domain_matrix=ones(num_repeats,200);
        end
        
        
        [sizex,sizey]=size(domain_matrix);
        
        t = 0;
        i = 1;
        % newday=0;
        starting_position=100;
        
        tracked_matrix=zeros(size(domain_matrix));
        tracked_matrix(:,starting_position)=ones(1,sizex);
        
        countm=nnz(domain_matrix);
        
        %% start individual simulation
        delta=1;
        while t < tau_sum
            
            a0 =  (motility_ratem*countm);
            tau  = (1/a0)*log(1/(rand()));
            t = t + tau;
            
            T(i)=t;
            M(:,:,i)=tracked_matrix;
            i=i+1;
            
            eventchooser = rand();
            
            [R] = randsample(sizex,1);
            [C] = randsample(sizey,1);
            
            %%DECIDE WHICH CELL WILL MOVE
            choose_element=1;
            
            while (domain_matrix(R,C) ~= choose_element)
                [R] = randsample(sizex,1);
                [C] = randsample(sizey,1);
            end
            
            %% SELECT MOVEMENT (2D)
            movement_selector = rand();
            
            %left movement
            if (movement_selector < 0.5)
                if (C ~= 1 ...
                        && domain_matrix(R, C-1) == 0)
                    domain_matrix(R,C-1) = domain_matrix(R,C);
                    domain_matrix(R,C) = 0;
                    if tracked_matrix(R,C)==1
                        tracked_matrix(R,C-1) = tracked_matrix(R,C);
                        tracked_matrix(R,C) = 0;
                    end
                elseif (C ~= 1 ...
                        && domain_matrix(R, C-1) ~= 0 && rand()<p_swap)
                    store=domain_matrix(R,C-1);
                    domain_matrix(R,C-1) = domain_matrix(R,C);
                    domain_matrix(R,C) = store;
                    store=tracked_matrix(R,C-1);
                    tracked_matrix(R,C-1) = tracked_matrix(R,C);
                    tracked_matrix(R,C) = store;
                end
                
                %right movement
            else
                if (C ~= sizey ...
                        && domain_matrix(R, C+1) == 0)
                    domain_matrix(R,C+1) = domain_matrix(R,C);
                    domain_matrix(R,C) = 0;
                    if tracked_matrix(R,C)==1
                        tracked_matrix(R,C+1) = tracked_matrix(R,C);
                        tracked_matrix(R,C) = 0;
                    end
                elseif (C ~= sizey ...
                        && domain_matrix(R, C+1) ~= 0 && rand()<p_swap)
                    store=domain_matrix(R,C+1);
                    domain_matrix(R,C+1) = domain_matrix(R,C);
                    domain_matrix(R,C) = store;
                    store=tracked_matrix(R,C+1);
                    tracked_matrix(R,C+1) = tracked_matrix(R,C);
                    tracked_matrix(R,C) = store;
                end
                
            end
            
            
            
        end
        
        position=zeros(length(T),num_repeats);
        tracked_position=zeros(length(T),num_repeats);
        
        for i=1:length(T) %for all time steps collate the data
            for j=1:num_repeats
                [R,C]=find(M(j,:,i));
                position(i,j)=C;
                tracked_position(i,j)=abs(C-starting_position);
            end
        end
        
        S=zeros(length(T),num_repeats);
        p=zeros(1,num_repeats);
        
        for j=1:num_repeats %for each repeat
            tracked_j=position(:,j);
            S_store=zeros(1,length(T));
            for i=2:length(T)
                S_store(i)=(tracked_j(i)-tracked_j(i-1))^2;
            end
            S(:,j)=cumsum(S_store);
            pfit=polyfit(T,transpose(S(:,j)),1);
            p(j)=pfit(1);
        end
        relationship(c,rho)=mean(p);
        save('relationship.mat','relationship');
    end
end


heatmap(relationship, 'XData', [0, 0.25,0.5,0.75, 1], 'YData', [0.2, 0.4,0.6,0.8, 1], 'Xlab', 'rho', 'Ylab', 'Density')

% for i=1
%     plot(T,abs(tracked_position(i,:)))
%     hold on 
%     plot(T,S)
%     hold on
%     p=polyfit(T,transpose(S),1);
%     name=strcat('rho=', num2str(p_swap), ' C= ',num2str(conc), ' and S=', num2str(p(1)),'t');
%     title(name); 
% end



