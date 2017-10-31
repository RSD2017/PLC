
PROGRAM _CYCLIC
	(* Insert code here *)
	IF Tilt = TRUE THEN
		Pulse := Duty_cycle_pos1;
		// Delay.In := 
		Delay.In := 1.0;
	END_IF
	Delay();
	IF Delay.Out = 1.0 THEN
		Pulse := Duty_cycle_pos2;
		Delay.In := 0.0;
		Tilt := FALSE;
	END_IF
	
	(* call function block *)

	 
END_PROGRAM
