#!/usr/bin/env bash

# Source of all colors:
# https://github.com/martinburger/bash-common-helpers/blob/master/bash-common-helpers.sh

_colorCode () {
    echo "\033[$1m"
}

readonly _CLEAR=$(_colorCode 0)
readonly _I=$(_colorCode 7)
readonly _I_END=$(_colorCode 27)
readonly _B=$(_colorCode 1)
readonly _B_END=$(_colorCode 22)

# ---------------------------------------------------------------------------------------
# Colors
# ---------------------------------------------------------------------------------------
readonly _DEFAULT=$(_colorCode 39)

readonly _BLACK=$(_colorCode 30)
readonly _RED=$(_colorCode 31)
readonly _GREEN=$(_colorCode 32)
readonly _YELLOW=$(_colorCode 33)
readonly _BLUE=$(_colorCode 34)
readonly _MAGENTA=$(_colorCode 35)
readonly _CYAN=$(_colorCode 36)
readonly _LIGHTGRAY=$(_colorCode 37)
readonly _DARKGRAY=$(_colorCode 90)
readonly _LIGHTRED=$(_colorCode 91)
readonly _LIGHTGREEN=$(_colorCode 92)
readonly _LIGHTYELLOW=$(_colorCode 93)
readonly _LIGHTBLUE=$(_colorCode 94)
readonly _LIGHTMAGENTA=$(_colorCode 95)
readonly _LIGHTCYAN=$(_colorCode 96)
readonly _WHITE=$(_colorCode 97)

# ---------------------------------------------------------------------------------------
# Background-colors
# ---------------------------------------------------------------------------------------
readonly _BG_DEFAULT=$(_colorCode 49)

readonly _BG_BLACK=$(_colorCode 40)
readonly _BG_RED=$(_colorCode 41)
readonly _BG_GREEN=$(_colorCode 42)
readonly _BG_YELLOW=$(_colorCode 43)
readonly _BG_BLUE=$(_colorCode 44)
readonly _BG_MAGENTA=$(_colorCode 45)
readonly _BG_CYAN=$(_colorCode 46)
readonly _BG_LIGHTGRAY=$(_colorCode 47)
readonly _BG_DARKGRAY=$(_colorCode 100)
readonly _BG_LIGHTRED=$(_colorCode 101)
readonly _BG_LIGHTGREEN=$(_colorCode 102)
readonly _BG_LIGHTYELLOW=$(_colorCode 103)
readonly _BG_LIGHTBLUE=$(_colorCode 104)
readonly _BG_LIGHTMAGENTA=$(_colorCode 105)
readonly _BG_LIGHTCYAN=$(_colorCode 106)
readonly _BG_WHITE=$(_colorCode 107)


# ---------------------------------------------------------------------------------------
# Writes the given messages in bold letters to standard out.
#
# Example:
#   _bold "something"
# ---------------------------------------------------------------------------------------
_bold () {
  echo -e "${_B}$@${_B_END}"
}

# ---------------------------------------------------------------------------------------
# Formats the given string in italic letters and writes it to standard-out.
#
# Example:
#   _italic "something"
# ---------------------------------------------------------------------------------------
_italic () {
  echo -e "${_I}$@${_I_END}"
}

