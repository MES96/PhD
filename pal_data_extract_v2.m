%%PAL data extraction
%load output file
%load sequence file 

dbstop if error
clc 
clear all
%% Remove duplicate responses
%want to clean up the data by taking the last button press if multiple button
%presses occurred within a short space of time

rawpath = 'C:\Users\mes96\Documents\GitHub\PhD\SCIn-MES\Outputs';  
cd(rawpath);

load('Output_PAL001_Sequence_PAL_Part2_Expt2_MES_schedule1_OptionCond_startblock1_20190312T132043.mat');

% Make copy of presstrial
out.analysis.PT = out.presstrial;

% Identify what the difference is between the presstrial values (value of 0 indicates that that trial was the same trial number as the next)
idx = diff(out.analysis.PT);
A=1;
idx2 = [idx A];
out.analysis.PT(2,:) = idx2;

%Copy pressbutton trials and convert them to numbers (1 = rightarrow, 0 =  %leftarrow)
out.analysis.PB = out.pressbutton;
PB2 = out.analysis.PB(1,:)== "RightArrow";

%Concatenate responses into one array
out.analysis.PT(3,:) = PB2;
out.analysis.PT(4,:) = out.RT;

%Remove columns if the difference identified was 0 (in row 2)
remdat = any(out.analysis.PT(2,:)== 0, 1);
out.analysis.PT(:,remdat) = [];

% Save the output file
save('Output_PAL001_Sequence_PAL_Part2_Expt2_MES_schedule1_OptionCond_startblock1_20190312T132043.mat');

%% Identify accuracy

load('Sequence_PAL001_Sequence_PAL_Part2_Expt2_MES_schedule1_OptionCond_startblock1_20190312T132043.mat');

% Check whether condition was odd or even. All odd condition values were win and even condition values were lose (marks 1 for even events and 0 for odd events)
seq.analysis.corresp = mod(seq.condnum,2)==0;

% Checks if participant entered correct response. Win = left (both == 0); Lose = right (both == 1)
seq.analysis.accuracy = seq.analysis.corresp == out.analysis.PT(3,:);

save('Sequence_PAL001_Sequence_PAL_Part2_Expt2_MES_schedule1_OptionCond_startblock1_20190312T132043.mat');


%% Put into table to export

analysis.trial_number = transpose(out.analysis.PT(1,:));
analysis.block_number = transpose(seq.cp_cond);
analysis.condition_number = transpose(seq.condnum);
analysis.correct_response = transpose(seq.analysis.corresp); %outputs as true or false- anyway to stop that?
analysis.participant_response = transpose(out.analysis.PT(3,:));
analysis.participant_accuracy = transpose(seq.analysis.accuracy);
analysis.response_time = transpose(out.analysis.PT(4,:));

writetable(struct2table(analysis),fullfile('C:\Users\mes96\Documents\GitHub\PhD\SCIn-MES\Outputs','PAL_data_output.xlsx'));