$(AS_CPU_PATH)/ashwac.br: \
	$(AS_PROJECT_CONFIG_PATH)/Hardware.hw 
	@'$(AS_BIN_PATH)/BR.AS.SystemConfiguration.Builder.exe' '$(AS_PROJECT_CONFIG_PATH)/Hardware.hw'  -L 'AsHttp: V*, AsIecCon: V*, asstring: V*, AsTCP: V*, astime: V*, AsUDP: V*, brsystem: V*, MTBasics: V2.21.0, MTTypes: V1.03.4, operator: V*, runtime: V*, standard: V*, sys_lib: V*' -c '$(AS_CONFIGURATION)' -Z 'Acp10Arnc0: 3.16.2, mapp: 1.60.0, UnitSystem: n.d, TextSystem: n.d, Connectivity: n.d, AAS: n.d' -o '$(AS_CPU_PATH)/ashwac.br' -T SG4  -M IA32  -B I4.33 -P '$(AS_PROJECT_PATH)' -s 'RSD_Default' -secret '$(AS_PROJECT_PATH)_br.as.systemconfiguration.builder.exe'

-include $(AS_CPU_PATH)/Force.mak 
