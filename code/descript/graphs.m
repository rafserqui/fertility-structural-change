close all
clear 
clc

% Load data
load('wdi_data.mat')

% Some description of the dataset
countries = unique(df.country);
N = length(countries);

% Add manufacturing share of employment
df.man_sh = 100 - df.agr_sh - df.ser_sh;

% Log of GDP per capita
df.lgdppc = log(df.gdppc);

% Plots
figs_folder = '../../tex/figures/descriptive/';

% Too many datapoints
% scatter_structural_change(df,'all')

% Restrict to year XXXX
ykeep = 2000;
dfy = df(df.date == ykeep,:);
title_add = 'All Income Groups (2000)';
scatter_structural_change(dfy,'all',title_add)
print(sprintf('%sfertility_structuralchange',figs_folder),'-dpng','-r1080');

% By income group
incgroups = unique(df.incomelevel,'stable');

for ilv = 1:length(incgroups)
    ilvl = incgroups{ilv};
    scatter_structural_change(df,ilvl)
end

% Kdensity plot of fertility by income group
npoints = 300;
fden = zeros(npoints,length(incgroups));
xipt = zeros(npoints,length(incgroups));

for ilv = 1:length(incgroups)
    ilvl = incgroups{ilv};

    % Subset
    dfsub = df(strcmp(df.incomelevel,ilvl),:);
    fert_tmp = [dfsub.fert];

    % Estimate Kdensity
    [ff,xi] = ksdensity(fert_tmp,'NumPoints',npoints);

    fden(:,ilv) = ff;
    xipt(:,ilv) = xi;
end

% Kdensity plot
colors = lines(3);
figure
p1 = plot(xipt(:,1),fden(:,1),'LineWidth',1.3,'Color',colors(1,:));
hold on
a1 = area(xipt(:,1),fden(:,1),'FaceAlpha',0.2,'FaceColor',colors(1,:));
p2 = plot(xipt(:,2),fden(:,2),'LineWidth',1.3,'Color',colors(2,:));
a2 = area(xipt(:,2),fden(:,2),'FaceAlpha',0.2,'FaceColor',colors(2,:));
p3 = plot(xipt(:,3),fden(:,3),'LineWidth',1.3,'Color',colors(3,:));
a3 = area(xipt(:,3),fden(:,3),'FaceAlpha',0.2,'FaceColor',colors(3,:));
xlabel('Fertility')
legend([p1 p2 p3],{'HIC','MIC','LIC'},'location','best')
print(sprintf('%skerneldensities',figs_folder),'-dpng','-r1080');

% By country
hics = {'Denmark','United States','Norway','Finland'};
lics = {'Brazil', 'Korea, Rep.', 'India'};
symb = {'-', '--', '-.','.'};
figure
hold on
for ccs = 1:length(hics)
    % Select country
    hic = hics{ccs};
    
    % Subset
    idhic = strcmp(df.country,hic);

    % Temporal df
    dft = df(logical(idhic),:);
    plot(dft.lgdppc,dft.fert,symb{ccs},'LineWidth',1.3)
end
legend(hics,'location','best')

figure
hold on
for ccs = 1:length(lics)
    % Select country
    lic = lics{ccs};
    
    % Subset
    idlic = strcmp(df.country,lic);

    % Temporal df
    dft = df(logical(idlic),:);
    plot(dft.lgdppc,dft.fert,symb{ccs},'LineWidth',1.3)
end
legend(lics,'location','best')


% Correlation between growth rates
%for cc = 1:length(countries)
%    dfsub = 
%end