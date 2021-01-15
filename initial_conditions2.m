function [domain_matrix,u_IC]=initial_conditions2(delta_x)

%Initial conditions where half the domain is populated with density 0.9 of
%type A particle and half the domain is populated with density 0.9 of type
%B particle.

sizex=200;
sizey=500;

start_m=1;
end_m=100;

%DEFINES INITIAL CONDITIONS FOR STOCHASTIC MODEL
domain_matrix=rand(sizey,sizex);
domain_matrix(1:sizey,start_m:end_m)=2*(domain_matrix(1:sizey,start_m:end_m)<=0.9);
domain_matrix(1:sizey,end_m+1:sizex)=1*(domain_matrix(1:sizey,end_m+1:sizex)<=0.9);

%DEFINES EQUIVALENT INITIAL CONDITIONS FOR PDE
m_IC=zeros(sizex/delta_x,1);
m_IC(1:100/delta_x,1)=0.9*ones(100/delta_x,1);
x_IC=0.9*(m_IC~=0.9*ones(2000,1));
u_IC=[x_IC; m_IC];
