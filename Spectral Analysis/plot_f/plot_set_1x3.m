hold on;

set(gcf,  'Position', [200, 200, 700, 650]);
set(gca,  'Position', [0.2422    0.2467    0.6628    0.6783]);

ax = gca;

ax.FontSize = 44;
ax.TickLength = [0.02 0.02];

set(ax,'tickdir','out');
set(ax,'linewidth',2);

box off
legend boxoff

