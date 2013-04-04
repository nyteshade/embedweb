#!/bin/sh

# Build the code
javac \
  -cp src/ \
  -d classes/ \
  src/com/nyteshade/*.java

# Construct the JAR
cd classes
jar -cvf ../embedweb.jar ./*
cd ..
