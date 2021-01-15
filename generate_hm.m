%Run track first.

%Generate a heatmap of the average distance travelled given density of domain and rho 

load('relationship.mat')

h=heatmap(abs(round(relationship,1)), 'Colormap', parula(20));

ax = gca;
h.xlabel(['\rho']);
h.ylabel(['Density']);

ax.XData = [{'0','0.25','0.5','0.75','1'}]
ax.YData = [{'0.2','0.4','0.6','0.8','1'}]
set(gca,'fontsize', 18);