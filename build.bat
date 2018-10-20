@echo off

set ROYALE_PATH=D:\dev\royale-emulation-works\apache-royale-0.9.4-bin-js-swf

set COMPILER_PATH=%ROYALE_PATH%\royale-asjs\js\bin

set PRJHOME=D:\dev\royale-emulation-works\github\royale-testing
set MAINCLASS=%PRJHOME%\src\main\Main.mxml

set SRCPATH=%PRJHOME%\src

set MX_SWC=%ROYALE_PATH%\royale-asjs\frameworks\projects\MXRoyale\target\MXRoyale-0.9.5-SNAPSHOT-swf.swc
set MX_JS=%ROYALE_PATH%\royale-asjs\frameworks\projects\MXRoyale\target\MXRoyale-0.9.5-SNAPSHOT-js.swc

set SPARK_SWC=%ROYALE_PATH%\royale-asjs\frameworks\projects\SparkRoyale\target\SparkRoyale-0.9.5-SNAPSHOT-swf.swc
set SPARK_JS=%ROYALE_PATH%\royale-asjs\frameworks\projects\SparkRoyale\target\SparkRoyale-0.9.5-SNAPSHOT-js.swc

@echo on

%COMPILER_PATH%\mxmlc %MAINCLASS% -external-library-path+=%MX_SWC%,%SPARK_SWC% -js-external-library-path+=%MX_JS%,%SPARK_JS% -source-path=%SRCPATH% -locale+=tr_TR
