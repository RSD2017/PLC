
PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
	(* Insert code here *)
	
	IF Enable_feeder AND Enable_in THEN
		IF Counter = 30 THEN
			Output_signal := NOT Output_signal;
			Counter := 0;
		END_IF
		
		Counter := Counter +1;
	ELSE
		Output_signal := FALSE;
	END_IF;
	 
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

