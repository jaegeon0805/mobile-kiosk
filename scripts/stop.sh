#!/usr/bin/env bash

SCRIPTS_DIR=$(dirname $(realpath -s $0))
source ${SCRIPTS_DIR}/profile.sh

IDLE_PORT=$(find_idle_port)

echo ">>> $IDLE_PORT 를 사용하는 애플리케이션이 있는지 확인을 시작합니다."
IDLE_PID=$(lsof -ti tcp:${IDLE_PORT})

if [ -z ${IDLE_PID} ]; then
  echo ">>> $IDLE_PORT 에서 구동 중인 애플리케이션이 없습니다. 배포 작업을 계속 합니다."
else
  echo ">>> $IDLE_PORT 에서 구동 중인 PID:$IDLE_PID 를 종료합니다."
  kill -15 ${IDLE_PID}
  sleep 5
fi