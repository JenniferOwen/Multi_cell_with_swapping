

format long

%Turn save and plot off and on
% save_on=1;
% plot_on=1;

x_size=200;
% T_final=1001;
delta_t=0.25;
delta_x=0.1;
%
% Simpson initial conditions
[~,u_IC]=initial_conditions2(delta_x);
[motility_ratem, motility_ratex, p_swap,tau_sum]=parameters();

% This function is designed to compute the numerical solution of the PDE
% for the one dimension Individual Based Model with multi-step
% dynamic with swapping. It receives in input all the initial parameters and
%return the numerical solution for the PDE at time T_final.
% The numerical solution is obtained with an Implicit Euler Method and
% Picard Iteration. The boundary conditions (BC) are Neuman type equal to 0

%By Jennifer Owen
%Created 7/12/16
%Last Modified 08/11/2019


% INPUT
% x_size: number of column of the lattice
% u_IC: initial conditions
% N: number of steps per movement
% T_final: final time for each simulation
% delta_x: spatial step for the Euler method
% delta_t: time step for the Euler method
% P: motility parameter

% OUTPUT
% u: vector of the numerical solution at time T_final


%% Initialisation
rho=p_swap;
P_m=motility_ratem;
P_x=motility_ratex;
q=1-rho;

%Define the tolerance parameter for the Picard Iteration
toll=10^(-1);

%Define maximum number of iterations for Picard method
max_iter=200;

%Define the constant K which appears in the formula
Dm=delta_t/delta_x^2*(P_m/4);
Dx=delta_t/delta_x^2*(P_x/4);

%Initiate time and spacial extremal values
T_final_PDE=tau_sum/delta_t;
x_final=2*x_size/delta_x;

%Initiate numerical solution
u=u_IC;

%
X_end=x_size/delta_x;


%% Time loop
for k=1:T_final_PDE
    
    
    %% PICARD ITERATION
    % Define the matrix A and the vector b for the Picard Iteration
    % A(u_minus)*u_plus=u_minus
    
    A=zeros(x_final);
    %% Boundary Conditions
    
    % Define the first and the last rows of A to include the Neumann
    % conditions
    A(1,1)=1;
    A(1,2)=-1;
    A(X_end,X_end)=1;
    A(X_end,X_end-1)=-1;
    A(X_end+1,X_end+1)=1;
    A(X_end+1,X_end+2)=-1;
    A(end,end)=1;
    A(end,end-1)=-1;
    %These do not change
    
    u_plus=ones(x_final,1);
    iter=1;
    u_minus=u;
    v=u;
    
    while iter<max_iter && norm(u_plus-u_minus)>toll
        
        u_minus=v;
        % Define the tridiagonal coefficents of A
        for i=2:x_final-1
            %DEFINITION MATRIX
            
            %L =    D(1-M)+SM   (D-S)X
            %       (D-S)M       D(1-X)+SX
            
            if i<=X_end-1
                %                 L=[D*(1-u_minus(X_end+i))+S*u_minus(X_end+i) (D-S)*u_minus(i);
                %                     (D-S)*u_minus(X_end+i) D*(1-u_minus(i))+S*u_minus(i)];
                L=[Dx*(1-q*u_minus(X_end+i))+rho*Dm*u_minus(X_end+i), (q*Dx-rho*Dm)*(u_minus(i));...
                    (q*Dm-rho*Dx)*(u_minus(X_end+i)), Dm*(1-q*u_minus(i))+rho*Dx*u_minus(i)];
                A(i,i)=1+2*L(1,1);
                A(i,i+1)=-L(1,1);
                A(i,i-1)=-L(1,1);
                A(i,X_end+i)=2*L(1,2);
                A(i,X_end+i+1)=-L(1,2);
                A(i,X_end+i-1)=-L(1,2);
            elseif i>X_end+1
                %                 L=[D*(1-u_minus(i))+S*u_minus(i) (D-S)*u_minus(i-X_end);
                %                     (D-S)*u_minus(i) D*(1-u_minus(i-X_end))+S*u_minus(i-X_end)];
                L=[Dx*(1-q*u_minus(i))+rho*Dm*u_minus(i), (q*Dx-rho*Dm)*(u_minus(i-X_end));...
                    (q*Dm-rho*Dx)*u_minus(i), Dm*(1-q*u_minus(i-X_end))+rho*Dx*u_minus(i-X_end)];
                A(i,i-X_end)=2*L(2,1);
                A(i,i-X_end+1)=-L(2,1);
                A(i,i-X_end-1)=-L(2,1);
                A(i,i)=1+2*L(2,2);
                A(i,i+1)=-L(2,2);
                A(i,i-1)=-L(2,2);
            end %while
            
            
            
        end %for
        
        
        % Solve the linear system
        X=u(1:X_end);
        M=u(X_end+1:end);
        
        u_plus=A\[0;X(2:end-1);0;0;M(2:end-1);0];
        
        v=u_plus;
        
        % Update iteration
        iter=iter+1;
        
    end %while
    
    %Display an error message if the tolerance has not been reached
    if iter==max_iter
        error('Picard Iteration reaches maximum iteration number');
    end % if
    %% Update the Backward Euler time iteration
    u=u_plus;
    
  
  %  if k==0/delta_t || k==10/delta_t || k==50/delta_t || k==100/delta_t || k==1000/delta_t
  %      SAVE(u,rho,P_m,k*delta_t,x_size)
  %  end
end % for (TIME LOOP)
%PLOT(u,k*delta_t);
%% Mass balance
fprintf('Mass balance: %2.2f \n',1-sum(u)/sum(u_IC))

%end % function
