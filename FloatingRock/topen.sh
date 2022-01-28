#!/bin/bash
# Open a file within a shared tmux session

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

SOCKET=socket
TMUX_PID=$(pgrep -u $USER tmux)

if [ ! -S ${SOCKET} ]; then
  if [ ! -z "$TMUX_PID" ]; then
    echo Sending USR1
    pkill -u $USER -USR1 tmux
    exit 0
  else
    tmux -S ${SOCKET} new-session -s init -d "chmod 777 ${SOCKET}; bash"
  fi
else
  if ! tmux -S ${SOCKET} ls &> /dev/null; then
    echo Cleaning up unused socket
    rm ${SOCKET}
    exit 0
  fi
fi

if [ $# -ne 1 ]; then
  echo "Usage: $0 FILE"
  exit 0
fi

# KEY=$(echo $(pwd)/$1 | tr '/' '_')
KEY=$1

if tmux -S ${SOCKET} has-session -t ${KEY} 2> /dev/null; then
  if [ -z "$TMUX" ]; then
    tmux -S ${SOCKET} attach -t ${KEY}
  else
    echo "Already within TMUX"
  fi
else
  tmux -S ${SOCKET} new-session -s $KEY "$EDITOR $1"
fi
