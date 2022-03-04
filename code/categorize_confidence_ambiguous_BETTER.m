%% Ambiguous melodies - correct answers, Mistakes and confidence values.
% 
% clc;
% clear all;

% name of file
filename = 'AmbiguousData101.xlsx';

% Number of sheets
N = 101;

% create cell-array for each sheet
myData = cell(N,1);

% Load excel file into myData
for i = 1:N
    [~,~,raw] = xlsread(filename,i);
    myData{i} = raw;
end

% Prep
steps = [4:4:80];
correct_deutch = 0;
mistakes_deutch = 0;

correct_chinese = 0;
mistakes_chinese = 0;
data_ambi = [1:N]';
data_ambi = [data_ambi zeros(N,6)];
conf_data_ambi = [1:N]';
conf_data_ambi = [conf_data_ambi zeros(N,6)];

% For german melodies
for ii = 1:N
    for i = steps(1:end)
        if strncmp(myData{ii}(i,2),'Deutch',6)
            correct_deutch = correct_deutch+1;
            
            % Get confidence values for correct answers
            conf_data_ambi(ii,2) = cell2mat( myData{ii}(i+1,2)) + conf_data_ambi(ii,2);
            
        else
            mistakes_deutch = mistakes_deutch+1;
            
            % Get confidence values for mistakes
            conf_data_ambi(ii,3) = cell2mat( myData{ii}(i+1,2)) + conf_data_ambi(ii,3);
        end
    end
    data_ambi(ii,2) = correct_deutch;
    data_ambi(ii,3) = mistakes_deutch;
    
    correct_deutch  = 0;
    mistakes_deutch = 0;
end

%for Chinese melodies
for ii = 1:N
    for i = steps(1:end)+80
        if strncmp(myData{ii}(i,2),'Chinese',7)
            correct_chinese = correct_chinese+1;
            
            % Get confidence values for correct answers
            conf_data_ambi(ii,4) = cell2mat( myData{ii}(i+1,2)) + conf_data_ambi(ii,4);
            
        else
            mistakes_chinese = mistakes_chinese+1;
            
            % Get confidence values for mistakes
            conf_data_ambi(ii,5) = cell2mat( myData{ii}(i+1,2)) + conf_data_ambi(ii,5);
        end
    end
    data_ambi(ii,4) = correct_chinese;
    data_ambi(ii,5) = mistakes_chinese;
 
    
    correct_chinese  = 0;
    mistakes_chinese = 0;
end

% Adding together for correct and mistakes classifications
data_ambi(:,6) = data_ambi(:,2)+data_ambi(:,4);
data_ambi(:,7) = data_ambi(:,3)+data_ambi(:,5);


% Adding confidence values together for correct and mistakes
conf_data_ambi(:,6) = conf_data_ambi(:,2)+conf_data_ambi(:,4);
conf_data_ambi(:,7) = conf_data_ambi(:,3)+conf_data_ambi(:,5);


% conf_data MEAN
conf_mean_ambi = [data_ambi(:,1) zeros(N,6)];

for ii = 1:N
    
    % Mean correct confidence for German
    conf_mean_ambi(ii,2) = conf_data_ambi(ii,2)/data_ambi(ii,2);
    
    % Mean mistake confidence for German (German perceived to be Chinese)
    conf_mean_ambi(ii,3) = conf_data_ambi(ii,3)/data_ambi(ii,3);
    
    % Mean correct confidence for Chinese
    conf_mean_ambi(ii,4) = conf_data_ambi(ii,4)/data_ambi(ii,4);
    
    % Mean mistake confidence for Chinese (Chinese perceived to be German)
    conf_mean_ambi(ii,5) = conf_data_ambi(ii,5)/data_ambi(ii,5);
    
    % Makes all NaN's to zero. Wonder If I should use it!?!?!?!?!?
    conf_mean_ambi(isnan(conf_mean_ambi))=0;
    
    % Creates the means for overall confidence in correct and mistakes
    conf_mean_ambi(ii,6) = (conf_mean_ambi(ii,2)+conf_mean_ambi(ii,4))/2;
    conf_mean_ambi(ii,7) = (conf_mean_ambi(ii,3)+conf_mean_ambi(ii,5))/2;
end



% DATA
% column 1 = participant number
% column 2 = German correct
% column 3 = German mistakes
% column 4 = Chinese correct
% column 5 = Chinese mistakes
% column 6 = Total overall correct
% column 7 = Total overall mistakes

% CONF_Data
% column 1 = participant number
% column 2 = German confidence for correct
% column 3 = German confidence for mistakes
% column 4 = Chinese confidence for correct
% column 5 = Chinese confidence for mistakes
% column 6 = Total overall correct
% column 7 = Total overall mistakes

% CONF_Mean
% column 1 = participant number
% column 2 = MEAN German confidence for correct
% column 3 = MEAN German confidence for mistakes
% column 4 = MEAN Chinese confidence for correct
% column 5 = MEAN Chinese confidence for mistakes
% column 6 = MEAN Total overall correct
% column 7 = MEAN Total overall mistakes

ambi_data = data_ambi;
ambi_conf_mean = conf_mean_ambi;


%% get certainties
%Western ambiguous
certainty_WA = (ambi_data(:,2) .* ambi_conf_mean(:,2)) - (ambi_data(:,3) .* ambi_conf_mean(:,3)); 
%Chinese ambiguous
certainty_CA = (ambi_data(:,4) .* ambi_conf_mean(:,4)) - (ambi_data(:,5) .* ambi_conf_mean(:,5)); 

% %% get certainties - with old ambiguous
% 
% %Western ambiguous
% certainty_WA = (ambi_data(:,2) .* conf_mean_amb(:,2)) - (ambi_data(:,3) .* conf_mean_amb(:,3)); 
% %Chinese ambiguous
% certainty_CA = (ambi_data(:,4) .* conf_mean_amb(:,4)) - (ambi_data(:,5) .* conf_mean_amb(:,5));




