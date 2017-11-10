<?xml version="1.0" encoding="utf-8"?>
<?AutomationStudio Version=4.3.3.196?>
<SwConfiguration CpuAddress="SL1" xmlns="http://br-automation.co.at/AS/SwConfiguration">
  <TaskClass Name="Cyclic#1">
    <Task Name="MES_machin" Source="MES_machine.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="RSI" Source="RSI.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="MES_Comm" Source="MES_Comm.prg" Memory="UserROM" Language="IEC" Debugging="true" />
  </TaskClass>
  <TaskClass Name="Cyclic#2">
    <Task Name="Camera" Source="Camera.prg" Memory="UserROM" Language="IEC" Debugging="true" />
  </TaskClass>
  <TaskClass Name="Cyclic#3">
    <Task Name="Camera_A" Source="Camera_A.prg" Memory="UserROM" Language="IEC" Debugging="true" />
  </TaskClass>
  <TaskClass Name="Cyclic#4">
    <Task Name="Feeder" Source="Feeder.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="Conveyor" Source="Conveyor.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="Servo" Source="Servo.prg" Memory="UserROM" Language="IEC" Debugging="true" />
  </TaskClass>
  <Binaries>
    <BinaryObject Name="udbdef" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="TCData" Source="" Memory="SystemROM" Language="Binary" />
    <BinaryObject Name="ashwac" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="arconfig" Source="" Memory="SystemROM" Language="Binary" />
    <BinaryObject Name="asfw" Source="" Memory="SystemROM" Language="Binary" />
    <BinaryObject Name="ashwd" Source="" Memory="SystemROM" Language="Binary" />
    <BinaryObject Name="iomap" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="User" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="Role" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="sysconf" Source="" Memory="SystemROM" Language="Binary" />
    <BinaryObject Name="OpcUaMap" Source="" Memory="UserROM" Language="Binary" />
  </Binaries>
  <Libraries>
    <LibraryObject Name="AsHttp" Source="Libraries.AsHttp.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="runtime" Source="Libraries.runtime.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="AsTCP" Source="Libraries.AsTCP.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="AsUDP" Source="Libraries.AsUDP.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="standard" Source="Libraries.standard.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="MTBasics" Source="Libraries.MTBasics.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="brsystem" Source="Libraries.brsystem.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="MTTypes" Source="Libraries.MTTypes.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="sys_lib" Source="Libraries.sys_lib.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="asstring" Source="Libraries.asstring.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="astime" Source="" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="asieccon" Source="" Memory="UserROM" Language="Binary" Debugging="true" />
  </Libraries>
</SwConfiguration>