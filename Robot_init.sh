#!/bin/bash

############################################
#  Date:2021/03/31                         #
#  Author:Jack                             #
#                                          #
#  This script is for System init          #
#                                          #
############################################

#Basic configuration

export LANG=en_US.UTF-8
public_key_version="Mr.Robot-V1.0"
hostname(){
    if [ -f "/usr/bin/hostnamectl" ];then
        echo -n "(选填)请输入设置的主机名: "
        stty erase '^H'
        read -r hostname
        if [[ -n "$hostname" ]];then
            if hostnamectl set-hostname "$hostname";then
                echo -e "设置主机名为\033[42;37m$hostname\033[0m"
            fi
        else
            echo -e "未设置主机名"
        fi
    fi
}

jumpserver(){
    if [ ! -d "/root/.ssh" ];then
        mkdir /root/.ssh
    fi
    if [ ! -f "/root/.ssh/authorized_keys" ];then
        touch /root/.ssh/authorized_keys
        chmod 600 /root/.ssh/authorized_keys
    fi
    if [ "$(grep -c "$public_key_version" /root/.ssh/authorized_keys)" -eq '0' ];then
        echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDd4+PFsvHdhFVMZndqSBMR0cgXWHl1EHFHyQks+codlVCT6k+OR1E9L6RSvvhmNlYNTyMD5siWlPcJfUhVBoZc9aeplTOPfqxR+EqrHjaD3CrV1FjS9wZY1TBEYip+/NpDZHOda7BQVtAfCeBx168/AZfdtACgH3DefFlZYtJcju6iA6SCiF48M1qtGVNurfVyLD11UTxzYkMaoC2Aafy8y7kFDIsouAopQRAEtJCt7KLhtGWvMXW4HoLnt48EGC4GKFkRwLS6vGyKwUPbwqH4KST7T2298ghOrpfsDbMjK2do+v0kI1dBS7btHThvLm9N1Bs82hp+4aM1PlsqQ+Nj Mr.Robot-V1.0" >> /root/.ssh/authorized_keys
        echo -e "\033[42;37mAdd public_key success!\033[0m"
    else
        echo -e "\033[42;37mAlready added public_key!\033[0m"
    fi
}
PS1(){
    if [ "$(grep -c "PS1" /root/.bashrc)" -eq '0' ];then
        echo 'PS1="\[\e[37;40m\][\[\e[32;40m\]\u\[\e[37;40m\]@\h \[\e[36;40m\]\w\[\e[0m\]]\\$ "' >> /root/.bashrc
        source /root/.bashrc
    fi
}

clear() {
    rm -f  Robot_init.sh
}


hostname
jumpserver
PS1
clear
