#!/usr/bin/env bash

SCRIPTS_DIR=$(dirname $(realpath -s $0))
source ${SCRIPTS_DIR}/profile.sh

DEPLOY_LOG_REPOSITORY=/home/ec2-user/mobile-kiosk/logs
JAR_REPOSITORY=/home/ec2-user/mobile-kiosk/source/build/libs

echo ">>> 애플리케이션 배포 시작"
JAR_NAME=$(ls -tr $JAR_REPOSITORY/*.jar | tail -n 1)
IDLE_PROFILE=$(find_idle_profile)

echo ">>> 실행될 JAR 파일 이름: $JAR_NAME"
echo ">>> $JAR_NAME 을 $IDLE_PROFILE 로 실행합니다."

if [ ! -d ${DEPLOY_LOG_REPOSITORY} ]; then
  echo ">>> $DEPLOY_LOG_REPOSITORY 디렉토리를 생성합니다."
  mkdir ${DEPLOY_LOG_REPOSITORY}
fi

nohup java -Dspring.profiles.active=prod,$IDLE_PROFILE -jar $JAR_NAME \
> $DEPLOY_LOG_REPOSITORY/nohup-$(date +'%Y%m%dT%H%M%S%Z').out 2>&1 &
