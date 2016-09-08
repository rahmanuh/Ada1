------------------------------------------------------------------------------
-- File Name:       ada_pt_2.adb
-- University:      Uppsala University
-- Department:      Information Technology
-- Project:         Lab 1 Ada Assignment, Part 2         
-- Author:          Maximilian Stiefel
-- Date:            08.09.2016
-- Description:     This package provides its user with the 
--                  cyclic scheduler. 
------------------------------------------------------------------------------

with Cyclic_Scheduler_2;

procedure ada_pt_2 is
begin
	loop
		Cyclic_Scheduler_2.RUN;
	end loop;
end ada_pt_2;
