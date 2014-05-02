#! /bin/bash
#
# tcpdump_mt.sh
# Copyright (C) 2014 Yuzhong Wen <supermartian@gmail.com>
#
# Distributed under terms of the MIT license.
#

tcpdumpexec="tcpdump"
cpubitmap="f"
dev="eth0"

if [ -f ./tcpdump ]
then
    tcpdumpexec="./tcpdump"
fi

argstr="$@"

set -- `getopt "i:" "$@"`

while [ ! -z "$1" ]
do
  case "$1" in
    -i) dev=$2;;
     *) break;;
  esac

  shift
done

# Set the rps_cpus and then execute the tcpdump
eval "echo $cpubitmap > /sys/class/net/$dev/queues/rx-0/rps_cpus"
eval "$tcpdumpexec $argstr"
