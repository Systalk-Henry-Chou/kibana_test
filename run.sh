@echo off

rem Generate Time
set date=%date:~0,4%%date:~5,2%%date:~8,2%
if "%time:~0,2%" lss "10" (set hour=0%time:~1,1%) else (set hour=%time:~0,2%)
set time=%hour%%time:~3,2%%time:~6,2%
set d=%date%%time%
echo Time Now: %d%

rem Build Path
set jmxPath=""
set jmeterPath=$Jmeter_Home

rem Directory Build Time
mkdir %jmxPath%/%d%

rem Run Jmeter
call jmeter -JfilePath="%jmxPath%/%d%" -JthreadNum=100 -JrampUp=25 -Jcycles=1 -n -t %jmxPath%/TestPlan.jmx -l %jmxPath%/result.jtl -e -o %jmxPath%/%d%/Report

rem Generator Monitor View
call java -jar %jmeterPath%/lib/ext/CMDRunner.jar --tool Reporter --generate-png %jmxPath%/%d%/ResponseTimesOverTime.png --input-jtl %jmxPath%/%d%/result.jtl --plugin-type ResponseTimesOverTime
call java -jar %jmeterPath%/lib/ext/CMDRunner.jar --tool Reporter --generate-png %jmxPath%/%d%/resource.png --input-jtl %jmxPath%/%d%/resource.jtl --plugin-type PerfMon

rem Move Log
move jmeter.log %jmxPath%/%d%

rem pause