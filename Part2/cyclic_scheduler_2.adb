------------------------------------------------------------------------------
-- File Name:       cyclic_scheduler_2.adb
-- University:      Uppsala University
-- Department:      Information Technology
-- Project:         Lab 1 Ada Assignment, Part 2         
-- Author:          Maximilian Stiefel
-- Date:            08.09.2016
-- Description:     This package provides its user with the 
--                  cyclic scheduler. 
------------------------------------------------------------------------------

------------------------------------------------------------------------------
-- Package Body
------------------------------------------------------------------------------
package body Cyclic_Scheduler_2 is
       
    ----------------------------------------------------------------------
    -- Task:        German_Shepherd
    -- Description: This task is a watchdog for F3.
    ----------------------------------------------------------------------
    task German_Shepherd is
        entry Start;
        entry Stop;
        entry Init(Period : in Duration);
    end German_Shepherd;
    ----------------------------------------------------------------------
    -- Task body
    ----------------------------------------------------------------------
    task body German_Shepherd is
        Exceedance_Start_Pt : Time;
        Exceedance : Duration;
        Period_l : Duration; 
    begin
        accept Init(Period : in Duration) do
            --Transfer data to the task.
            Period_l := Period;
        end Init;
        loop
            select 
                --F3 started executing.
                accept Start;
                    select
                        --F3 finished in time.
                        accept Stop;
                    or
                        --Timeout.
                        delay 0.5;
                        Put_Line("Warning: F3 eceeds its execution time boundaries.");
                        --Take current time.
                        Exceedance_Start_Pt := Clock; 
                    end select;
            or 
            --Stop is coming too late. Synchronize again.        
            accept Stop do 
                Exceedance := Clock-Exceedance_Start_Pt;
                delay until Exceedance_Start_Pt + Period_l;
                end Stop;    
            end select;
        end loop;
    end German_Shepherd;

    ----------------------------------------------------------------------
    -- Procedure:   print_sep
    -- Description: Prints seperator lines consisting of hashtags.
    ----------------------------------------------------------------------
    procedure print_sep(num: in Integer) is
        i : Integer := 1;
    begin
        loop
            Put("#");
            i := i+1;
            exit when (i >= num);
        end loop;
	new_line(1);
    end print_sep;

    ----------------------------------------------------------------------
    -- Procedure:   F1
    -- Description: This Procedure is simply an example procedure 
    --              executing at the beginning of each cycle. 
    ----------------------------------------------------------------------
    procedure F1(Print_this : in Time) is
    begin
        --Just print Somethin.
        Put("F1 starts execution. System time is: ");
        Put(Duration'Image(Clock-Print_this));
        Put_line(" s.");
        --Executions, Executions ...
    end F1;
    
    ----------------------------------------------------------------------
    -- Procedure:   F2
    -- Description: This Procedure is another example procedure 
    --              executing straight after F1.
    ----------------------------------------------------------------------
    procedure F2(Print_this : in Time) is
    begin
        --Just print Somethin.
        Put("F2 starts execution. System time is: ");
        Put(Duration'Image(Clock-Print_this));
        Put_line(" s.");
        --Executions, Executions ...
    end F2;

    ----------------------------------------------------------------------
    -- Procedure:   F3
    -- Description: This Procedure is another example procedure 
    --              executing 0.5 s after F1. This procedure varies
    --              between 0.0 s and 1.0 s in its execution time. 
    ----------------------------------------------------------------------
    procedure F3(Print_this : in Time) is
        Start_Exec_F3 : Time := Clock;
    begin
        --Put message for the user to see when F3 is exec.
        Put("F3 starts execution. System time is: ");
        Put(Duration'Image(Clock-Print_this));
        Put_line(" s.");
        --Delay F3 randomly. Executions, Executions ...
        delay until Start_Exec_F3 + P_Rand_ExecT_Gen.Get(1000);
        --Put message to tell user how long the execution took.
        Put("Execution of F3 took ");
        Put(Duration'Image(Clock - Start_Exec_F3));
        Put_line(" s.");
    end F3;

    ----------------------------------------------------------------------
    -- Procedure:   RUN
    -- Description: This Procedure is the core of the cyclic scheduler.
    --              It schedules the different procedures in the demanded
    --              way:
    --              0 s     0.5 s     1 s   1.5s     2 s     2.5 s ...
    --              F1 F2             F1 F2 F3       F1 F2         ...
    ----------------------------------------------------------------------
    procedure RUN is
        --System Time.
        System_T : Time := Clock;
        --Period of the system tick.
        Period : Duration := 1.0;
        --Delay of F3.
        Delay_F3 : Duration := 0.5;
        --Time for the next Cycle
        Next_T : Time := System_T;
        --Boolean to detect every other cycle.
        Every_Other : Boolean := False;
        --Start of F1.
        Start_F1 : Time;
    begin
        --Initialize rand exec. time generator.
        P_Rand_ExecT_Gen.Init;
        --Initialize Watchdog.
        German_Shepherd.Init(Period);
        loop
            --Print seperators -> Makes it look more beautiful.
            print_sep(80);
            --Monitor when F1 has started.
            Start_F1 := Clock;
            F1(System_T);
            F2(System_T);
            if (Every_Other) then
                delay until Start_F1 + Delay_F3;
                Put_line("Waiting for F3...");
                --Call watchdog.
                German_Shepherd.Start;
                F3(System_T);
                --Release watchdog.
                German_Shepherd.Stop;
            end if;
            print_sep(80);
            new_line(1);
            Every_Other := not Every_Other;	
            Next_T := Next_T + Period;
            delay until Next_T;
        end loop;
    end RUN;
end Cyclic_Scheduler_2;