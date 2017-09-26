(********************************************************************
 * COPYRIGHT -- Bernecker + Rainer
 ********************************************************************
 * Package: LibAsTCP
 * File: LibAsTCP.typ
 * Author: Bernecker + Rainer
 * Created: February 21, 2008
 ********************************************************************
 * Data types of package LibAsTCP
 ********************************************************************)

TYPE
	LibAsTCP1_ST_typ : 	STRUCT  (*Datatyp for global Variables*)
		receive_data : STRING[80]; (*Data which has been received*)
		Bad : UDINT := 0;
		Good : UDINT := 0;
	END_STRUCT;
END_TYPE
