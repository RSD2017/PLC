(********************************************************************
 * COPYRIGHT -- Bernecker + Rainer
 ********************************************************************
 * Program: Server
 * File: Server.st
 * Author: Bernecker + Rainer
 * Created: June 02, 2008
 ********************************************************************
 * Implementation of program Server
 ********************************************************************)

PROGRAM _CYCLIC

	
	IF Enable_in = TRUE THEN
		IF Camera_good OR Camera_bad THEN
			Delay.In := 1.0;
		ELSE
			Delay.In := 0.0;
		END_IF	

		Delay();
		
		IF Delay.Out = 1.0 AND Old_delay = 0.0 THEN
			Old_delay := 1.0;
			Activate := TRUE;
			Camera_good := FALSE;
			Camera_bad := FALSE;
		ELSIF Delay.Out = 0.0 THEN
			Old_delay := 0.0;
		END_IF
		
	ELSE
		Activate := FALSE;
	END_IF
	
	IF Ready = '0' OR Activate_override = FALSE THEN
		Activate := FALSE;
	END_IF
	
	 

	CASE Server.sStep OF
		
		0:	(* Open UDP Port *)
			Server.UdpOpen_0.enable := 1;
			Server.UdpOpen_0.pIfAddr := 0;	(* Listen on all TCP/IP Interfaces*)
			Server.UdpOpen_0.port := 49000;	(* Port to listen*)
			Server.UdpOpen_0.options := 0;
			Server.UdpOpen_0;	(* Call the Function*)
			
			IF Server.UdpOpen_0.status = 0 THEN  (* UdpOpen successful*)
				Server.sStep := 1;	
			ELSIF Server.UdpOpen_0.status = ERR_FUB_BUSY THEN  (* UdpOpen not finished -> redo *)			
			  (* Busy *)	
			ELSE  (* Goto Error Step *)
				Server.sStep := 10;
			END_IF
			
		1:	(* Wait for Data *)
			Server.UdpRecv_0.enable := 1;
			Server.UdpRecv_0.ident := Server.UdpOpen_0.ident;	(* Client Ident from AsUDP.UDP_Open *)
			Server.UdpRecv_0.pData := ADR(Server.data_buffer);	(* Where to store the incoming data *)
			Server.UdpRecv_0.datamax := SIZEOF(Server.data_buffer);	(* Lenght of data buffer *)
			Server.UdpRecv_0.flags := 0;
			Server.UdpRecv_0.pIpAddr := ADR(Server.client_address);	(* IP Address of the Client *)
			Server.UdpRecv_0;	(* Call the Function*)
			
			IF Server.UdpRecv_0.status = 0 THEN  (* Data received *)
				Server.sStep := 2;
				Ready:=MID(Server.data_buffer,1,25);
				
			
				
			ELSIF Server.UdpRecv_0.status = udpERR_NO_DATA THEN  (* No data received - wait *)
				(* No Data received *)
			ELSIF Server.UdpRecv_0.status = ERR_FUB_BUSY THEN  (* UdpRecv not finished -> redo *)					
				(* Busy *)
			ELSE  (* Goto Error Step *)
				Server.sStep := 10;
			END_IF	
		
		

		
		2:	(* Send Data back to Client *)
			startPos:=FIND(Server.data_buffer,'<IPOC>');
				endPos:=FIND(Server.data_buffer, '</Rob>');

				TOC:=MID(Server.data_buffer,endPos-startPos,startPos);
		
			Output:='<Sen Type="ImFree"><Activate>';
			
			IF Enable_in = TRUE AND Ready = '1' AND Activate = TRUE AND Activate_override THEN
				
				//IF Activate = TRUE THEN
				Output:=CONCAT(Output, '1');
			ELSE
				Output:=CONCAT(Output, '0');
			END_IF
			
			Output:=CONCAT(Output,'</Activate>');
			Output:=CONCAT(Output,'<Buf>');
			Output:=CONCAT(Output,Buffer_use);
			Output:=CONCAT(Output,'</Buf>');
			Output:=CONCAT(Output,'<Index>');
			Output:=CONCAT(Output, Robot_index);

			
			
			//IF Good_brick AND Activate THEN
			//	Output:=CONCAT(Output,Buffer_good[index_good]);
			//	index_good := index_good +1;
			//	Activate:=FALSE;
			//ELSIF Good_brick = FALSE AND Activate THEN
			//	Output:=CONCAT(Output,Buffer_bad[index_bad]);
			//	index_bad := index_bad +1;
			//	Activate:=FALSE;
			//ELSE
			//	Output:=CONCAT(Output,'0');
			//END_IF
			
			//test
			//IF Activate THEN
			//	Output:=CONCAT(Output, Buffer_test);
			//	Activate := FALSE;
			//END_IF;
			
			Output:=CONCAT(Output,'</Index>');
			Output:=CONCAT(Output, TOC);
			Output:=CONCAT(Output,'</Sen>');
			
			// 100 -> robot ready -> to PLC
			// 101 -> Activate -> to Robot
			// 102 -> Buf -> to Robot
			// 113-128 -> Index (word 16 bit) -> to Robot 
			
				
			
			
			Server.UdpSend_0.enable := 1;
			Server.UdpSend_0.ident := Server.UdpOpen_0.ident;	(* Client Ident from AsUDP.UDP_Open *)
			Server.UdpSend_0.pHost := ADR(Server.client_address);	(* IP Address of the Client *)
			Server.UdpSend_0.port := Server.UdpRecv_0.port;		(* Port number of the Client *)
			Server.UdpSend_0.pData := ADR(Output);	(* Which data to send *)
			Server.UdpSend_0.datalen := SIZEOF(Output);	(* Lenght of data to send *)
			Server.UdpSend_0.flags := 0;
			Server.UdpSend_0;	(* Call the Function*)
			
			IF Server.UdpSend_0.status = 0 THEN  (* Data sent *)
				Server.sStep := 1;					   
			ELSIF Server.UdpSend_0.status = ERR_FUB_BUSY THEN  (* UdpSend not finished -> redo *)						
			  (* Busy *)
			ELSE  (* Goto Error Step *)
				Server.sStep := 10;
			END_IF
	    
		10:  (* Here some error Handling has to be implemented *)
			
	END_CASE		
			

END_PROGRAM
