#!/bin/bash
#
# Description:
# This script sets certain parameters in /etc/ssh/sshd_config.
# It's not production ready and only used for training purposes.
#
# What should it do?
# * Check whether a /etc/ssh/sshd_config file exists
# * Create a backup of this file
# * Edit the file to set certain parameters
# * Reload the sshd configuration

# To enable debugging mode remove '#' from the following line
#set -x

# Variables
file="$1"
param[1]="PermitRootLogin "
param[2]="PubkeyAuthentication"
param[3]="AuthorizedKeysFile"
param[4]="PasswordAuthentication"

# Functions
usage(){
  cat << EOF

    usage: $0 ARG1

    ARG1  Name of the sshd_config file to edit.
EOF
}
backup_sshd_config(){
  if [ -f ${file} ]
  then
    /usr/bin/cp ${file} ${file}.1
  else
    /usr/bin/echo "File ${file} not found."
    exit 1
  fi
}

edit_sshd_config(){
  for PARAM in ${param[@]}
  do
    /usr/bin/sed -i '/^'"${PARAM}"'/d' ${file}
  done
  /usr/bin/echo "${param[1]} no" >> ${file}
  /usr/bin/echo "${param[2]} yes" >> ${file}
  /usr/bin/echo "${param[3]} .ssh/authorized_keys" >> ${file}
  /usr/bin/echo "${param[4]} no" >> ${file}
}

reload_sshd(){
  /usr/bin/systemctl reload sshd.service
}

# main
if [ -z "${file}" ]
then
  usage
  exit 1
fi
backup_sshd_config
edit_sshd_config
#reload_sshd
