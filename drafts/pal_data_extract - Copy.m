%%PAL data extraction
%load output file
%load sequence file 

%want to clean up the data by taking the last button press if multiple button
%presses occurred within a short space of time
       

DON'T NEED TO DO THIS BECAUSE PRESSTIRAL ALREADY INDICATES WHICH TRIAL THEY ANSWERED ON
%compare presstime (PT) variables within output and check if difference
        %between entries is within a certain timeframe
      
   %duplicate OG PT
            %out.analysis.PT1 = out.presstime
   %add an empty column to end of PT1 and to the start of PT2
            %A=0
            %out.analysis.PT2 = [A out.analysis.PT2]
            %out.analysis.PT1 = [out.analysis.PT1 A]
   %subtract PT2 array from PT1 array
            %out.analysis.PT3 = out.analysis.PT1 - out.analysis.PT2
  %DON'T NEED TO DO THIS: NEED TO EXTRACT THE COLUMN NUMBER THIS OCCURS FOR AND DELETE RESPONSES JUST BEFORE THE ONE IN THIS COLUMN
   %delete any values that are lower than 1        
            %columntodelete = any(out.analysis.PT4 < 1, 1)
            %out.analysis.PT4(:,columntodelete) = []
   %remove column 1 (originally had 0 in)
            %out.analysis.PT4(:,1) = []
   
   %Duplicate PT3 --> PT4
   %Mark the PT4 <1 values with a 1
            %markcolumn1 = out.analysis.PT4(1,:)<1
            %out.analysis.PT4(2,:) = markcolumn1
   %Mark the column before values marked with a 1 with a 2
            %idx = find(out.analysis.PT4(2,:)==1)
            %idx2 = idx-1
            %out.analysis.PT5(2,idx)= 0
            %out.analysis.PT5(2,idx2)= 1         
   %Concatenate PT3 with the RT and arrow press data
            %out.analysis.PT4(3,:) = out.pressbutton
            %out.analysis.PT4(4,:) = out.RT
            %out.analysis.PT4(5,:) = out.pressbutton
   
  SECOND PLAN: CHECK PRESSTIRAL
  % Make copy of presstrial
        %out.analysis.PT = out.presstrial
  % Identify what the difference is between the presstrial values (value of 0 indicates that that trial was the same trial number as the next)
        % idx = diff(out.analysis.PT)
        % A=1
        % idx2 = [idx A]
        % out.analysis.PT(2,:) = idx2
  %Copy pressbutton trials and convert them to numbers (1 = rightarrow, 0 =  %leftarrow)
        %out.analysis.PB = out.pressbutton
        %PB2 = out.analysis.PB(1,:)== "RightArrow"
 %Concatenate responses into one array
        %out.analysis.PT(3,:) = PB2
        %out.analysis.PT(4,:) = out.RT
        %out.analysis.PT(5,:) = out.presstime
 %Remove columns if the difference identified was 0 (in row 2)
        %remdat = any(out.analysis.PT(2,:)== 0, 1)
        %out.analysis.PT(:,remdat) = []
 