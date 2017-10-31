

PROGRAM _INIT
	(* Insert code here *)
	 
	Delay.Enable := TRUE;
	Delay.DelayTime := 0.6; // 2.25 at 10hz, 1.125 at 20hz
	
	Buffer_good[0] := '8';
	Buffer_good[1] := '9';
	Buffer_good[2] := '10';
	Buffer_good[3] := '11';
	Buffer_good[4] := '12';
	Buffer_good[5] := '24';
	Buffer_good[6] := '25';
	Buffer_good[7] := '26';
	Buffer_good[8] := '27';
	Buffer_good[9] := '28';
	
	Buffer_bad[0] := '16';
	Buffer_bad[1] := '17';
	Buffer_bad[2] := '18';
	Buffer_bad[3] := '19';
	
	
END_PROGRAM