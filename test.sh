#!/usr/bin/env bash
source lobash.sh
_set_verbose

echo --------------------------------
_col_bg _GREEN _BG_MAGENTA "test"
_col _YELLOW "test2"

echo --------------------------------
_heading "test"

echo --------------------------------
_lock_wait_for test.lockfile

echo --------------------------------
_indent 0 "zero"
_indent 1 "one" "more"
_indent 2 "two"

echo --------------------------------
echo "test1" "test2"
_col _LIGHTBLUE "test1" "test2"
_bg _BG_DARKGRAY "test1" "test2"
_bg _BLUE "another test without BG"
_col_bg _LIGHTBLUE _BG_RED "test1" "test2"
echo --------------------------------

if _no_files "/mnt/test"; then
    echo OK!
else
    echo ERROR!
fi

if _files "/mnt/test"; then
    echo ERROR!
else
    echo OK!
fi

function test () {
    return 0
}

_functions_or_die "test" "echo"

_environment_info

_ask_for_password_twice "pwd" "please enter a password"
echo password was: $pwd

_ask_to_continue "are you sure to continue?"
