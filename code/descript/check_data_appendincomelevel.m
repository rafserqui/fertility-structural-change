close all
clear 
clc

% Load data
df = readtable('../../data/wb-data.csv');

% Data by country group
dhic = readtable('../../data/wb-data-hic.csv');
nhic = height(dhic);
dmic = readtable('../../data/wb-data-mic.csv');
nmic = height(dmic);
dlic = readtable('../../data/wb-data-lic.csv');
nlic = height(dlic);

% Add country group identifier
hil = cell(nhic,1);
hil(:) = {'HIC'};
dhic.incomelevel = hil;

mil = cell(nmic,1);
mil(:) = {'MIC'};
dmic.incomelevel = mil;

lil = cell(nlic,1);
lil(:) = {'LIC'};
dlic.incomelevel = lil;

% Dataframe by income level
dfl = [dhic;dmic;dlic];

clearvars -except dfl df nhic nmic nlic

% Check if same countries everywhere
tcc = [df.country];
tcc = unique(tcc);

lcc = [dfl.country];
lcc = unique(lcc);

% Check if list is the same
areequal = isequal(tcc,lcc);

if areequal == 1
    disp('Datasets contain the same countries in total. Saving.')
    % They are, so drop total df
    df = dfl;
    Nhic = nhic;
    Nmic = nmic;
    Nlic = nlic;

    clearvars -except df Nhic Nmic Nlic

    save('wdi_data')
else
    disp('Datasets contain different countries. Maybe check?')
end