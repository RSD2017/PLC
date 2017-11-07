(* TODO: Add your comment here *)
FUNCTION get_partid
	IF type THEN
		get_partid:=var.buffer_good[pos];
	END_IF;
	
	IF type = FALSE THEN
		get_partid:=var.buffer_bad[pos];
	END_IF;
END_FUNCTION