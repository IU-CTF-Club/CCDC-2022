#!/bin/bash

SOCKET=socket

if type fzf &> /dev/null; then

  session=$(tmux -S ${SOCKET} list-sessions -F '#{session_name} #{session_windows} #{session_created} #{session_last_attached} #{session_activity}' \
  | xargs -I{} bash -c 'a=( {} ); echo "${a[0]}|${a[1]}|$(date -d @${a[2]})|$(date -d @${a[3]})|$(date -d @${a[4]})"' \
  | sed '1iSession|Windows|Created|Attached|Activity' \
  | column -s '|' -t \
  | fzf --header-lines=1 --reverse | awk '{print $1}');

  [ -z "$session" ] && exit 0
  TERM=xterm-256color tmux -S ${SOCKET} attach -t $session

else
  tmux -S ${SOCKET} list-sessions -F '#{session_name} #{session_windows} #{session_created} #{session_last_attached} #{session_activity}' \
  | xargs -I{} bash -c 'a=( {} ); echo "${a[0]}|${a[1]}|$(date -d @${a[2]})|$(date -d @${a[3]})|$(date -d @${a[4]})"' \
  | sed '1iSession|Windows|Created|Attached|Activity' \
  | column -s '|' -t

  echo
  echo "tmux -S ${SOCKET} attach -t SESSION"
fi
