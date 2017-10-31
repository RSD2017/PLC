UnmarkedObjectFolder := C:/projects/PLC/RSD/Logical/Servo
MarkedObjectFolder := C:/projects/PLC/RSD/Logical/Servo

$(AS_CPU_PATH)/Servo.br: \
	$(AS_PROJECT_CPU_PATH)/Cpu.per \
	$(AS_CPU_PATH)/Servo/Servo.ox
	@'$(AS_BIN_PATH)/BR.AS.TaskBuilder.exe' '$(AS_CPU_PATH)/Servo/Servo.ox' -o '$(AS_CPU_PATH)/Servo.br' -v V1.00.0 -f '$(AS_CPU_PATH)/NT.ofs' -offsetLT '$(AS_BINARIES_PATH)/$(AS_CONFIGURATION)/$(AS_PLC)/LT.ofs' -T SG4  -M IA32  -B I4.33 -extConstants -d 'runtime: V* - V*,asieccon: V* - V*' -r Cyclic2 -p 2 -s 'Servo' -L 'AsHttp: V*, AsIecCon: V*, AsTCP: V*, astime: V*, AsUDP: V*, brsystem: V*, MTBasics: V2.21.0, MTTypes: V1.03.4, operator: V*, runtime: V*, standard: V*, sys_lib: V*' -P '$(AS_PROJECT_PATH)' -secret '$(AS_PROJECT_PATH)_br.as.taskbuilder.exe'

$(AS_CPU_PATH)/Servo/Servo.ox: \
	$(AS_CPU_PATH)/Servo/a.out
	@'$(AS_BIN_PATH)/BR.AS.Backend.exe' '$(AS_CPU_PATH)/Servo/a.out' -o '$(AS_CPU_PATH)/Servo/Servo.ox' -T SG4 -r Cyclic2   -G V4.1.2  -B I4.33 -secret '$(AS_PROJECT_PATH)_br.as.backend.exe'

$(AS_CPU_PATH)/Servo/a.out: \
	$(AS_CPU_PATH)/Servo/Cyclic.st.o \
	$(AS_CPU_PATH)/Servo/Init.st.o \
	$(AS_CPU_PATH)/Servo/Exit.st.o \
	$(AS_CPU_PATH)/Servo/_bur_pvdef.st.o
	@'$(AS_BIN_PATH)/BR.AS.CCompiler.exe' -link '$(AS_CPU_PATH)/Servo/Cyclic.st.o' '$(AS_CPU_PATH)/Servo/Init.st.o' '$(AS_CPU_PATH)/Servo/Exit.st.o' '$(AS_CPU_PATH)/Servo/_bur_pvdef.st.o'  -o '$(AS_CPU_PATH)/Servo/a.out'  -G V4.1.2  -T SG4  -M IA32  '-Wl,$(AS_PROJECT_PATH)/Logical/Libraries/MTBasics/SG4/IA32/libMTBasics.a' '-Wl,$(AS_SYSTEM_PATH)/I0433/SG4/IA32/libsys_lib.a' '-Wl,$(AS_PROJECT_PATH)/Logical/Libraries/MTTypes/SG4/IA32/libMTTypes.a' '-Wl,$(AS_SYSTEM_PATH)/I0433/SG4/IA32/libbrsystem.a' '-Wl,$(AS_SYSTEM_PATH)/I0433/SG4/IA32/libstandard.a' '-Wl,$(AS_SYSTEM_PATH)/I0433/SG4/IA32/libAsUDP.a' '-Wl,$(AS_SYSTEM_PATH)/I0433/SG4/IA32/libAsTCP.a' '-Wl,$(AS_SYSTEM_PATH)/I0433/SG4/IA32/libAsHttp.a' '-Wl,$(AS_SYSTEM_PATH)/I0433/SG4/IA32/libAsIecCon.a' '-Wl,$(AS_SYSTEM_PATH)/I0433/SG4/IA32/libastime.a' '-Wl,$(AS_SYSTEM_PATH)/I0433/SG4/IA32/libruntime.a' '-Wl,$(AS_SYSTEM_PATH)/I0433/SG4/IA32/liboperator.a' -specs=I386specs_brelf -nostdlib -secret '$(AS_PROJECT_PATH)_br.as.ccompiler.exe'

