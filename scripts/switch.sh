#!/usr/bin/env bash

SCRIPTS_DIR=$(dirname $(realpath -s $0))
source ${SCRIPTS_DIR}/profile.sh

function switch_proxy() {
  IDLE_PORT=$(find_idle_port)

  echo ">>> 전환할 Port: $IDLE_PORT"
  echo ">>> 포트 전환 시작"
  echo "set \$service_url http://127.0.0.1:${IDLE_PORT};" | sudo tee /etc/nginx/conf.d/service-url.inc

  echo ">>> nginx Reload 시작"
  sudo service nginx reload
}