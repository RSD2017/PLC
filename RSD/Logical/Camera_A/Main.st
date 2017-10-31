
PROGRAM _INIT
	(* Insert code here *)
	Delay.Enable := TRUE;
	Delay.DelayTime := 0.225; // 1 at 10hz, 0.4 at 20hz
	 
END_PROGRAM

PROGRAM _CYCLIC
	(* Insert code here *)
	
	
	IF Enable_in = TRUE THEN
		Delay.In := BOOL_TO_REAL(Sensor_in);
		Delay();
		Camera_trigger := REAL_TO_BOOL(Delay.Out);
	ELSE
		Camera_trigger := FALSE;
	END_IF
	
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

