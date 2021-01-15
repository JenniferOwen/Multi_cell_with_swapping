function []=visualise2(domain_matrix)

%Can be used to visualise the stochastic simulation 
[sizex,sizey]=size(domain_matrix);

for i=1:sizex
    for j=1:sizey
        if domain_matrix(i,j)==1
            plot(i-0.5,j-0.5, 'rs','MarkerSize', 5, 'MarkerFaceColor', 'r')
            hold on
        elseif domain_matrix(i,j)==2
            plot(i-0.5,j-0.5, 'bs','MarkerSize', 5, 'MarkerFaceColor', 'b')
            hold on
        end
    end
end