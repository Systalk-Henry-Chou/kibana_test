#!/bin/bash
# Generate Time
TimeNow=$(date --iso-8601=seconds)
echo $TimeNow

# Build Path
jmxPath=""
jmeterPath="/opt/apache-jmeter-5.1.1/"
echo $jmeterPath"lib/ext/cmdrunner-2.2.jar"

# Directory Build Time
mkdir $TimeNow/

# Run Jmeter
jmeter -Jfilepath=$TimeNow -JthreadNum=10 -JrampUp=2 -Jcycles=1 -n -t TestPlan.jmx -l $TimeNow"/result.jtl" -e -o $TimeNow"/Report"

# Generator Monitor View
echo $TimeNow"/result.jtl"
java -Djava.awt.headless=true -jar $jmeterPath"lib/ext/cmdrunner-2.0.jar" --tool Reporter --generate-png $TimeNow"/ResponseTimesOverTime.png" --input-jtl $TimeNow"/result.jtl" --plugin-type ResponseTimesOverTime
java -Djava.awt.headless=true -jar $jmeterPath"lib/ext/cmdrunner-2.0.jar" --tool Reporter --generate-png $TimeNow"/resource.png" --input-jtl $TimeNow"/resource.jtl" --plugin-type PerfMon 

# Move Log
mv jmeter.log $TimeNow

exit 0