
TYPE
	Variables : 	STRUCT 
		isGoodCounter : USINT;
		isBadCounter : USINT;
		position : UDINT;
		sliske : UDINT;
		buffer_bad : ARRAY[0..4]OF UDINT;
		buffer_good : ARRAY[0..10]OF UDINT;
	END_STRUCT;
END_TYPE
