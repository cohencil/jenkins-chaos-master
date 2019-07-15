#!/usr/bin/env bash

su - ${user} -c "run_keybase"
su - ${user} -c "keybase login --paperkey \"${paperkey}\" --devicename "${devicename}"_\`date +%s\` ${keybase_user}"
