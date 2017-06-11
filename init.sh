#!/bin/bash

# DON'T run scripts if in an SFTP session, since executing
# these scripts produces terminal output and that breaks the
# SFTP protocol.
if [[ -z "$SSH_TTY" ]]
then
	exit
fi

# initializes environment variables PINS and SLOTS
initEnviroVars.sh

# connects the BBB to the internet
connectInternetOverUSB.sh
