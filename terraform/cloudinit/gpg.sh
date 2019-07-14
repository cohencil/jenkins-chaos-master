#!/usr/bin/env bash

su - ${user} -c "run_keybase"
su - ${user} -c "keybase login --paperkey \"${key}\" --devicename chaos_master_\`date +%s\` shelleg"
