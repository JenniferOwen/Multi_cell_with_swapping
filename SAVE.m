function SAVE(u,rho,P_m,T_final,x_size)

pathname = strcat('Implicit_method_79to121_rho_',num2str(rho),'_Pm_',num2str(P_m),'_Tfinal_', num2str(T_final),'_domain_size_', num2str(x_size), '.mat');
save(pathname,'u')

end