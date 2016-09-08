------------------------------------------------------------------------------
-- Package Name:    P_Rand_ExecT_Gen
-- Author:          Maximilian Stiefel
-- Date:            08.09.2016
------------------------------------------------------------------------------

------------------------------------------------------------------------------
-- Libraries
------------------------------------------------------------------------------
with Ada.Numerics.Discrete_Random;

------------------------------------------------------------------------------
-- Package Declarations (Interface)
------------------------------------------------------------------------------
package P_Rand_ExecT_Gen is
    function Get(Range_MilliS : Positive) return Duration;
    procedure Init;
end P_Rand_ExecT_Gen;