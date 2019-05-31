function Plot_Timeseries_Epochs_vertical()
% Path to helper functions
if(isempty(strfind(path, [pwd,'/Tools'])))
    addpath([pwd,'/Tools']);
end

% Individual sleep epochs
load('Data/Sleep_Epochs')

% Create figure
figure(1)
set(gcf,'units','normalized','outerposition',[0 0 1 1]);
clf

% Create panel
p = panel('no-manage-font');
p.pack(5, 'v');

% Set margins
p.de.margintop = 5;
p.de.marginbottom = 15;

% Plots data
p(1).select();
plot(Epoch_WAKE.time, Epoch_WAKE.Vp, '-black')
set(gca, 'XLim', [0, 30],...
         'XTick', 0:5:30,... 
         'XTickLabel',[],...
         'YLim', [-50, -40],...
         'YTick', -50:5:-40,...
         'YTickLabel', -50:5:-40);
title('Wake');
ylabel('V_{p} [mV]');

p(2).select();
plot(Epoch_N1.time, Epoch_N1.Vp, '-black')
set(gca, 'XLim', [0, 30],...
         'XTick', 0:5:30,... 
         'XTickLabel',[],...
         'YLim', [-60, -50],...
         'YTick', -60:5:-50,...
         'YTickLabel', -60:5:-50);
title('N1');
ylabel('V_{p} [mV]');

p(3).select();
plot(Epoch_N2.time, Epoch_N2.Vp, '-black')
set(gca, 'XLim', [0, 30],...
         'XTick', 0:5:30,... 
         'XTickLabel',[],...
         'YLim', [-80, -40],...
         'YTick', -80:20:-40,...
         'YTickLabel',-80:20:-40);
title('N2');
ylabel('V_{p} [mV]');

p(4).select();
plot(Epoch_N3.time, Epoch_N3.Vp, '-black')
set(gca, 'XLim', [0, 30],...
         'XTick', 0:5:30,... 
         'XTickLabel',[],...
         'YLim', [-80, -40],...
         'YTick', -80:20:-40,...
         'YTickLabel',-80:20:-40);
title('N3');
ylabel('V_{p} [mV]');

p(5).select();
plot(Epoch_REM.time, Epoch_REM.Vp, '-black')
set(gca, 'XLim', [0, 30],...
         'XTick', 0:5:30,... 
         'XTickLabel',0:5:30,...
         'YLim', [-50, -40],...
         'YTick', -50:5:-40,...
         'YTickLabel', -50:5:-40);
title('REM');
xlabel('Time [s]');
ylabel('V_{p} [mV]');
end