$(AS_CPU_PATH)/Servo/Cyclic.st.o: \
	$(AS_PROJECT_PATH)/Logical/Servo/Cyclic.st \
	$(AS_PROJECT_PATH)/Logical/Libraries/MTBasics/MTBasics.fun \
	$(AS_PROJECT_PATH)/Logical/Libraries/MTBasics/MTBasics.typ \
	$(AS_PROJECT_PATH)/Logical/Servo/Variables.var \
	$(AS_PROJECT_PATH)/Logical/Global.var
	@'$(AS_BIN_PATH)/BR.AS.IecCompiler.exe' '$(AS_PROJECT_PATH)/Logical/Servo/Cyclic.st' -o '$(AS_CPU_PATH)/Servo/Cyclic.st.o'  -O '$(AS_CPU_PATH)//Servo/Cyclic.st.o.opt' -secret '$(AS_PROJECT_PATH)_br.as.ieccompiler.exe'

$(AS_CPU_PATH)/Servo/Init.st.o: \
	$(AS_PROJECT_PATH)/Logical/Servo/Init.st \
	$(AS_PROJECT_PATH)/Logical/Libraries/MTBasics/MTBasics.fun \
	$(AS_PROJECT_PATH)/Logical/Libraries/MTBasics/MTBasics.typ \
	$(AS_PROJECT_PATH)/Logical/Servo/Variables.var \
	$(AS_PROJECT_PATH)/Logical/Global.var
	@'$(AS_BIN_PATH)/BR.AS.IecCompiler.exe' '$(AS_PROJECT_PATH)/Logical/Servo/Init.st' -o '$(AS_CPU_PATH)/Servo/Init.st.o'  -O '$(AS_CPU_PATH)//Servo/Init.st.o.opt' -secret '$(AS_PROJECT_PATH)_br.as.ieccompiler.exe'

$(AS_CPU_PATH)/Servo/Exit.st.o: \
	$(AS_PROJECT_PATH)/Logical/Servo/Exit.st \
	$(AS_PROJECT_PATH)/Logical/Libraries/MTBasics/MTBasics.fun \
	$(AS_PROJECT_PATH)/Logical/Libraries/MTBasics/MTBasics.typ \
	$(AS_PROJECT_PATH)/Logical/Servo/Variables.var \
	$(AS_PROJECT_PATH)/Logical/Global.var
	@'$(AS_BIN_PATH)/BR.AS.IecCompiler.exe' '$(AS_PROJECT_PATH)/Logical/Servo/Exit.st' -o '$(AS_CPU_PATH)/Servo/Exit.st.o'  -O '$(AS_CPU_PATH)//Servo/Exit.st.o.opt' -secret '$(AS_PROJECT_PATH)_br.as.ieccompiler.exe'

$(AS_CPU_PATH)/Servo/_bur_pvdef.st.o: \
	$(AS_PROJECT_PATH)/Logical/Libraries/MTBasics/MTBasics.fun \
	$(AS_PROJECT_PATH)/Logical/Libraries/MTBasics/MTBasics.typ \
	$(AS_PROJECT_PATH)/Logical/Servo/Variables.var \
	$(AS_PROJECT_PATH)/Logical/Global.var
	@'$(AS_BIN_PATH)/BR.AS.IecCompiler.exe' '$(AS_PATH)/AS/GnuInst/V4.1.2/i386-elf/include/bur/_bur_pvdef.st' -o '$(AS_CPU_PATH)/Servo/_bur_pvdef.st.o'  -O '$(AS_CPU_PATH)//Servo/_bur_pvdef.st.opt' -secret '$(AS_PROJECT_PATH)_br.as.ieccompiler.exe'

-include $(AS_CPU_PATH)/Force.mak 

