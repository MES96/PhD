%function [S,D] = PAL_data_processing(S,D)
% Removes duplicate responses from the data 


    %for d = 1:length(D)
    
        %for op = 1:length(D(d).Output)
            
            % Identify the second response for each trial and remove 
            
            % Make copy of presstrial
            D.Processing.PT = D.Output.presstrial;
            
            % Identify what the difference is between the presstrial values (value of 0 indicates that that trial was the same trial number as the next)
            D.RndmVar.idx = diff(D.Processing.PT);
            D.RndmVar.A=1;
            D.RndmVar.idx2 = [D.RndmVar.idx D.RndmVar.A];
            D.Processing.PT(2,:) = D.RndmVar.idx2;
            
            % Copy pressbutton trials and convert them to numbers (1 = rightarrow, 0 =  %leftarrow)
            D.Processing.PB = D.Output.pressbutton;
            D.Processing.PT(3,:) = D.Processing.PB(1,:)== "RightArrow";
            
            % Add response times to array
            D.Processing.PT(4,:) = D.Output.RT;
            
            %Remove columns if the difference identified was 0 (in row 2)
            D.Variables.remdat = any(D.Processing.PT(2,:)== 0, 1);
            D.Processing.PT(:,D.Variables.remdat) = [];
            
            % get index of first responses, not including second ones
            [~,firstresp] = unique(D.Output.presstrial);
            
            %Put data into separate arrays
            Analysis.trial_number = D.Processing.PT(1,:);
            Analysis.participant_response = D.Processing.PT(3,:);
            Analysis.response_time = D.Processing.PT(4,:);
            
            % Check whether condition was odd or even. All odd condition values were win and even condition values were lose (marks 1 for even events and 0 for odd events)
            Analysis.correct_response = mod(D.Sequence.condnum,2)==0;
            
            % Checks if participant entered correct response. Win = left (both == 0); Lose = right (both == 1)
            Analysis.accuracy = D.Analysis.correct_response == D.Processing.PT(3,:);
            
            %Put data into a table and transpose it
            Analysis.trial_number = transpose(D.Processing.PT(1,:)); 
            Analysis.block_number = transpose(D.Sequence.cp_cond);
            Analysis.condition_number = transpose(D.Sequence.condnum);
            Analysis.correct_response = transpose(Analysis.correct_response);
            Analysis.participant_response = transpose(D.Processing.PT(3,:));
            Analysis.accuracy = transpose(Analysis.accuracy);
            Analysis.response_time = transpose(D.Processing.PT(4,:));
            
            writetable(struct2table(Analysis),fullfile('C:\Users\mes96\Documents\GitHub\PhD\SCIn-MES\Outputs','PAL_data.xlsx'));
            