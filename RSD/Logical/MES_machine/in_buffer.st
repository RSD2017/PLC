(* TODO: Add your comment here *)
FUNCTION in_buffer
	IF type THEN
		IF var.isGoodCounter > 0 THEN
			in_buffer:=TRUE;
		ELSE
			in_buffer:=FALSE;
		END_IF;
	END_IF;
	
	IF type = FALSE THEN
		IF var.isBadCounter > 0 THEN
			in_buffer:=TRUE;
		ELSE
			in_buffer:=FALSE;
		END_IF;
	END_IF;
END_FUNCTION