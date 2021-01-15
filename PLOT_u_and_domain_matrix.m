function []=PLOT_u_and_domain_matrix(u, domain_matrix,tau_sum)

%Plot both the results of the PDE and the results of the stochastic
%simulations

PLOT(u,tau_sum)
hold on

mel_matrix=domain_matrix==ones(size(domain_matrix));
xan_matrix=domain_matrix==2*ones(size(domain_matrix));

av_mel_matrix=(mean(mel_matrix));
av_xan_matrix=(mean(xan_matrix));

plot(1:200,av_mel_matrix,'k','LineWidth',1)
hold on
plot(1:200,av_xan_matrix,'k','LineWidth',1)

set(gca,'fontsize', 18);

end