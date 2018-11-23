@echo off
rem set MX_SWC=%ROYALE_PATH%\royale-asjs\frameworks\projects\MXRoyale\target\MXRoyale-0.9.5-SNAPSHOT-swf.swc
rem set MX_JS=%ROYALE_PATH%\royale-asjs\frameworks\projects\MXRoyale\target\MXRoyale-0.9.5-SNAPSHOT-js.swc
REM set EXTLIBS=D:\dev\royale-emulation-works\github\fiber-lib\fiber-lib.swc
REM set EXTLIBS=D:\dev\royale-emulation-works\github\module-testing\module-testing-lib.swc
rem .\libs\as3corelib.swc,.\libs\fiber-lib.swc,.\libs\serializers-lib.swc,.\libs\flexlib.swc,.\libs\libravis.swc
rem set SPARK_SWC=%ROYALE_PATH%\royale-asjs\frameworks\projects\SparkRoyale\target\SparkRoyale-0.9.5-SNAPSHOT-swf.swc
rem set SPARK_JS=%ROYALE_PATH%\royale-asjs\frameworks\projects\SparkRoyale\target\SparkRoyale-0.9.5-SNAPSHOT-js.swc
rem %COMPILER_PATH%\mxmlc %MAINCLASS% -compiler.namespaces.namespace %COMPILER_NS% -external-library-path+=%MX_SWC%,%SPARK_SWC% -js-external-library-path+=%MX_JS%,%SPARK_JS% -source-path=%SRCPATH% -locale+=tr_TR
rem set MAINCLASS=%PRJHOME%\src\main\PinaraUI.mxml


set ROYALE_PATH=D:\dev\royale-emulation-works\apache-royale-0.9.5-bin-js-swf
set COMPILER_PATH=%ROYALE_PATH%\royale-asjs\js\bin
set PRJHOME=D:\dev\royale-emulation-works\github\royale-testing
set SRCPATH=%PRJHOME%\src\*
REM set MAINCLASS=%PRJHOME%\src\main\Main.mxml
set MAINCLASS=%PRJHOME%\src\main\ParserBug.mxml


set GITREPO=D:\dev\royale-emulation-works\github\royale-asjs\frameworks\projects
set MX_SWC=%GITREPO%\MXRoyale\target\MXRoyale-0.9.5-SNAPSHOT-swf.swc
set MX_JS=%GITREPO%\MXRoyale\target\MXRoyale-0.9.5-SNAPSHOT-js.swc
set SPARK_SWC=%GITREPO%\SparkRoyale\target\SparkRoyale-0.9.5-SNAPSHOT-swf.swc
set SPARK_JS=%GITREPO%\SparkRoyale\target\SparkRoyale-0.9.5-SNAPSHOT-js.swc

set SPARK_MF=%GITREPO%\SparkRoyale\src\main\resources\spark-royale-manifest.xml
set MX_MF=%GITREPO%\MXRoyale\src\main\resources\mx-royale-manifest.xml
set MXML_MF=%GITREPO%\..\mxml-2009-manifest.xml

set EXTLIBS=

set COMPILER_NS=library://ns.apache.org/royale/mx %MX_MF% library://ns.apache.org/royale/spark %SPARK_MF% http://ns.adobe.com/mxml/2009 %MXML_MF%


@echo on
set JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF-8 -Duser.country=EN -Duser.language=en
%COMPILER_PATH%\mxmlc %MAINCLASS% -compiler.namespaces.namespace %COMPILER_NS% -library-path+=%MX_SWC%,%SPARK_SWC%,%EXTLIBS% -js-library-path+=%MX_JS%,%SPARK_JS%,%EXTLIBS% -source-path=%SRCPATH% -locale+=tr_TR
