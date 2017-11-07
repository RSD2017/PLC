FUNCTION save_brick
	IF type THEN		
		IF var.isGoodCounter < 10 THEN
			var.buffer_good[var.isGoodCounter] := partid;
			var.isGoodCounter:=var.isGoodCounter+1;
			save_brick:=var.isGoodCounter;
		ELSE
			save_brick:=-1; // Full
		END_IF;
	ELSE
		IF var.isBadCounter < 4 THEN
			var.buffer_bad[var.isBadCounter]:= partid;
			var.isBadCounter:=var.isBadCounter+1;
			save_brick:=var.isBadCounter;
		ELSE
			save_brick:=-1; // Full
		END_IF;
	END_IF;
END_FUNCTION