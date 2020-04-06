@echo off

set COMPILER_PATH=..\royale-asjs\js\bin

set ROYALE_HOME=..\royale-asjs
set GITREPO=%ROYALE_HOME%\frameworks\projects

set ROYALE_COMPILER_HOME=%COMPILER_PATH%

set PRJHOME=.
set SRCPATH=%PRJHOME%\src\main\mtest\*,.\locale\{locale}

set MAINCLASS=%PRJHOME%\src\main\mtest\FindBug.mxml


set MX_SWC=%ROYALE_HOME%\frameworks\libs\MXRoyale.swc
set MX_JS=%ROYALE_HOME%\frameworks\js\libs\MXRoyaleJS.swc
set SPARK_SWC=%ROYALE_HOME%\frameworks\libs\SparkRoyale.swc
set SPARK_JS=%ROYALE_HOME%\frameworks\js\libs\SparkRoyaleJS.swc

set SPARK_MF=%GITREPO%\SparkRoyale\src\main\resources\spark-royale-manifest.xml
set MX_MF=%GITREPO%\MXRoyale\src\main\resources\mx-royale-manifest.xml
set MXML_MF=%GITREPO%\..\mxml-2009-manifest.xml

set PNRLIBS=.\libs\as3corelib.swc,.\libs\fiber-lib.swc,.\libs\serializers-lib.swc

set COMPILER_NS=library://ns.apache.org/royale/mx %MX_MF% library://ns.apache.org/royale/spark %SPARK_MF% http://ns.adobe.com/mxml/2009 %MXML_MF%


rmdir /q /s src\main\mtest\bin

set JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF-8 -Duser.country=U -Duser.language=en

@java -Dsun.io.useCanonCaches=false -Xms32m -Xmx1024m -Droyalecompiler="%ROYALE_COMPILER_HOME%" -Droyalelib="%ROYALE_HOME%\frameworks" -jar "..\royale-compiler\compiler-jx\lib\mxmlc.jar"  -sdk-js-lib="%ROYALE_HOME%\frameworks\js\Royale\generated-sources" %MAINCLASS% -js-compiler-option goog.LOCALE='en_US' -closure-lib=D:/dev/royale-emulation-works/closure-library-20180910 -compiler.namespaces.namespace %COMPILER_NS% -library-path+=%PNRLIBS%,%MX_SWC%,%SPARK_SWC% -js-library-path+=%PNRLIBS%,%MX_JS%,%SPARK_JS% -source-path=%SRCPATH% -locale+=tr_TR,en_US

xcopy "D:\dev\royale-emulation-works\github\royale-testing\src\images\*.*"  "D:\dev\royale-emulation-works\github\royale-testing\src\main\mtest\bin\js-debug\images\" /K /D /H /Y /Q
