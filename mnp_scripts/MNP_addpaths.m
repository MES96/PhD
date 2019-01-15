function MNP_addpaths
%% ADD FUNCTIONS/TOOLBOXES TO MATLAB PATH
paths = {
    'C:\Users\mes96\Documents\GitHub\PhD\mnp_scripts',...
    'C:\Users\mes96\Documents\_generic_eeglab_batch\eeglab_batch_supporting_functions'...
    'Q:\Toolboxes\HGF\HGFv5.0'...
    'C:\Users\mes96\Documents\_generic_HGF'...
    'C:\Users\mes96\Documents\_generic_SCIn_data_process'...
    };
subpaths = [1 1 1 1 1]; % add subdirectories too?

for p = 1:length(paths)
    if subpaths(p)
        addpath(genpath(paths{p}));
    else
        addpath(paths{p});
    end
end