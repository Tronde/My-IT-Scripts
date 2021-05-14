#!/bin/sh
# Author: Joerg Kastning <joerg (dot) kastning (at) my-it-brain (dot) de>
# License: MIT
# Description: Wrapper Script to clone and sysprep a KVM guest template

# variables
TEMPLATE_NAME=${1}
GUEST_NAME=${2}

# functions
usage(){
  cat << EOF
    Wrapper Script to clone and sysprep a KVM guest template

    usage: $0 ARG1 ARG2

    ARG1  Name of the template to clone
    ARG2  Name of the new kvm guest domain to create 
EOF
}

clone(){
  virt-clone --original "${TEMPLATE_NAME}" --name "${GUEST_NAME}" --auto-clone
}

sysprep(){
  virt-sysprep --operations -ssh-userdir --hostname "${GUEST_NAME}" -d "${GUEST_NAME}"
}

# main
clone
sysprep
