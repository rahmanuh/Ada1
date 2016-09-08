------------------------------------------------------------------------------
-- Package Name:    P_Rand_ExecT_Gen
-- Author:          Maximilian Stiefel
-- Date:            08.09.2016
------------------------------------------------------------------------------

------------------------------------------------------------------------------
-- Package Body
------------------------------------------------------------------------------
package body P_Rand_ExecT_Gen is
    
    --Declare a new subtype with a positive range.
    subtype Random_Range is Positive;
    --Generate new package out of the given generic package.
    package Random_Pos is new Ada.Numerics.Discrete_Random(Random_Range);
    --Change namespace. 
    use Random_Pos;
    --Instatiate Generator.
    G : Generator;
    
    --Implementation of GenRand_ExecT
    function Get(Range_MilliS : Positive) return Duration is
        Rand_Pos : Positive;
        Rand_T : Duration;
    begin
        --Create random Integer.
        Rand_Pos := Random(G) mod Range_MilliS;
        --Casting to Duration type.
        Rand_T := Duration(Float(Rand_Pos)/1000.0);
        --Give back the value.
        return Rand_T;
    end Get;
    
    --Initialze RandExecT_Gen.
    procedure Init is
    begin
        Reset(G);
    end Init;
    
end P_Rand_ExecT_Gen;