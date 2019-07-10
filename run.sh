#!/bin/bash
echo "Build"
docker build -f Dockerfile . -t flask/test:1
docker-compose start
echo "Test"
# Generate Time
workspace="/var/lib/jenkins/jeter/test/"
TimeNow=$(date --iso-8601=seconds)
echo $TimeNow
# Build Path
jmxPath=""
jmeterPath="/opt/apache-jmeter-5.1.1/"
echo $jmeterPath"lib/ext/cmdrunner-2.2.jar"

# Directory Build Time
mkdir $workspace/

# Run Jmeter
jmeter -Jfilepath=$workspace -JthreadNum=10 -JrampUp=2 -Jcycles=1 -n -t TestPlan.jmx -l $workspace"/result.jtl" -e -o $workspace"/Report"

# Generator Monitor View

java -Djava.awt.headless=true -jar $jmeterPath"lib/ext/cmdrunner-2.0.jar" --tool Reporter --generate-png $workspace"/ResponseTimesOverTime.png" --input-jtl $workspace"/result.jtl" --plugin-type ResponseTimesOverTime
java -Djava.awt.headless=true -jar $jmeterPath"lib/ext/cmdrunner-2.0.jar" --tool Reporter --generate-png $workspace"/resource.png" --input-jtl $workspace"/resource.jtl" --plugin-type PerfMon 

# Move Log
mv jmeter.log $TimeNow
echo "Remove"

docker-compose stop
docker-compose rm -y
docker rmi flask/test:1 -y

exit 0