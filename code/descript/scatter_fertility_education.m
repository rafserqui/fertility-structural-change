function scatter_fertility_education(df,incomelevel,title_add)
    
    if strcmp(incomelevel,'all')
        income_group = 'All Income Groups';
    elseif strcmp(incomelevel,'HIC')
        df = df(strcmp(df.incomelevel,'HIC'),:);
        income_group = 'High Income Countries';
    elseif strcmp(incomelevel, 'MIC')
        df = df(strcmp(df.incomelevel,'MIC'),:);
        income_group = 'Middle Income Countries';
    elseif strcmp(incomelevel, 'LIC')
        df = df(strcmp(df.incomelevel,'LIC'),:);
        income_group = 'Low Income Countries';
    else 
        error('Set a valid income level. Either all, HIC, MIC, or LIC.')
    end

    if ~exist('title_add')
        title_add = income_group;
    end

    % Plot remaining dataframe
    norm_size = [0.1265625,0.071296296296296,0.672916666666667,0.612962962962963];
    figure('units','normalized','outerposition',norm_size)
    subplot(2,3,1)
    scatter(df.lgdppc,df.lfp_female,'filled','MarkerFaceAlpha',0.6)
    title('Labor Force Participation, Female (%)')
    xlabel('Log of GDP per capita')
    
    subplot(2,3,2)
    scatter(df.lgdppc,df.educatt_primary_fem,'filled','MarkerFaceAlpha',0.6)
    title('Educational Attainment, at least primary (Female)')
    xlabel('Log of GDP per capita')
    
    subplot(2,3,3)
    scatter(df.lgdppc,df.educatt_lsecond_female,'filled','MarkerFaceAlpha',0.6)
    xlabel('Log GDP per capita')
    title('Educational Attainment, at least lower secondary (Female)')
    
    subplot(2,3,4)
    scatter(df.fert,df.lfp_female,'filled','MarkerFaceAlpha',0.6)
    xlabel('Fertility Rate')
    title('Labor Force Participation, Female (%)')
    
    subplot(2,3,5)
    scatter(df.fert,df.educatt_primary_fem,'filled','MarkerFaceAlpha',0.6)
    xlabel('Fertility Rate')
    title('Educational Attainment, at least primary (Female)')
    
    subplot(2,3,6)
    scatter(df.fert,df.educatt_lsecond_female,'filled','MarkerFaceAlpha',0.6)
    xlabel('Fertility Rate')
    title('Educational Attainment, at least lower secondary (Female)')

    sgtitle(title_add)
end