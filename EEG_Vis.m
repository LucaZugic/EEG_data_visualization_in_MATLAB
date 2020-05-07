% EEG system is defined by user
system = input('Enter EEG system name [EEGO/NEXUS]: ');

% Coordinates are determined via location of channel estimation using
% geogebra and the the maps supplied on the respecitve company website of
% the EEG manufacturer
switch system
    case 'EEGO'
        Xcord = [-23.91, 0.14, 24.27, -64.24, -33.07, 0.35, 33.74, 64.84, -57.23, -18.93, 19.89, 58.38, -80.03, -39.61, 0.63, 41.03, 81.27, -56.89, -18.59, 20.11, 58.66, -63.55, -32.56, 0.93, 34.34, 65.44, 1.02, -22.97, 1.14, 25.14];
        Ycord = [81.02, 83.80, 81.52, 52.54, 45.51, 44.01, 46.12, 53.93, 26.50, 24.37, 24.70, 27.51, 3.67, 3.99, 4.42, 4.77, 5.11, -18.93, -15.93, -15.60, -17.92, -45.12, -37.53, -35.43, -36.91, -44.14, -55.38, -72.86, -75.35, -72.45];
        labels = {'Fp1' 'Fpz' 'Fp2' 'F7' 'F3' 'Fz' 'F4' 'F8' 'FC5' 'FC1' 'FC2' 'FC6' 'T7' 'C3' 'Cz' 'C4' 'T8' 'CP5' 'CP1' 'CP2' 'CP6' 'P7' 'P3' 'Pz' 'P4' 'P8' 'Pz' 'O1' 'Oz' 'O2'};
    case 'NEXUS'
        Xcord = [-20.08, 20, -84.98, -42.49, 0.04, 42.30, 84.86, -85, -42.45, 0.07, 42.34, 84.85, -85, -42.45, 0.05, 42.32, 84.82, -20.15, 19.96];
        Ycord = [79.47, 79.5, 39.39, 39.56, 39.65, 39.76, 39.78, 0, 0.02, 0.04, 0.17, 0.26, -39.53, -39.38, -39.34, -39.23, -39.15, -79.24, -79.22];
        labels = {'FP1' 'FP2' 'F7' 'F3' 'Fz' 'F4' 'F8' 'T3' 'C3' 'Cz' 'C4' 'T4' 'T5' 'P3' 'Pz' 'P4' 'T6' 'O1' 'O2'};
end

% requesting map title from user
set_title = input('Enter map title: ', 's');

% creating the countour plot
[x, y] = meshgrid((0:1:360) * pi / 180, 0:1:100);
[X, Y] = pol2cart(x, y);
F = scatteredInterpolant(Xcord', Ycord', EEG', 'natural', 'linear');
Z = F(X, Y);
figure
contourf(X, Y, Z, 1000, 'LineColor', 'none');
title({'EEG Map' set_title}, 'interpreter', 'none')
daspect([1 1 1])
colormap(jet);
set(gca,'XTick', [],  'YTick', [])
hold on
plot(Xcord, Ycord, 'ko')
text(Xcord, Ycord, labels, 'VerticalAlignment', 'top', 'HorizontalAlignment', 'center')
disp ('Map was generated.')
disp ('When using MATLAB Online you might have to minimize the Comman Window to see the map.')

% use the parameters of the caxis function to set your low and high
% colorbar values, as in caxis([min, max])
caxis([0, 1])
colorbar