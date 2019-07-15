#!/usr/bin/env bash

su - ${user} -c "run_keybase"
su - ${user} -c "keybase login --paperkey \"${paperkey}\" --devicename chaos_master_\`date +%s\` ${keybase_user}"
