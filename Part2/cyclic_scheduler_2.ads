------------------------------------------------------------------------------
-- File Name:       cyclic_scheduler_2.ads
-- University:      Uppsala University
-- Department:      Information Technology
-- Project:         Lab 1 Ada Assignment, Part 2         
-- Author:          Maximilian Stiefel
-- Date:            08.09.2016
-- Description:     This package provides its user with the 
--                  cyclic scheduler. 
------------------------------------------------------------------------------

------------------------------------------------------------------------------
-- Libraries
------------------------------------------------------------------------------
--For the basic things.
with Ada.Text_IO;
use Ada.text_IO;

--For timing constraints.
with Ada.Calendar;
use Ada.Calendar;

with P_Rand_ExecT_Gen;

------------------------------------------------------------------------------
-- Package Declarations (Inteface)
------------------------------------------------------------------------------
package Cyclic_Scheduler_2 is
    procedure RUN;
end Cyclic_Scheduler_2;