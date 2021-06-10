#!/bin/bash
# plugin to set "snap" proxy settings for ProxyMan
# privileges has to be set by the process which starts this script


list_proxy() {
    echo
    echo "${bold}snap proxy settings : doesn't support listing yet${normal}"
}

unset_proxy() {
    # ToDo check if it's working
    snap unset system proxy.http
    snap unset system proxy.https
}

set_proxy() {
    local stmt=""
    if [ "$use_auth" = "y" ]; then
        stmt="${username}:${password}@"
    fi

    snap set system proxy.http=""\""http://${stmt}${https_host}:${https_port}/"\"""
    snap set system proxy.https=""\""http://${stmt}${https_host}:${https_port}/"\"""
    echo ""\""https://${stmt}${https_host}:${https_port}"\"""
}


which snap &> /dev/null
if [ "$?" != 0 ]; then
    exit
fi

if [ "$#" = 0 ]; then
    exit
fi

what_to_do=$1
case $what_to_do in
    set) set_proxy
         ;;
    unset) unset_proxy
           ;;
    list) list_proxy
          ;;
    *)
          ;;
esac
