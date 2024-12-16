#!/usr/bin/env bash

set -euxo pipefail

source /etc/os-release
[[ -n ${UBUNTU_CODENAME:-} ]] || {
  echo "Unable to determine Ubuntu version" >&2
  exit 1
}

case ${UBUNTU_CODENAME} in 
  jammy|focal|bionic)
    UBUNTU_LTS=${UBUNTU_CODENAME}
    ;;
  lunar|kinetic|mantic)
    UBUNTU_LTS=jammy
    ;;
  impish|hirsute|groovy)
    UBUNTU_LTS=focal
    ;;
  eoan|disco|cosmic)
    UBUNTU_LTS=bionic
    ;;
  *)
    echo "WARN: Ubuntu version: ${UBUNTU_CODENAME} not recognized, assuming latest" >&2
    UBUNTU_LTS=jammy
    ;;
esac

curl https://netfoundry.jfrog.io/artifactory/api/security/keypair/public/repositories/netfoundry-cloud-deb-stable | sudo gpg --dearmor --output /usr/share/keyrings/netfoundry-cloud.gpg
sudo chmod a+r /usr/share/keyrings/netfoundry-cloud.gpg

echo "deb [signed-by=/usr/share/keyrings/netfoundry-cloud.gpg] https://netfoundry.jfrog.io/artifactory/netfoundry-cloud-deb-stable ${UBUNTU_LTS} main" \
  | sudo tee /etc/apt/sources.list.d/zfw.list >/dev/null

sudo apt-get update

sudo apt-get install --yes zfw-zet
