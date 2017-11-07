
PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
	(* Insert code here *)
	 
	CASE MES_step OF
		
		0:		// ST-Start
			Part_selected := FALSE;
			data_received := FALSE;
		
		5:		// ST-Idle
			IF Order_selected = FALSE THEN
				MES_step := 20;
			
			ELSIF Part_selected = FALSE AND Sensor_in THEN
				MES_step := 10;
			
			ELSIF Current_part_post = FALSE AND (Camera_good OR Camera_bad) THEN
				MES_step := 15;
				
			ELSIF Part_status_posted THEN
				IF Camera_good AND Order_good > 0 THEN
					MES_step := 30;
				ELSIF Camera_bad AND Order_bad > 0 THEN
					MES_step := 30;
				ELSIF Camera_good AND buffer_free(ADR(variables), TRUE) THEN
					MES_step := 40;
				ELSIF Camera_bad AND buffer_free(ADR(variables), FALSE) THEN
					MES_step := 40;
				ELSE
					MES_step := 43;
					
				END_IF
				
				Part_status_posted := FALSE;
			END_IF
		
		
		
		
		10:		// ST-Get part 
			IF New_data = FALSE THEN
				Data_send := 'GET PART 1$n';
				Data_length := 11;
				New_data := TRUE;
				MES_step := 11;
				Should_recv := TRUE;
				Activate_override := TRUE;
			END_IF
		
		
		11:
			IF data_received = TRUE THEN
				data_received := FALSE;
				memcpy(ADR(Current_part_id), ADR(Data_recv_vector[0]),4);
				Part_selected := TRUE;
				Current_part_post := FALSE;
				MES_step := 5;
			END_IF
		
		
		15:		// ST-Post Part
			IF New_data = FALSE THEN
				Data_send := 'POST PARTSTATUS$n';
				Number := 1000;
				WHILE Number > Current_part_id AND Number <> 0 DO
					Data_send:=CONCAT(Data_send, '0');
					Number := Number/10;
				END_WHILE;
				
				IF Current_part_id <> 0 THEN
					String_tmp := UDINT_TO_STRING(Current_part_id);
					Data_send:=CONCAT(Data_send, String_tmp);
				END_IF
				
				
				IF Camera_good THEN
					Data_send:=CONCAT(Data_send, ' 1$n');			
				ELSIF Camera_bad THEN
					Data_send:=CONCAT(Data_send, ' 0$n');					
				END_IF
			
				Data_length := 23;
				Should_recv := FALSE;
				New_data := TRUE;
				Part_selected := FALSE;
				Current_part_post := TRUE;
				MES_step := 5;
				Part_status_posted := TRUE;
			END_IF
		
		
		
		20:		// ST-Get Order
			IF New_data = FALSE THEN
				Data_send := 'GET ORDER 1$n';
				Data_length := 12;
				Current_order_ids := '';		
				New_data := TRUE;
				MES_step := 21;
				Should_recv := TRUE;
			END_IF
		
		21:
			IF data_received = TRUE THEN
				data_received := FALSE;
				memcpy(ADR(Current_order_id), ADR(Data_recv_vector[0]),4);
				IF Current_order_id > 10000 THEN
					MES_step := 45;
				ELSE
					Order_good := 0;
					Order_bad := 0;
					memcpy(ADR(Current_order_parts), ADR(Data_recv_vector[1]),4);
					FOR Order_index:=0 TO Current_order_parts-1 BY 1 DO
						memcpy(ADR(Parts_vector[Order_index]), ADR(Data_recv_vector[Order_index+2]),4);
						IF Parts_vector[Order_index] = 1 THEN
							Order_good := Order_good +1;
						ELSIF Parts_vector[Order_index] = 0 THEN
							Order_bad := Order_bad +1;
						END_IF
						
					END_FOR
					
					Order_selected := TRUE;
						MES_step := 5;
					
					
				END_IF
						
			END_IF
		
		25:		// ST-Post Order
			IF New_data = FALSE THEN
				Data_send := 'POST ORDERSTATUS$n';
				Number := 1000;
				WHILE Number > Current_order_id AND Number <> 0 DO
					Data_send:=CONCAT(Data_send, '0');
					Number := Number/10;
				END_WHILE;
				
				IF Current_order_id <> 0 THEN
					String_tmp := UDINT_TO_STRING(Current_order_id);
					Data_send:=CONCAT(Data_send, String_tmp);
				END_IF
				
				Data_length := 21;
				Data_send := CONCAT(Data_send, Current_order_ids);
				Current_order_ids := CONCAT(Current_order_ids, 'p');
				Pos_find := FIND(Current_order_ids, 'p');
				Data_length := Data_length + INT_TO_USINT(Pos_find);
				
				
				
				Data_send := CONCAT(Data_send, '$n');
				Should_recv := FALSE;
				New_data := TRUE;
				Order_selected := FALSE;
				MES_step := 5;
			END_IF
		
		30:		// ST - Put box
			Buffer_use := '0';
			Robot_index := '0';
			String_tmp := UDINT_TO_STRING(Current_part_id);
			Current_order_ids := CONCAT(Current_order_ids, String_tmp);
			Current_order_ids := CONCAT(Current_order_ids, ' ');
			IF Camera_good THEN
				Order_good := Order_good - 1;
			ELSIF Camera_bad THEN
				Order_bad := Order_bad -1;
			END_IF;
			MES_step := 31;
		
		31:
			IF Ready = '0' THEN
				MES_step := 32;
			END_IF;
		
		32:
			IF Ready = '1' THEN
				IF Order_good = 0 AND Order_bad = 0 THEN
					Tilt := TRUE;
					MES_step := 25;			
				ELSIF Order_good > 0 AND in_buffer(ADR(variables),TRUE) THEN
					MES_step := 35;
				ELSIF Order_bad > 0 AND in_buffer(ADR(variables), FALSE) THEN
					MES_step := 35;
				ELSE
					MES_step := 5;
				END_IF
				
			END_IF;
		
		
		35:		// ST- Tak Buf
			Buffer_use := '0';
			IF Order_good > 0 AND in_buffer(ADR(variables), TRUE) THEN
				Robot_index := UDINT_TO_STRING(fetch_brick_decimal(ADR(variables), TRUE));
				Buffer_part_id := get_partid(ADR(variables), TRUE, variables.isGoodCounter);
				Order_good := Order_good - 1;
			ELSIF Order_bad > 0 AND in_buffer(ADR(variables), FALSE) THEN
				Robot_index := UDINT_TO_STRING(fetch_brick_decimal(ADR(variables), FALSE));
				Buffer_part_id := get_partid(ADR(variables), FALSE, variables.isBadCounter);
				Order_bad := Order_bad - 1;
			END_IF
			
			Activate := TRUE;
		
			String_tmp := UDINT_TO_STRING(Buffer_part_id);
			Current_order_ids := CONCAT(Current_order_ids, String_tmp);
			Current_order_ids := CONCAT(Current_order_ids, ' ');
			MES_step := 36;
		
		36:
			IF Ready = '0' THEN
				MES_step := 37;
			END_IF
		
		37:
			IF Ready = '1' THEN
				IF Order_good = 0 AND Order_bad = 0 THEN
					Tilt := TRUE;
					MES_step := 25;			
				ELSE
					MES_step := 5;
				END_IF
			END_IF
		
		
			
		
		40:		// ST- put buf
		
		
			IF Camera_good AND buffer_free(ADR(variables), TRUE) THEN
				Buffer_use := '1';
				Robot_index := UDINT_TO_STRING(save_brick_decimal(ADR(variables), TRUE, Current_part_id));
			ELSIF Camera_bad AND buffer_free(ADR(variables), FALSE) THEN
				Buffer_use := '1';
				Robot_index := UDINT_TO_STRING(save_brick_decimal(ADR(variables), FALSE, Current_part_id));
			END_IF
			MES_step := 41;
		
		41:
			IF Ready = '0' THEN
				MES_step := 42;
			END_IF;
		
		42:
			IF Ready = '1' THEN
				MES_step := 5;
			END_IF
				
		
				
		43: // BUF full
			Activate_override := FALSE;
			
			IF New_data = FALSE THEN
				Data_send := 'POST PARTSTATUS$n';
				Number := 1000;
				WHILE Number > Current_part_id AND Number <> 0 DO
					Data_send:=CONCAT(Data_send, '0');
					Number := Number/10;
				END_WHILE;
				
				IF Current_part_id <> 0 THEN
					String_tmp := UDINT_TO_STRING(Current_part_id);
					Data_send:=CONCAT(Data_send, String_tmp);
				END_IF
				
				
				Data_send:= CONCAT(Data_send, ' Buffer full$n');
			
				Data_length := 33;
				Should_recv := FALSE;
				New_data := TRUE;
				MES_step := 5;
			END_IF
			
		
		45:		// ST- Finished
			Activate_override := FALSE;
		
		
		
		
	END_CASE
	
	
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

