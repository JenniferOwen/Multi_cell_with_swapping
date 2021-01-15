function [domain_matrix,u_IC]=initial_conditions(delta_x)

%Initial conditions where domain is full of type A particle at density 0.5
%across the domain except for in the centre where there it is fully
%populated with type B particle.

sizex=200;
sizey=500;

start_m=80;
end_m=120;

%DEFINES INITIAL CONDITIONS FOR STOCHASTIC MODEL
domain_matrix=rand(sizey,sizex);
domain_matrix=2*(domain_matrix<=0.5);
domain_matrix(1:sizey,start_m:end_m)=ones(sizey,-start_m+end_m+1);


%DEFINES EQUIVALENT INITIAL CONDITIONS FOR PDE
m_IC=zeros(sizex/delta_x,1);
m_IC(79/delta_x+6:121/delta_x-5,1)=ones(41/delta_x,1);
x_IC=0.5*(m_IC~=ones(2000,1));
u_IC=[x_IC; m_IC];

%%Check that they match

% figure
% 
% PLOT(u_IC,0)
% hold on
% 
% mel_matrix=domain_matrix==ones(sizey,sizex);
% xan_matrix=domain_matrix==2*ones(sizey,sizex);
% 
% av_mel_matrix=(mean(mel_matrix));
% av_xan_matrix=(mean(xan_matrix));
% 
% bar(1:200,av_mel_matrix,'k')
% hold on
% bar(1:200,av_xan_matrix,'g')

