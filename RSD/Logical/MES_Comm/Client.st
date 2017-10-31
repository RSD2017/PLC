(********************************************************************
 * COPYRIGHT -- Bernecker + Rainer
 ********************************************************************
 * Program: Client
 * File: Client.st
 * Author: Bernecker + Rainer
 * Created: February 21, 2008
 ********************************************************************
 * Implementation of program Client
 ********************************************************************)
PROGRAM _INIT

END_PROGRAM
PROGRAM _CYCLIC


	CASE Client.sStep OF
		
		
		 3: (* IDLE state - waits here until there is something to send *)
			IF New_data <> FALSE THEN
				Client.sStep:=0;
			END_IF;
 	
		 0: (* Open Ethernet Interface *)
			Client.TcpOpen_0.enable := 1;	
			Client.TcpOpen_0.pIfAddr := 0;  (* Which Interface to open *)
			Client.TcpOpen_0.port := 13001;  (* Port on client side to use *)
			Client.TcpOpen_0.options :=  tcpOPT_REUSEADDR;
			Client.TcpOpen_0;  (* Call the Function *)
						
			IF Client.TcpOpen_0.status = 0 THEN  (* TcpOpen successfull *)
				Client.sStep := 5;											
			ELSIF Client.TcpOpen_0.status = ERR_FUB_BUSY THEN  (* TcpOpen not finished -> redo *)				
			  (* Busy *)
			ELSE  (* Goto Error Step *)
				Client.sStep := 100;
			END_IF
		
		 5: 		 
		 	Client.linger_opt.lLinger := 0; (* linger Time = 0 *)
			Client.linger_opt.lOnOff := 1; (* linger Option ON *)
				 
		 	Client.TcpIoctl_0.enable := 1;
			Client.TcpIoctl_0.ident := Client.TcpOpen_0.ident; (* Connection Ident from AsTP.TCP_Open *)
			Client.TcpIoctl_0.ioctl := tcpSO_LINGER_SET; (* Set Linger Options *)
			Client.TcpIoctl_0.pData := ADR(Client.linger_opt);
			Client.TcpIoctl_0.datalen := SIZEOF(Client.linger_opt);
   			Client.TcpIoctl_0;	    
		
			IF Client.TcpIoctl_0.status = 0 THEN  (* TcpIoctl successfull *)
				Client.sStep := 3;											
			ELSIF Client.TcpIoctl_0.status = ERR_FUB_BUSY THEN  (* TcpIoctl not finished -> redo *)				
			  (* Busy *)
			ELSE  (* Goto Error Step *)
				Client.sStep := 100;
			END_IF
		
		
		10: (* Connect to the other Station *)					
			Client.TcpClient_0.enable := 1;
			Client.TcpClient_0.ident := Client.TcpOpen_0.ident;  (* Connection Ident from AsTCP.TCP_Open *)
			Client.TcpClient_0.portserv := 4567;  (* Port on server side to use *)
			Client.TcpClient_0.pServer := ADR('192.168.1.23');  (* Server Address *)
			Client.TcpClient_0;  (* Call the Function*)
			
			IF Client.TcpClient_0.status = 0 THEN  (* Open ok -> Send Data *)
				Client.sStep := 20;	
			ELSIF Client.TcpClient_0.status = ERR_FUB_BUSY THEN  (* TcpClient not finished -> redo *)	
			  (* Busy *)
			ELSIF Client.TcpClient_0.status = tcpERR_INVALID THEN  (* Port error -> Close actual connection, and reopen a new one *)
				Client.sStep := 40;
			ELSE  (* Goto Error Step *)
				Client.sStep := 100;
			END_IF
		
		20: (* Send Data to the Server *)
			Client.TcpSend_0.enable := 1;				
			Client.TcpSend_0.ident := Client.TcpOpen_0.ident;  (* Connection Ident from AsTCP.TCP_Open *)
			Client.TcpSend_0.pData := ADR(Data_send);  (* Which data to send *)
			Client.TcpSend_0.datalen := SIZEOF(Data_send);  (* Lenght of data to send *)											
			Client.TcpSend_0.flags := 0;
			Client.TcpSend_0;  (* Call the Function*)
				
			IF Client.TcpSend_0.status = 0 THEN  (* Data was sent sucessfully -> receive data *)
				New_data:=FALSE;
				Client.sStep := 30;
			ELSIF Client.TcpSend_0.status = ERR_FUB_BUSY THEN  (* TcpSend not finished -> redo *)	
			  (* Busy *)
			ELSIF (Client.TcpSend_0.status = tcpERR_SENTLEN) OR (Client.TcpSend_0.status = tcpERR_NOT_CONNECTED) THEN (* Connection Lost *)
				Client.sStep := 40;
			ELSE  (* Goto Error Step *)
				Client.sStep := 100;
			END_IF				
					
	    30: (* Receive Data from the Server *)
			Client.TcpRecv_0.enable := 1;
			Client.TcpRecv_0.ident := Client.TcpOpen_0.ident;  (* Connection Ident from AsTCP.TCP_Open *)
			Client.TcpRecv_0.pData	:= ADR(Data_recv);  (* Where to store the incoming data *)
			Client.TcpRecv_0.datamax := SIZEOF(Data_recv);  (* Lenght of data buffer *)
			Client.TcpRecv_0.flags := 0;
			Client.TcpRecv_0;  (* Call the Function*)
		
			IF Client.TcpRecv_0.status = 0 THEN  (* Data was received sucessfully -> Send next packet *)
				Client.sStep := 40;
				Client.recv_timeout := 0;
				data_received := TRUE;
			ELSIF Client.TcpRecv_0.status = tcpERR_NO_DATA THEN  (* No data received - wait *)
			 	
				(* No Data received *)
			ELSIF Client.TcpRecv_0.status = ERR_FUB_BUSY THEN  (* TcpRecv not finished -> redo *)		
				(* Busy *)
			ELSIF Client.TcpRecv_0.status = tcpERR_NOT_CONNECTED THEN (* Connection Lost *)			
				Client.sStep := 40;
			ELSE  (* Goto Error Step *)
				Client.sStep := 100;
			END_IF
		
		40: (* Close connection *)
			Client.TcpClose_0.enable := 1;
			Client.TcpClose_0.ident := Client.TcpOpen_0.ident;  (* Connection Ident from AsTCP.TCP_Open *)
			Client.TcpClose_0.how := 0;
			Client.TcpClose_0;  (* Call the Function*)
	
			IF Client.TcpClose_0.status = 0 THEN  (* Close sucessfull -> Reopen the interface *)
				Client.sStep := 3;
			ELSIF Client.TcpClose_0.status = ERR_FUB_BUSY THEN  (* TcpClose not finished -> redo *)	
			  (* Busy *)
			ELSE  (* Goto Error Step *)
				Client.sStep := 100;
			END_IF
		
	   100: (* Here some error Handling has to be implemented *)
			
	END_CASE		


END_PROGRAM


