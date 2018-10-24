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

set SPARK_MF=%ROYALE_PATH%\royale-asjs\frameworks\projects\SparkRoyale\src\main\resources\spark-royale-manifest.xml
set MX_MF=%ROYALE_PATH%\royale-asjs\frameworks\projects\MXRoyale\src\main\resources\mx-royale-manifest.xml
set MXML_MF=%ROYALE_PATH%\royale-asjs\frameworks\mxml-2009-manifest.xml

set COMPILER_NS=library://ns.apache.org/royale/mx %MX_MF% library://ns.apache.org/royale/spark %SPARK_MF% http://ns.adobe.com/mxml/2009 %MXML_MF%

@echo on

%COMPILER_PATH%\mxmlc %MAINCLASS% -compiler.namespaces.namespace %COMPILER_NS% -external-library-path+=%MX_SWC%,%SPARK_SWC% -js-external-library-path+=%MX_JS%,%SPARK_JS% -source-path=%SRCPATH% -locale+=tr_TR
