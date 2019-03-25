%%PAL data extraction
%load output file
%load sequence file 

%want to clean up the data by taking the last button press if multiple button
%presses occurred within a short space of time
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
   
   %Mark the PT3 <1 values with a 1
   %Mark the column before values marked with a 1 with a 2
   %Concatenate PT3 with the RT and arrow press data
  
   
   
   if any(out.analysis.PT4 < 1,1)
       out.analysis.PT4(2,:)=1
   else
       out.analysis.PT4(2,:)=0
   end    
       