% mex command is given by: 
% mex CXXFLAGS="\$CXXFLAGS -std=c++11 -O3" Cortex_SR_mex.cpp Cortical_Column.cpp
% Sleep_Regulation.cpp

function Plots(type)
H = 4; % ~ 2 min per H on Core i7
T = H*3600;

Param_SR = [1.2375;     % f_W 
            4.858;      % f_N
            0.001;      % f_R
            0.8781];    % h

mex CXXFLAGS="\$CXXFLAGS -std=c++11 -O3" Cortex_SR_mex.cpp Cortical_Column.cpp Sleep_Regulation.cpp

tic 
[Ve, Na, f_W, f_N, f_R, C_E, C_G, C_A, h, g_KNa, sigma_e]  = Cortex_SR_mex(T, Param_SR); 
toc

% time axis
time = linspace(0,H,length(Ve));

% Get the hypnogram
Hypnogram= ones(length(f_W),1);
Hypnogram(C_E<0.4) = 0.5;
Hypnogram(C_A>0.4) = 0; 

figure(4)
subplot(311)
plot(time, g_KNa)
set(gca, 'xtick', 0:H/5:H);
xlabel('Time [h]');
ylabel('g_{KNa}');
subplot(312)
plot(time, sigma_e)
set(gca, 'xtick', 0:H/5:H);
xlabel('Time [h]');
ylabel('sigma_{e}');
subplot(313)
plot(time, Ve)
set(gca, 'xtick', 0:H/5:H);
xlabel('Time [h]');
ylabel('V_{e}');

figure(3)
subplot(211)
plot(time, f_W, 'g', time, f_N, 'r', time, f_R, 'b', time, h, 'y')
set(gca, 'xtick', 0:H/5:H);
xlabel('Time [h]');
ylabel('Activity [Hz]');
legend('F_W', 'F_N', 'F_R', 'h') 
subplot(212)
plot(time, Hypnogram, 'black');
ylim([-0.5, 1.5])
set(gca, 'box', 'off', 'xtick', 0:H/5:H, 'ytick', [0, 0.5, 1], 'yticklabel', {'REM', 'NREM', 'Wake'})

figure(2)
plot3(time, g_KNa, sigma_e);
set(gca, 'xtick', 0:H/5:H);
xlabel('Time [h]')
ylabel('g_{KNa}')
zlabel('\sigma_e')

% load the data from xppaut
fname_Hopf = '/nfshome/schellen/Documents/MATLAB/Papers/C_model/Data/Hopf-diagram.dat';
fname_Fold = '/nfshome/schellen/Documents/MATLAB/Papers/C_model/Data/Saddle-diagram.dat';

% Path to matlab2tikz
if(isempty(strfind(path, '/nfshome/schellen/Documents/MATLAB/Tools/PlotXPP')))
    addpath(genpath('/nfshome/schellen/Documents/MATLAB/Tools/PlotXPP'));
end

% create the figure
figure(1)
clf, shg

% plot the data
plotxppaut(fname_Hopf,'Red','-')
plotxppaut(fname_Fold,'Black','-')
xlim([0,8.2])
ylim([0.1,10.5])

% add the vertical lines
plot([0,8],[6.195,6.195],'--','Color',[0.7,0.7,0.7],'LineWidth',0.5)
plot([0,8],[3.617,3.617],'--','Color',[0.7,0.7,0.7],'LineWidth',0.5)

% label the axes
ylabel('\sigma_{e} [mV]')
xlabel('g_{KNa} [mS/cm^2]')

% set the ticks for the axes
set(gca,'YTick',[2 4 6 8 10])
set(gca,'XTick',[0 2 4 6 8])

plot(g_KNa, sigma_e);
xlabel('g_{KNa}')
ylabel('\sigma_e')
end
