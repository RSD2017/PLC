SHELL := cmd.exe
CYGWIN=nontsec
export PATH := C:\Program Files (x86)\Parallels\Parallels Tools\Applications;C:\Windows\system32;C:\Windows;C:\Windows\System32\Wbem;C:\Windows\System32\WindowsPowerShell\v1.0\;C:\Program Files\Git\cmd;C:\Program Files\CMake\bin;C:\Program Files (x86)\Common Files\Hilscher GmbH\TLRDecode;C:\Users\Nikolaj\AppData\Local\GitHubDesktop\bin;C:\Program Files (x86)\Common Files\Hilscher GmbH\TLRDecode;C:\Users\Nikolaj\AppData\Local\GitHubDesktop\bin
export AS_BUILD_MODE := Build
export AS_VERSION := 4.3.3.196
export AS_COMPANY_NAME :=  
export AS_USER_NAME := Nikolaj
export AS_PATH := C:/BrAutomation/AS43
export AS_BIN_PATH := C:/BrAutomation/AS43/bin-en
export AS_PROJECT_PATH := C:/projects/PLC/RSD
export AS_PROJECT_NAME := RSD
export AS_SYSTEM_PATH := C:/BrAutomation/AS/System
export AS_VC_PATH := C:/BrAutomation/AS43/AS/VC
export AS_TEMP_PATH := C:/projects/PLC/RSD/Temp
export AS_CONFIGURATION := RSD_Default
export AS_BINARIES_PATH := C:/projects/PLC/RSD/Binaries
export AS_GNU_INST_PATH := C:/BrAutomation/AS43/AS/GnuInst/V4.1.2
export AS_GNU_BIN_PATH := $(AS_GNU_INST_PATH)/bin
export AS_GNU_INST_PATH_SUB_MAKE := C:/BrAutomation/AS43/AS/GnuInst/V4.1.2
export AS_GNU_BIN_PATH_SUB_MAKE := $(AS_GNU_INST_PATH_SUB_MAKE)/bin
export AS_INSTALL_PATH := C:/BrAutomation/AS43
export WIN32_AS_PATH := "C:\BrAutomation\AS43"
export WIN32_AS_BIN_PATH := "C:\BrAutomation\AS43\bin-en"
export WIN32_AS_PROJECT_PATH := "C:\projects\PLC\RSD"
export WIN32_AS_SYSTEM_PATH := "C:\BrAutomation\AS\System"
export WIN32_AS_VC_PATH := "C:\BrAutomation\AS43\AS\VC"
export WIN32_AS_TEMP_PATH := "C:\projects\PLC\RSD\Temp"
export WIN32_AS_BINARIES_PATH := "C:\projects\PLC\RSD\Binaries"
export WIN32_AS_GNU_INST_PATH := "C:\BrAutomation\AS43\AS\GnuInst\V4.1.2"
export WIN32_AS_GNU_BIN_PATH := "$(WIN32_AS_GNU_INST_PATH)\\bin" 
export WIN32_AS_INSTALL_PATH := "C:\BrAutomation\AS43"

.suffixes:

ProjectMakeFile:

	@'$(AS_BIN_PATH)/BR.AS.AnalyseProject.exe' '$(AS_PROJECT_PATH)/RSD.apj' -t '$(AS_TEMP_PATH)' -c '$(AS_CONFIGURATION)' -o '$(AS_BINARIES_PATH)'   -sfas -buildMode 'Build'  

	@$(AS_GNU_BIN_PATH)/mingw32-make.exe -r -f 'C:/projects/PLC/RSD/Temp/Objects/$(AS_CONFIGURATION)/X20CP1382/#cpu.mak' -k 

