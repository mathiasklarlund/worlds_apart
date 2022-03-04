%% MET sorting & correlations

data = certainty_CD;
%conf_mean = conf_mean_amb;


% Firstly, define MET scores.

MET_melody = MET_data(2,:)'; % Provided the variable is named MET_data
MET_rhythm = MET_data(3,:)';
MET_all = ((MET_data(2,:)'+MET_data(3,:)'))./2;

% Secondly, sort

[MET_m_sort,I_m] = sort(MET_melody);
[MET_r_sort,I_r] = sort(MET_rhythm);
[MET_a_sort,I_a] = sort(MET_all);

% MELODY Divide into two groups each - high MET and low MET

MET_m_low   = MET_m_sort(1:50);
I_m_low     = I_m(1:50);
MET_m_high  = MET_m_sort(51:100);
I_m_high    = I_m(51:100);

% RHYHTHM Divide into two groups each - high MET and low MET

MET_r_low   = MET_r_sort(1:50);
I_r_low     = I_r(1:50);
MET_r_high  = MET_r_sort(51:100);
I_r_high    = I_r(51:100);

% ALL Divide into two groups each - high MET and low MET

MET_a_low   = MET_a_sort(1:50);
I_a_low     = I_a(1:50);
MET_a_high  = MET_a_sort(51:100);
I_a_high    = I_a(51:100);


%% Overall accuracy 
% MELODY 
low_m = data(I_m_low); 
high_m = data(I_m_high); 

% RHYTHM
low_r = data(I_r_low); 
high_r = data(I_r_high); 

% ALL
low_a = data(I_a_low); 
high_a = data(I_a_high); 

all = [low_a high_a];


