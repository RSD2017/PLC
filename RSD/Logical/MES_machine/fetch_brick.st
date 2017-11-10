FUNCTION fetch_brick
	IF type THEN
		IF var.isGoodCounter > 0 THEN
			fetch_brick:=var.isGoodCounter;
			var.isGoodCounter:=var.isGoodCounter-1;
		ELSE
			fetch_brick:=-1; // Empty
		END_IF;
	ELSE
		IF var.isBadCounter > 0 THEN
			fetch_brick:=var.isBadCounter;
			var.isBadCounter:=var.isBadCounter-1;
		ELSE
			fetch_brick:=-1; // Empty
		END_IF;
	END_IF;
END_FUNCTION