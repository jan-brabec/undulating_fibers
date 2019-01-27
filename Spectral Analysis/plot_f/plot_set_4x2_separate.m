hold on;

ax = gca;
set(gcf, 'Position', [100, 100, 970, 900])
set(ax,'position',[0.25 0.25 0.7 0.7])

ax.FontSize = 60;
ax.FontWeight = 'bold';

set(gca,'tickdir','out');
set(gca,'linewidth',2)

ax.TickLength = [0.04 0.02];

box off
legend boxoff
