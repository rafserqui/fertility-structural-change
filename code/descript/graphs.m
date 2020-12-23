close all
clear 
clc

% Load fertility data
df = readtable('../../data/wb-data.csv');

countries = unique(df.country);
N = length(countries);
df.av_pop = ones(size(df.pop));

% Country pop average
for cc = 1:N
    country = countries(cc);
    idx = strcmp(df.country,country);

    % Compute average pop of each country and append to df
    df.av_pop(idx,:) = mean(df.pop(idx,:)) ;
end

df.lgdp = log(df.gdp);
df.pop_norm = 4.5.*(df.pop./df.av_pop);


figure
scatter(df.fert,df.lgdp,df.pop_norm,'filled')

