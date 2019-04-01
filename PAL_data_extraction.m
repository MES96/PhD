%% PAL_data_extraction

%Prep workspace
dbstop if error
clear all
close all
clear S

% Set filepaths
S.expt = 'PAL_Part2_Expt2_MES_schedule1'; %
%S.version = 2; % don't currently have a version number for PAL experiment (may be important later on)
%S.filepath = 'C:\Users\marie\Documents\extra_toolboxes\PAL Specifics\Analysis';
S.path.seq = ['C:\Users\mes96\Documents\GitHub\PhD\SCIn-MES\Outputs']; 
S.path.raw = ['C:\Users\mes96\Documents\GitHub\PhD\SCIn-MES\Outputs']; % unprocessed data in original format
S.path.prep = ['C:\Users\mes96\Documents\GitHub\PhD\SCIn-MES\Outputs']; % folder to save processed .set data
%S.path.hgf = ['C:\Users\marie\Documents\PhD\Data\PAL\hgf']; % folder to save processed data
S.fname.parts = {'prefix','subject','block','ext'}; % parts of the input filename separated by underscores, e.g.: {'study','subject','session','block','cond'};
S.fname.ext = {'mat'}; 
%S.study = {'PAL'};
S.subjdir = 0;
S.select.subjects = {'PAL001'}; % either a single subject, or leave blank to process all subjects in folder
S.select.sessions = {};
S.select.blocks = {['Sequence_' S.expt '_OptionCond_startblock1_*']}; % blocks to load (each a separate file) - empty means all of them, or not defined
S.select.conds = {}; % conditions to load (each a separate file) - empty means all of them, or not defined
S.select.condtype = '';
S.path.datfile = ['C:\Users\mes96\Documents\GitHub\PhD\SCIn-MES\Outputs\PAL_Participant_Data.xlsx']; % .xlsx file to group participants; contains columns named 'Subject', 'Group', and any covariates of interest
save(fullfile(S.path.prep,'S'),'S'); % saves 'S' - will be overwritten each time the script is run, so is just a temporary variable


% Add paths
% Not currently got any paths to add - come back to this

%% Data import

S.load.prefixes = {'Output','Sequence'};
%[S,D]=SCIn_seq_import(S);
[S,D]=SCIn_data_import(S);

%% Data processing

%[S,D]=PAL_data_processing(S)