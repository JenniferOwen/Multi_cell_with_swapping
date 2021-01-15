The contents in the folder can be used to generate realisations of the 
stochastic simulations as well as solutions to the PDE (solved using the 
Implicit Method) for the equations describing cells moving and being able to
swap past each other on an on-lattice volume exclusion domain. A description
of each function is given below.

RUNNING THE CODE

main.m
Use this to run the code. Will use arguments from parameters.m to run stochastic
simulations, solve PDE and plot the results of both on top of each other for comparison.

parameters.m
Outputs the parameters: rate of movement of cell M, rate of movement of cell X,
rate of swapping between cells, end time

initial_conditions (2)
Determines the initial positions of cells X and M. There are two options for
initial conditions. To change the one that is used, change the initial conditions 
function names in Imp_method_JO AND stochastic_model

Imp_method_JO
Solves the PDE for the system using the implicit method based on parameter inputs

stochastic_model
Simulates the system and averages column densities based on parameter inputs

PLOTTING THE OUTPUT (to be ran following main.m)

PLOT.m
plots the solution to the PDE

Plot_u_and_domain_matrix
plots the solution to the PDE as well as the stochastic simulation

visualise.m (2)
Two options for visualising the end of the stochastic simulation (before averaging
column densities).

BONUS FILES!

track.m
Tracks the total distance travelled by cells for different densities of the 
domain and different rates of swapping and saves to matrix called relationship.mat

generate_hm.m
generates a heatmap of the total distance travelled by cells for different densities of the 
domain and different rates of swapping based on matrix called relationship.mat



