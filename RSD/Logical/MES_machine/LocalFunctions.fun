
FUNCTION get_partid : UDINT
	VAR_INPUT
		var : REFERENCE TO Variables;
		type : BOOL;
		pos : UDINT;
	END_VAR
END_FUNCTION

FUNCTION fetch_brick : UDINT (*TODO: Add your comment here*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		var : REFERENCE TO Variables;
		type : BOOL;
	END_VAR
END_FUNCTION

FUNCTION save_brick : UDINT (*TODO: Add your comment here*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		var : REFERENCE TO Variables;
		type : BOOL;
		partid : UDINT;
	END_VAR
END_FUNCTION

FUNCTION fetch_brick_decimal : UDINT (*TODO: Add your comment here*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		var : REFERENCE TO Variables;
		type : BOOL;
	END_VAR
END_FUNCTION

FUNCTION save_brick_decimal : UDINT (*TODO: Add your comment here*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		var : REFERENCE TO Variables;
		type : BOOL;
		partid : UDINT;
	END_VAR
END_FUNCTION

FUNCTION buffer_free : BOOL
	VAR_INPUT
		var : REFERENCE TO Variables;
		type : BOOL;
	END_VAR
END_FUNCTION

FUNCTION in_buffer : BOOL
	VAR_INPUT
		var : REFERENCE TO Variables;
		type : BOOL;
	END_VAR
END_FUNCTION
