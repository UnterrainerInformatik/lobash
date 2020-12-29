#!/usr/bin/env bash
source lobash.sh
_set

echo --------------------------------
_lock_wait_for test.lockfile
sleep 1

echo --------------------------------
_die "This is the script dying."