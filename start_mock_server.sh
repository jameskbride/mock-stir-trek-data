#!/bin/bash

java -jar mockserver-netty-3.10.4-jar-with-dependencies.jar -serverPort 1080 &
echo "Waiting for mockserver to launch on 1080..."

while ! nc -z localhost 1080; do
  sleep 0.1 # wait for 1/10 of the second before check again
done

echo "Mockserver launched"

ruby start.rb
