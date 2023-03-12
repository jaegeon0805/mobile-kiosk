#!/usr/bin/env bash

# IDLE 상태인 PROFILE 찾기

function find_idle_profile() {
  RESPONSE_CODE=$(curl -s -o /dev/null -w "%{http_code}" http://localhost/profile)

  # 현재 프로필 찾기
  if [ ${RESPONSE_CODE} -ge 400 ]; then
    CURRENT_PROFILE="deploy2"
  else
    CURRENT_PROFILE=$(curl -s http://localhost/profile)
  fi

  # IDLE 상태인 프로파일 찾기
  if [ "${CURRENT_PROFILE}" == "deploy1" ]; then
    IDLE_PROFILE="deploy2"
  else
    IDLE_PROFILE="deploy1"
  fi

  echo "${IDLE_PROFILE}"
}

function find_idle_port() {
  IDLE_PROFILE=$(find_idle_profile)

  #  IDLE 상태인 port 찾기
  if [ "${IDLE_PROFILE}" == "deploy1" ]; then
    echo "8080"
  else
    echo "8081"
  fi
}