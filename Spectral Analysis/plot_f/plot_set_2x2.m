hold on;

set(gcf,  'Position', [200, 200, 700, 650]);
set(gca,  'Position', [0.15 0.15 0.75 0.75]);

ax = gca;

ax.FontSize = 27;
ax.FontWeight = 'bold';
ax.TickLength = [0.02 0.02];

set(gca,'linewidth',2)
set(gca,'tickdir','out');

box off
legend boxoff