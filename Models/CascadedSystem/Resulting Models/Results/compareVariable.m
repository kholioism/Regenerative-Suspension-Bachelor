function compareVariable(simData,varName,labels)

color = {'r','b','k'};

if varName == "BodyAcceleration"
    unit = 'm/s^2';
elseif varName == "RoadHolding"
    unit = 'N';
else
    unit = 'W';
end
% Create figure
figure('Color','w','Position',[100 100 1000 500]);
hold on;

% Plot all simulations
for i = 1:length(simData)

    t = simData{i}.(varName).time;
    y = simData{i}.(varName).signals.values;

    plot(t,y,'LineWidth',1.5,'Color',color{i});

end

% Axes formatting
ax = gca;

ax.Color = 'w';
ax.XColor = 'k';
ax.YColor = 'k';

ax.FontSize = 12;
ax.LineWidth = 1;

ax.GridColor = [0 0 0];
ax.GridAlpha = 0.15;

ax.MinorGridColor = [0 0 0];
ax.MinorGridAlpha = 0.08;

grid on
grid minor
box on

% Optional: adjust x-axis ticks
xticks(0:0.1:1.5)

% Leave room for legend outside plot
ax.Position = [0.10 0.11 0.65 0.80];

% Labels
xlabel('Time [s]','Color','k','FontSize',14)
ylabel(strrep(varName+" ["+unit+']','_',' '),'Color','k','FontSize',14)

% Legend
lgd = legend(labels,...
    'Location','northeastoutside',...
    'FontSize',14,...
    'TextColor','k');

lgd.Box = 'off';
xlim([0 0.5]);

end