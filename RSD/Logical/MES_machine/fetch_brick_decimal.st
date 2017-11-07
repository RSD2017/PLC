
(* TODO: Add your comment here *)
FUNCTION fetch_brick_decimal
	var.position := fetch_brick(ADR(var), type);
		
	IF var.position = -1 THEN
		fetch_brick_decimal := -1;
		RETURN;
	END_IF;
	
	IF type = FALSE THEN
		var.sliske:=2;
	ELSE
		IF var.position > 5 THEN
			var.sliske:=3;
		ELSE
			var.sliske:=1;
		END_IF;
	END_IF;

	
	IF var.position > 5 THEN
		fetch_brick_decimal := SHL(var.sliske,3) + var.position -5 -1;
	ELSE
		fetch_brick_decimal := SHL(var.sliske,3) + var.position -1;
	END_IF
	
END_FUNCTION
