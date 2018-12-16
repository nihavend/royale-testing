@echo off

set ROYALE_PATH=D:\dev\royale-emulation-works\apache-royale-0.9.6-bin-js-swf
set COMPILER_PATH=%ROYALE_PATH%\royale-asjs\js\bin
REM set COMPILER_PATH=D:\dev\royale-emulation-works\github\royale-asjs\js\bin

set PRJHOME=.
set SRCPATH=%PRJHOME%\src\*,.\locale\{locale}
set MAINCLASS=%PRJHOME%\src\main\FindBug.mxml


set GITREPO=..\royale-asjs\frameworks\projects
set MX_SWC=%GITREPO%\MXRoyale\target\MXRoyale-0.9.6-SNAPSHOT-swf.swc
set MX_JS=%GITREPO%\MXRoyale\target\MXRoyale-0.9.6-SNAPSHOT-js.swc
set SPARK_SWC=%GITREPO%\SparkRoyale\target\SparkRoyale-0.9.6-SNAPSHOT-swf.swc
set SPARK_JS=%GITREPO%\SparkRoyale\target\SparkRoyale-0.9.6-SNAPSHOT-js.swc

set SPARK_MF=%GITREPO%\SparkRoyale\src\main\resources\spark-royale-manifest.xml
set MX_MF=%GITREPO%\MXRoyale\src\main\resources\mx-royale-manifest.xml
set MXML_MF=%GITREPO%\..\mxml-2009-manifest.xml

set EXTLIBS=

set COMPILER_NS=library://ns.apache.org/royale/mx %MX_MF% library://ns.apache.org/royale/spark %SPARK_MF% http://ns.adobe.com/mxml/2009 %MXML_MF%


@echo on
rmdir /s src\main\bin

set JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF-8 -Duser.country=EN -Duser.language=en
%COMPILER_PATH%\mxmlc %MAINCLASS% -compiler.namespaces.namespace %COMPILER_NS% -library-path+=%MX_SWC%,%SPARK_SWC%,%EXTLIBS% -js-library-path+=%MX_JS%,%SPARK_JS%,%EXTLIBS% -source-path=%SRCPATH% -locale+=tr_TR
