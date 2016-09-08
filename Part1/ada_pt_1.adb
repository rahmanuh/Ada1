------------------------------------------------------------------------------
-- File Name:       ada_pt_1.adb
-- University:      Uppsala University
-- Department:      Information Technology
-- Project:         Lab 1 Ada Assignment, Part 1        
-- Author:          Maximilian Stiefel
-- Date:            08.09.2016
-- Description:     This (main) file runs the cyclic scheduler. 
------------------------------------------------------------------------------

with Cyclic_Scheduler_1;

procedure ada_pt_1 is
begin
	loop
		Cyclic_Scheduler_1.RUN;
	end loop;
end ada_pt_1;
