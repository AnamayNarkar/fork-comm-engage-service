#!/usr/bin/env bash
# Generated files: start-comm-engage.sh
set -e

START_COMM_ENGAGE=./start-comm-engage.sh
SERVICE=comm-engage.service

create_dirs() {
    if [[ ! -e /var/log/comm-engage ]]; then
        mkdir /var/log/comm-engage
    fi
}

create_dirs

echo -n "QRD_AUTH_TOKEN="
read -s QRD_AUTH_TOKEN
echo

echo -n "MAPMYINDIA_AUTH_TOKEN="
read -s MAPMYINDIA_AUTH_TOKEN
echo

echo "#!/bin/bash
export QRD_AUTH_TOKEN=${QRD_AUTH_TOKEN}
export MAPMYINDIA_AUTH_TOKEN=${MAPMYINDIA_AUTH_TOKEN}
export COMMENGAGE_QRD_CRON=\"0 0 6 * * ?\"
export QRD_API_BASE_URL=https://pmt.qrd.by
export MAPMYINDIA_API_BASE_URL=https://apis.mapmyindia.com
/usr/lib/jvm/java-17-openjdk-amd64/bin/java --enable-preview -jar server-0.0.1-SNAPSHOT.jar" > ${START_COMM_ENGAGE}
chmod 755 ${START_COMM_ENGAGE}
echo "Generated ${START_COMM_ENGAGE} ..."

cp ./comm-engage.service /etc/systemd/system/
echo "Created /etc/systemd/system/comm-engage.service ..."

echo "systemctl daemon-reload ..."
systemctl daemon-reload
systemctl enable comm-engage.service
