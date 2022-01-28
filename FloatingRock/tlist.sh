#!/bin/bash

SOCKET=socket

tmux -S ${SOCKET} list-session
