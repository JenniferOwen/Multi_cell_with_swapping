
%Collect parameter values
[motility_ratem, motility_ratex, p_swap,tau_sum]=parameters();

%Run the stochastic model
stochastic_model
%Run the PDE
Imp_method_JO

%Save to run later
pathname = strcat('Swapping_half_and_half_rho_DM_500_',num2str(p_swap),'_Pm_over4_',num2str(motility_ratem), '_Px_', num2str(motility_ratex), '_Time_', num2str(tau_sum), '.mat');
save(pathname)

%Plot both
PLOT_u_and_domain_matrix(u, domain_matrix,tau_sum)

