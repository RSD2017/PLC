

PROGRAM _INIT
	(* Insert code here *)
	Client.hostPort := 80;
	Client.method := httpMETHOD_GET;
	Client.option := httpOPTION_HTTP_11;
	Client.pHost := ADR(IP);
	Client.pUri := ADR(URI);
	Client.pRequestData := ADR(REQUESTDATA);
	Client.requestDataLen := REQUESTLENGTH;
	Client.pResponseData := ADR(RESPONSE);
	Client.responseDataSize := RESPONSELENGTH;
	
	 
END_PROGRAM