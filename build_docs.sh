#!/bin/sh

javadoc \
  -private \
  -link http://docs.oracle.com/javase/6/docs/jre/api/net/httpserver/spec/ \
  -link http://docs.oracle.com/javase/6/docs/api/ \
  -sourcepath src \
  -sourcetab 2 \
  -author \
  -version \
  -charset UTF-8 \
  -keywords \
  -d docs \
  com.nyteshade
