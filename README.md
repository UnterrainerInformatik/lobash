# lobash

A collection of bash-functions I used to use in my projects.
You can source them directly from GitHub if you like.

## Usage

```bash
#!/usr/bin/env bash
source <(curl -s "https://raw.githubusercontent.com/UnterrainerInformatik/lobash/master/lobash.sh")
_set_verbose # or just _set

_col _YELLOW "test2"
# Will print "test2" to std-out in yellow characters.
```



## Function Reference

```bash
# -----------------------------------------------------------------------
# Color constants
# -----------------------------------------------------------------------
_DEFAULT
_BLACK
_RED
_GREEN
_YELLOW
_BLUE
_MAGENTA
_CYAN
_LIGHTGRAY
_DARKGRAY
_LIGHTRED
_LIGHTGREEN
_LIGHTYELLOW
_LIGHTBLUE
_LIGHTMAGENTA
_LIGHTCYAN
_WHITE

# -----------------------------------------------------------------------
# Background-color constants
# -----------------------------------------------------------------------
_BG_DEFAULT
_BG_BLACK
_BG_RED
_BG_GREEN
_BG_YELLOW
_BG_BLUE
_BG_MAGENTA
_BG_CYAN
_BG_LIGHTGRAY
_BG_DARKGRAY
_BG_LIGHTRED
_BG_LIGHTGREEN
_BG_LIGHTYELLOW
_BG_LIGHTBLUE
_BG_LIGHTMAGENTA
_BG_LIGHTCYAN
_BG_WHITE

# -----------------------------------------------------------------------
# Functions
# -----------------------------------------------------------------------

# -----------------------------------------------------------------------
# control
_set
_set_verbose

# -----------------------------------------------------------------------
# echo
#
# Shortcut:
# 	You may use <col> constants instead of <bgcol> constants in any
# 	function. (_col_bg _BLUE _RED "test")
_bold [<string>*]
_italic [<string>*]
_col <col> [<string>*]
_bg <bgcol> [<string>*]
_col_bg <col> <bgcol> [<string>*]
_bg_col <bgcol> <col> [<string>*]
_repeat <n> <string>
_heading <string>
_indent <n> [<string>*]
_now

# -----------------------------------------------------------------------
# logging
_info <string> [<string>*]
_warn <string> [<string>*]
_err <string> [<string>*]
_environment_info

# -----------------------------------------------------------------------
# error handling
_die

# -----------------------------------------------------------------------
# locking
_lock_wait_for [indent] <filename>
_lock_wait [indent]
_lock_or_die_for [indent] <filename>
_lock_or_die [indent]

# -----------------------------------------------------------------------
# checking
_root
_root_or_die
_vars [<varname>*]
_vars_or_die [<varname>*]
_functions [<functionname>*]
_functions_or_die [<functionname>*]
_files [<filename>*]
_files_or_die [<filename>*]
_no_files [<filename>*]
_no_files_or_die [<filename>*]

# utils
_ask_to_continue <message>
_ask_for_password <varname> <message>
_ask_for_password_twice <varname> <message>
_file_replace <search> <replace> <file> [<file>*]
```





# References

- Martin Burger: INI-File Parser
  https://github.com/martinburger/bash-common-helpers/blob/master/bash-common-helpers.sh
- Kevin Porter / Rüdiger Meier: "simple INI file parser"
  https://github.com/rudimeier/bash_ini_parser
