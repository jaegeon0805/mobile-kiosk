#!/usr/bin/env bash

SCRIPTS_DIR=$(dirname $(realpath -s $0))
source ${SCRIPTS_DIR}/profile.sh
source ${SCRIPTS_DIR}/switch.sh

IDLE_PORT=$(find_idle_port)

echo ">>> Health Check 시작"
echo ">>> IDLE_PORT: $IDLE_PORT"
echo ">>> curl -s http://localhost:$IDLE_PORT/profile "

for RETRY_COUNT in {1..10}
do
  sleep 10
  echo ">>> Health check ($RETRY_COUNT/10) "
  RESPONSE=$(curl -s http://localhost:${IDLE_PORT}/profile)

  UP_COUNT=$(echo ${RESPONSE} | grep 'deploy' | wc -l)

  if [ ${UP_COUNT} -ge 1 ]; then
    echo ">>> Health check 성공!"
    switch_proxy
    break
  else
    echo ">>> Health check의 응답을 알 수 없거나, 실행 상태가 아닙니다."
    echo ">>> Health check 응답: ${RESPONSE}"
  fi

  if [ ${RETRY_COUNT} -eq 10 ]; then
    echo ">>> Health check 실패.."
    echo ">>> 배포를 종료합니다."
  else
    echo ">>> Health check를 재시도 합니다."
  fi
done
