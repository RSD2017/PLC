(* TODO: Add your comment here *)
FUNCTION buffer_free
	IF type THEN
		IF var.isGoodCounter < 10 THEN
			buffer_free:= TRUE;
		ELSE
			buffer_free:=FALSE;
		END_IF;
	END_IF;
	
	IF type = FALSE THEN
		IF var.isBadCounter < 5 THEN
			buffer_free:= TRUE;
		ELSE
			buffer_free:=FALSE;
		END_IF;
	END_IF;
END_FUNCTION