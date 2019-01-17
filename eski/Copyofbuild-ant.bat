@echo off

set ROYALE_PATH=D:\dev\royale-emulation-works\apache-royale-0.9.6-bin-js-swf
set COMPILER_PATH=%ROYALE_PATH%\royale-asjs\js\bin
REM set COMPILER_PATH=D:\dev\royale-emulation-works\github\royale-asjs\js\bin

set PRJHOME=.
set SRCPATH=%PRJHOME%\src\*,.\locale\{locale}
set MAINCLASS=%PRJHOME%\src\main\FindBug.mxml


set GITREPO=..\royale-asjs\frameworks\projects

rem set MX_SWC=%GITREPO%\MXRoyale\target\MXRoyale-0.9.6-SNAPSHOT-swf.swc
rem set MX_JS=%GITREPO%\MXRoyale\target\MXRoyale-0.9.6-SNAPSHOT-js.swc
rem set SPARK_SWC=%GITREPO%\SparkRoyale\target\SparkRoyale-0.9.6-SNAPSHOT-swf.swc
rem set SPARK_JS=%GITREPO%\SparkRoyale\target\SparkRoyale-0.9.6-SNAPSHOT-js.swc

rem set ROYALE_ASJS=..\royale-asjs
set ROYALE_ASJS=%ROYALE_PATH%\royale-asjs
set MX_SWC=%ROYALE_ASJS%\frameworks\libs\MXRoyale.swc
set MX_JS=%ROYALE_ASJS%\frameworks\js\libs\MXRoyaleJS.swc
set SPARK_SWC=%ROYALE_ASJS%\frameworks\libs\SparkRoyale.swc
set SPARK_JS=%ROYALE_ASJS%\frameworks\js\libs\SparkRoyaleJS.swc

set SPARK_MF=%GITREPO%\SparkRoyale\src\main\resources\spark-royale-manifest.xml
set MX_MF=%GITREPO%\MXRoyale\src\main\resources\mx-royale-manifest.xml
set MXML_MF=%GITREPO%\..\mxml-2009-manifest.xml

set EXTLIBS=.\libs\as3corelib.swc,.\libs\fiber-lib.swc,.\libs\flexlib.swc,.\libs\serializers-lib.swc

set COMPILER_NS=library://ns.apache.org/royale/mx %MX_MF% library://ns.apache.org/royale/spark %SPARK_MF% http://ns.adobe.com/mxml/2009 %MXML_MF%

@echo on
rmdir /s src\main\bin

set JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF-8 -Duser.country=EN -Duser.language=en
%COMPILER_PATH%\mxmlc %MAINCLASS% -compiler.namespaces.namespace %COMPILER_NS% -library-path+=%MX_SWC%,%SPARK_SWC%,%EXTLIBS% -js-library-path+=%MX_JS%,%SPARK_JS%,%EXTLIBS% -source-path=%SRCPATH% -locale+=tr_TR,en_US
