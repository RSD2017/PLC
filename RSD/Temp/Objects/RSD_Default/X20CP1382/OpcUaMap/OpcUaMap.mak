$(AS_CPU_PATH)/OpcUaMap.br: \
	$(AS_PROJECT_CPU_PATH)/Connectivity/OpcUA/OpcUaMap.uad \
	$(AS_PROJECT_PATH)/Logical/Global.var \
	$(AS_PROJECT_PATH)/Logical/MES_machine/Variables2.var \
	$(AS_PROJECT_PATH)/Physical/$(AS_CONFIGURATION)/$(AS_PLC)/Cpu.sw \
	$(AS_PROJECT_PATH)/Logical/MES_machine/Variables.var \
	$(AS_PROJECT_PATH)/Logical/Global2.typ \
	$(AS_PROJECT_PATH)/Logical/MES_Comm/Client.var \
	$(AS_PROJECT_PATH)/Logical/Camera_A/Variables.var \
	$(AS_PROJECT_PATH)/Logical/Feeder/Variables.var \
	$(AS_PROJECT_PATH)/Logical/Conveyor/Variables.var
	@'$(AS_BIN_PATH)/BR.OPC.UA.Builder.exe'  '$(AS_PROJECT_CPU_PATH)/Connectivity/OpcUA/OpcUaMap.uad' -o '$(AS_CPU_PATH)/OpcUaMap.br' -H '$(AS_PROJECT_CONFIG_PATH)/Hardware.hw' -B I4.33 -c RSD_Default -P '$(AS_PROJECT_PATH)'