# ---------------------------------------------------------------------------------------
# Formats the given string using the given color and writes it to the standard-out.
#
# Example:
#   _col "test" _GREEN
# or
#   _col "test3"
# which will just echo "test3" but (re)set the color to the default values.
# ---------------------------------------------------------------------------------------
_col () {
  if [ $# -lt 1 ]; then
    echo "Usage: ${FUNCNAME[0]} <col_const> [<string>*]" >&2
    exit 1
  fi
  local c=${1}
  shift
  echo -e "${!c}$@${_DEFAULT}"
}

# ---------------------------------------------------------------------------------------
# Formats the given string using the given background-color and writes it to standard-out.
#
# Example:
#   _bg "test" _BG_PURPLE
# or
#   _bg "test2" _YELLOW
# which will use (and set) the default background-color
# or
#   _bg "test3"
# which will just echo "test3" but (re)set the background-color to the default values.
# ---------------------------------------------------------------------------------------
_bg () {
  if [ $# -lt 1 ]; then
    echo "Usage: ${FUNCNAME[0]} <col_const> [<string>*]" >&2
    exit 1
  fi
  local c=${1}
  shift
  if [[ $c != "_BG_"* ]]; then
    c="_BG${c}"
  fi
  echo -e "${!c}$@${_BG_DEFAULT}"
}

# ---------------------------------------------------------------------------------------
# Formats the given string using the given color and background-color and writes it to
# standard-out.
#
# Example:
#   _col_bg "test" _GREEN _BG_PURPLE
# or
#   _col_bg "test3"
# which will just echo "test3" but (re)set the color and background-color to the default
# values.
# ---------------------------------------------------------------------------------------
_col_bg () {
  if [ $# -lt 2 ]; then
    echo "Usage: ${FUNCNAME[0]} <col_const> <col_const> [<string>*]" >&2
    exit 1
  fi
  local c=${1}
  shift
  local bg=${1}
  shift
  if [[ $bg != "_BG_"* ]]; then
    bg="_BG${bg}"
  fi
  echo -e "${!c}${!bg}$@${_DEFAULT}${_BG_DEFAULT}"
}

# ---------------------------------------------------------------------------------------
# Same as _col_bg but the other way round.
# ---------------------------------------------------------------------------------------
_bg_col () {
  if [ $# -lt 2 ]; then
    echo "Usage: ${FUNCNAME[0]} <col_const> <col_const> [<string>*]" >&2
    exit 1
  fi
  local bg=${1}
  shift
  if [[ $bg != "_BG_"* ]]; then
    bg="_BG${bg}"
  fi
  local c=${1}
  shift
  echo -e "${!c}${!bg}$@${_DEFAULT}${_BG_DEFAULT}"
}

# ---------------------------------------------------------------------------------------
# Repeats the given character x-times to standard-out.
#
# Example:
#   _repeat "+" 5
# will output
#   +++++
# ---------------------------------------------------------------------------------------
_repeat () {
  local s=$1
  local n=$2
  if [ $n -eq 0 ]; then
    echo "" && exit 0
  fi
  r=$(printf "%-${n}s" "${s}")
  echo "${r// /${s}}"
}

# ---------------------------------------------------------------------------------------
# Formats the given string as a heading and writes it to standard-out.
#
# Example:
#   _heading "something"
#
# will output (with colors):
#   #############
#   # something #
#   #############
# ---------------------------------------------------------------------------------------
_heading () {
  if [ $# -lt 1 ]; then
    echo "Usage: ${FUNCNAME[0]} <string>" >&2
    exit 1
  fi
  local s=${1}
  local l=${#s}
  local ll=$((l+4))
  r=$(_repeat "#" $ll)
  _col _LIGHTCYAN $r
  _col _LIGHTCYAN "# $1 #"
  _col _LIGHTCYAN $r
}

# ---------------------------------------------------------------------------------------
# Formats the given string in light-cyan letters along with indentation for a certain
# level and writes it to standard-out.
#
# Example:
#   _indent 0 "base" "some more text"
#   _indent 1 "first indent" "some more text" "even more text"
#   _indent 2 "second indent"
# ---------------------------------------------------------------------------------------
_indent () {
  local l=$1
  shift
  local r=$(_repeat " " $(($l*2)))
  _col _LIGHTCYAN "$r$@"
}

# ---------------------------------------------------------------------------------------
# Formats the string in green letters and writes it to standard-out.
#
# Example:
#   _info "some information"
# ---------------------------------------------------------------------------------------
_info () {
  _col _GREEN "$@"
}


# ---------------------------------------------------------------------------------------
# Formats the string in yellow letters and writes it to standard-out.
#
# Example:
#   _warn "some warning"
# ---------------------------------------------------------------------------------------
_warn () {
  _col _YELLOW "$@"
}


# ---------------------------------------------------------------------------------------
# Formats the string in red letters and writes it to standard-out.
#
# Example:
#   _err "some error occurred"
# ---------------------------------------------------------------------------------------
_err () {
  _col _RED "$@"
}

# ---------------------------------------------------------------------------------------
# Formats the string in white letters and red background and writes it to standard-out.
#
# Example:
#   _fatal "some error occurred"
# ---------------------------------------------------------------------------------------
_fatal () {
  _col_bg _WHITE _RED "$@"
}

# ---------------------------------------------------------------------------------------
# Writes the given string as an error message to standard-out and immediately exits the
# script.
#
# Example:
#   _die "severe error."
# ---------------------------------------------------------------------------------------
_die () {
  _fatal "$@"
  exit 1
}

# ---------------------------------------------------------------------------------------
# Formats the current date and time in ISO8601 format and writes it to standard-out.
#
# Example:
#   _now (outputs: 2020-12-29T14:32:55)
# ---------------------------------------------------------------------------------------
_now () {
  d=`date '+%Y-%m-%dT%H:%M:%S'`
  echo "$d"
}

# ---------------------------------------------------------------------------------------
# Waits for a lock on the given file which will be generated in the /tmp directory.
# Writes the pid of the last process holding the lock into the lock-file so you can
# identify that process later on.
#
# Example:
#   _lock_wait_for lockfilename
# or
#   _lock_wait_for 3 lockfile (uses _indent 3 for log-outputs)
#       Generates the file /tmp/lockfile if not already present and uses flock on that file
#       effectively waiting and polling for the lock. Polling interval is 3 seconds.
# ---------------------------------------------------------------------------------------
_lock_wait_for () {
  if [ $# -gt 2 -o $# -lt 1 ]; then
    echo "Usage: ${FUNCNAME[0]} [<indent-level>] <lockFileName>" >&2
    exit 1
  fi

  local indent=0
  if [ $# -ne 1 ]; then
    indent=$1
    shift 1
  fi
  local f=$1

  _indent $indent "obtaining lock..."

  exec 300>/tmp/${f}
  set +e

  flock -n 300
  RC=$?
  while [[ $RC -ne 0 ]]
  do
    _indent $(($indent+1)) "  trying to lock [/tmp/$f] (retrying in 3s)"
    sleep 3

    flock -n 300
    RC=$?
  done

  local pid=$$
  echo $pid 1>&300
  set -e

  _indent $indent "lock obtained."
}

# ---------------------------------------------------------------------------------------
# Same as _lock_wait_for, but uses the basename of the called script as the name of the
# lockfile.
#
# Example:
#   _lock_wait
# Uses basename of $0 as lockfile-name
# or
#   _lock_wait 3
# (uses _indent 3 for log-outputs)
# ---------------------------------------------------------------------------------------
_lock_wait () {
  if [ $# -gt 1 ]; then
    echo "Usage: ${FUNCNAME[0]} [<indent-level>]" >&2
    exit 1
  fi
	
  local indent=${1:-0}
  _lock_wait_for $indent $(basename $0)
}

# ---------------------------------------------------------------------------------------
# Same as _lock_wait_for, but exits with error if the lock couldn't be obtained.
#
# Example:
#   _lock_or_die_for lockfile
# or
#   _lock_or_die_for 3 lockfile (uses _indent 3 for log-outputs)
# ---------------------------------------------------------------------------------------
_lock_or_die_for () {
  if [ $# -gt 2 -o $# -lt 1 ]; then
    echo "Usage: ${FUNCNAME[0]} [<indent-level>] <lockFileName>" >&2
    exit 1
  fi
	
  local indent=0
  if [ $# -ne 1 ]; then
    indent=$1
    shift 1
  fi
  local file=$1

  _indent $indent "obtaining lock..."

  exec 300>/tmp/${file}
  set +e

  flock -n 300 || _die "the lock couldn't be obtained."

  local pid=$$
  echo $pid 1>&300
  set -e

  _indent $indent "lock obtained."
}

# ---------------------------------------------------------------------------------------
# Same as _lock_or_die_for, but uses the basename of the called script as the name of the
# lockfile.
#
# Example:
#   _lock_or_die
# Uses basename of $0 as lockfile-name
# or
#   _lock_or_die 3
# (uses _indent 3 for log-outputs)
# ---------------------------------------------------------------------------------------
_lock_or_die () {
  if [ $# -gt 1 ]; then
    echo "Usage: ${FUNCNAME[0]} [<indent-level>]" >&2
    exit 1
  fi
	
  local indent=${1:-0}
  _lock_or_die_for $indent $(basename $0)
}

# ---------------------------------------------------------------------------------------
# Returns 0 if the script is run by root, 1 otherwise.
#
# Example:
#   _root
# ---------------------------------------------------------------------------------------
_root () {
  if [[ ${EUID} -ne 0 ]]; then
    return 1
  fi
  return 0
}

# ---------------------------------------------------------------------------------------
# Ensure that the script is run by root.
#
# Example:
#   _root_or_die
# ---------------------------------------------------------------------------------------
_root_or_die () {
  if [[ ${EUID} -ne 0 ]]; then
    _die "You have to be root to run this script!"
  fi
}

# ---------------------------------------------------------------------------------------
# Test if the given variable is set. Variables are given by name.
#
# Example:
#   _vars "var1" "var2" "var3"
# ---------------------------------------------------------------------------------------
_vars () {
  for v in ${@}; do
    if [[ -z "${!v-}" ]]; then
      return 1
    fi
  done

  return 0
}

# ---------------------------------------------------------------------------------------
# Ensures that the given variables are set. Variables are given by name.
#
# Example:
#   _vars_or_die "var1" "var2" "var3"
# ---------------------------------------------------------------------------------------
_vars_or_die () {
  for v in ${@}; do
    if [[ -z "${!v-}" ]]; then
      _die "The var '${v}' has to be set to run this script!"
    fi
  done

  return 0
}

# ---------------------------------------------------------------------------------------
# Returns 0 of the given function is available, 1 otherwise.
#
# Example:
#   _functions "dig" "someother"
# ---------------------------------------------------------------------------------------
_functions () {
  for v in ${@}; do
    type ${v} >/dev/null 2>&1 || return 1
  done
  return 0
}

# ---------------------------------------------------------------------------------------
# Ensures that the given function is available.
#
# Example:
#   _functions_or_die "dig" "someother"
# ---------------------------------------------------------------------------------------
_functions_or_die () {
  for v in ${@}; do
    type ${v} >/dev/null 2>&1 || _die "The function '${v}' has to be available to run this script!"
  done
}

# ---------------------------------------------------------------------------------------
# Returns 0 if the given directory exists, 1 otherwise.
#
# Example:
#   _dirs "somedir" "someother"
# ---------------------------------------------------------------------------------------
_dirs () {
  for v in ${@}; do
    if [[ ! -d "${v}" ]]; then
      return 1
    fi
  done
  return 0
}

# ---------------------------------------------------------------------------------------
# Ensure that the given directory exists.
#
# Example:
#   _dirs_or_die "somedir" "someother"
# ---------------------------------------------------------------------------------------
_dirs_or_die () {
  for v in ${@}; do
    if [[ ! -d "${v}" ]]; then
      _die "The directory '${v}' has to exist to run this script!"
    fi
  done
}

# ---------------------------------------------------------------------------------------
# Returns 0 if the given file exists, 1 otherwise.
# Cannot be a directory or device.
#
# Example:
#   _files "somefile" "someother"
# ---------------------------------------------------------------------------------------
_files () {
  for v in ${@}; do
    if [[ ! -f "${v}" ]]; then
      return 1
    fi
  done
  return 0
}

# ---------------------------------------------------------------------------------------
# Ensure that the given file exists.
# Cannot be a directory or device.
#
# Example:
#   _files_or_die "somefile" "someother"
# ---------------------------------------------------------------------------------------
_files_or_die () {
  for v in ${@}; do
    if [[ ! -f "${v}" ]]; then
      _die "The file '${v}' has to exist to run this script!"
    fi
  done
}

# ---------------------------------------------------------------------------------------
# Returns 0 if the given files don't exist, 1 otherwise.
#
# Example:
#   _no_files "filename" "someother"
# ---------------------------------------------------------------------------------------
_no_files () {
  for v in ${@}; do
    if [[ -e "${v}" ]]; then
      return 1
    fi
  done
  return 0
}

# ---------------------------------------------------------------------------------------
# Ensure that the given file does not exist.
#
# Example:
#   _no_files_or_die "filename" "someother"
# ---------------------------------------------------------------------------------------
_no_files_or_die () {
  for v in ${@}; do
    if [[ -e "${v}" ]]; then
      _die "The file '${v}' cannot exist in order to run this project!"
    fi
  done
}

# ---------------------------------------------------------------------------------------
# Writes a message to standard-out, consisting of the name of current machine, user, 
# the IP the caller came from (if connected via SSH) and the IP the script is currently
# running on.
#
# Example:
#   _environment_info ()
# ---------------------------------------------------------------------------------------
_environment_info () {
  if _vars "SSH_CONNECTION"; then
    controller=$(echo $SSH_CONNECTION | awk '{print $1}')
    target=$(echo $SSH_CONNECTION | awk '{print $3}')
      _info "$(_now) $(whoami)@$HOSTNAME($target) from $controller"
  else
    _info "$(_now) $(whoami)@$HOSTNAME"
  fi
}

# ---------------------------------------------------------------------------------------
# Call this as first command after your import.
#
# Example:
#   _set
# ---------------------------------------------------------------------------------------
_set () {
  # exit on uninitialised variable
  set -o nounset
  # exit on command failure
  set -o errexit
}

# ---------------------------------------------------------------------------------------
# Call this as first command after your import.
#
# Calls _set and writes the called scripts' name to standard-out.
#
# Example:
#   _set_verbose
# ---------------------------------------------------------------------------------------
_set_verbose () {
  _set
  _heading "$(_now) $(basename $0)"
}

# ---------------------------------------------------------------------------------------
# Asks the user - using the given message - to either hit 'y/Y' to continue or
# 'n/N' to cancel the script.
#
# Example:
# cmn_ask_to_continue "Do you want to delete the given file?"
#
# On yes (y/Y), the function just returns; on no (n/N), it prints a confirmative
# message to the screen and exits with return code 1 by calling `_die`.
# ---------------------------------------------------------------------------------------
_ask_to_continue () {
  if [ $# != 1 ]; then
    echo "Usage: ${FUNCNAME[0]} <message>" >&2
    exit 1
  fi

  local msg=${1}
  local waiting=true
  while ${waiting}; do
    read -p "${msg} (hit 'y/Y' to continue, 'n/N' to cancel) " -n 1 ynanswer
    case ${ynanswer} in
      [Yy] ) waiting=false; break;;
      [Nn] ) echo ""; _die "Operation cancelled by user!";;
      *    ) echo ""; echo "Please answer either yes (y/Y) or no (n/N).";;
    esac
  done
  echo ""
}

# ---------------------------------------------------------------------------------------
# Asks the user for her password and stores the password in a read-only
# variable with the given name.
#
# The user is asked with the given message prompt. Note that the given prompt
# will be complemented with string ": ".
#
# This function does not echo nor completely hides the input but echos the
# asterisk symbol ('*') for each given character. Furthermore, it allows to
# delete any number of entered characters by hitting the backspace key. The
# input is concluded by hitting the enter key.
#
# Example:
#   _ask_for_password "THEPWD" "Please enter your password"
#
# See: http://stackoverflow.com/a/24600839/66981
# ---------------------------------------------------------------------------------------
_ask_for_password () {
  if [ $# -lt 1 -o $# -gt 2 ]; then
    echo "Usage: ${FUNCNAME[0]} <varname> <message>" >&2
    exit 1
  fi

  local VARIABLE_NAME=${1}
  local MESSAGE=${2}

  echo -n "${MESSAGE}: "
  stty -echo
  local CHARCOUNT=0
  local PROMPT=''
  local CHAR=''
  local PASSWORD=''
  while IFS= read -p "${PROMPT}" -r -s -n 1 CHAR
  do
    # Enter -> accept password
    if [[ ${CHAR} == $'\0' ]] ; then
      break
    fi
    # Backspace -> delete last char
    if [[ ${CHAR} == $'\177' ]] ; then
      if [ ${CHARCOUNT} -gt 0 ] ; then
        CHARCOUNT=$((CHARCOUNT-1))
        PROMPT=$'\b \b'
        PASSWORD="${PASSWORD%?}"
      else
        PROMPT=''
      fi
    # All other cases -> read last char
    else
      CHARCOUNT=$((CHARCOUNT+1))
      PROMPT='*'
      PASSWORD+="${CHAR}"
    fi
  done
  stty echo
  readonly ${VARIABLE_NAME}=${PASSWORD}
  echo
}

# ---------------------------------------------------------------------------------------
# Asks the user for her password twice. If the two inputs match, the given
# password will be stored in a read-only variable with the given name;
# otherwise, it exits with return code 1 by calling `cmn_die`.
#
# The user is asked with the given message prompt. Note that the given prompt
# will be complemented with string ": " at the first time and with
# " (again): " at the second time.
#
# This function basically calls `cmn_ask_for_password` twice and compares the
# two given passwords. If they match, the password will be stored; otherwise,
# the functions exits by calling `cmn_die`.
#
# Example:
#   _ask_for_password_twice "THEPWD" "Please enter your password"
# ---------------------------------------------------------------------------------------
_ask_for_password_twice () {
  if [ $# -lt 1 -o $# -gt 2 ]; then
    echo "Usage: ${FUNCNAME[0]} <varname> <message>" >&2
    exit 1
  fi

  local VARIABLE_NAME=${1}
  local MESSAGE=${2}
  local VARIABLE_NAME_1="${VARIABLE_NAME}_1"
  local VARIABLE_NAME_2="${VARIABLE_NAME}_2"

  _ask_for_password "${VARIABLE_NAME_1}" "${MESSAGE}"
  _ask_for_password "${VARIABLE_NAME_2}" "${MESSAGE} (again)"

  if [ "${!VARIABLE_NAME_1}" != "${!VARIABLE_NAME_2}" ] ; then
    _die "Error: password mismatch"
  fi

  readonly ${VARIABLE_NAME}="${!VARIABLE_NAME_2}"
}

# ---------------------------------------------------------------------------------------
# Replaces given string 'search' with 'replace' in given files.
#
# Important: The replacement is done in-place. Thus, it overwrites the given
# files, and no backup files are created.
#
# Note that this function is intended to be used to replace fixed strings; i.e.,
# it does not interpret regular expressions. It was written to replace simple
# placeholders in sample configuration files (you could say very poor man's
# templating engine).
#
# This functions expects given string 'search' to be found in all the files;
# thus, it expects to replace that string in all files. If a given file misses
# that string, a warning is issued by calling `cmn_echo_warn`. Furthermore,
# if a given file does not exist, a warning is issued as well.
#
# To replace the string, perl is used. Pattern metacharacters are quoted
# (disabled). The search is a global one; thus, all matches are replaced, and
# not just the first one.
#
# Example:
#   _replace_in_files placeholder replacement file1.txt file2.txt
# ---------------------------------------------------------------------------------------
_file_replace () {
  if [ $# -lt 1 -o $# -gt 2 ]; then
    echo "Usage: ${FUNCNAME[0]} <search> <replace> <file> [<file>...]" >&2
    exit 1
  fi

  local search=${1}
  local replace=${2}
  local files=${@:3}

  for file in ${files[@]}; do
    if [[ -e "${file}" ]]; then
      if ( grep --fixed-strings --quiet "${search}" "${file}" ); then
        perl -pi -e "s/\Q${search}/${replace}/g" "${file}"
      else
        _warn "Could not find search string '${search}' (thus, cannot replace with '${replace}') in file: ${file}"
      fi
    else
        _warn "File '${file}' does not exist (thus, cannot replace '${search}' with '${replace}')."
    fi
  done

}
