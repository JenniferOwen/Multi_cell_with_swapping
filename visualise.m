function []=visualise(domain_matrix)

%Can be used to visualise the stochastic simulation if it is 1D

%make grid
close all
plot(1:length(domain_matrix), ones(1,length(domain_matrix)), 'k');
plot(1:length(domain_matrix), zeros(1,length(domain_matrix)), 'k');
hold on
for i=0:length(domain_matrix)
    plot(i*ones(1,2),0:1, 'k')
    hold on
end

for i=1:length(domain_matrix)
    if domain_matrix(i)==1
        plot(i-0.5,0.5, 'ro','MarkerSize', 22, 'MarkerFaceColor', 'r')
        hold on
    else
        plot(i-0.5,0.5, 'bo','MarkerSize', 22, 'MarkerFaceColor', 'b')
        hold on
    end
end
set(gca, 'xtick', []);
set(gca, 'ytick', []);
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'Position',  [100, 100, 1500, 50])


end
