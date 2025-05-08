#!/usr/bin/env bash
set -ex

java ${JAVA_AGENTS} ${JVM_ARGS} ${PROJECT_ARGS} -server -jar /usr/software/service/app.jar
