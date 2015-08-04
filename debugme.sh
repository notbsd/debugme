#!/bin/bash
#by bsd

if [ `whoami` != root ]; then
  echo "{-} The script is not being run as sudo or root"
  exit 1
fi

if [ ! hash paxctl 2>/dev/null ]; then
  echo "{-} paxctl not found"
  exit 1
fi

if [ $1 == "" ]; then
  echo "{-} Please provide an arguement - debug|reset"
elif [ $1 == "reset" ]; then
  echo "{+} Resetting flags on binary $2"
  paxctl -ze $2
  exit 0
elif [ $1 == "debug" ]; then
  echo "{+} Attempting to enable debugging on binary $2"
else
  echo "{-} Please rerun $0 with a valid argument - debug|reset binary"
  exit 1
fi

if [ -f $2 ]; then
  echo "{+} Binary Located!"
  echo "{?} By running this tool on $1 the binary will no longer have PaX exploit 
mitigations protecting it until you run $0 restore $2"
  echo "{+} Removing RANDEXEC Flag"
  paxctl -m $2
  echo "{+} Removing MPROTECT Flag"
  paxctl -ps $2
else
  echo "{-} Binary not found!"
  exit 1

