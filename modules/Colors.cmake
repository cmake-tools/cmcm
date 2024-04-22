#
# CMakeCM
# CMake Common Modules.
#
# SPDX-FileCopyrightText: 2024 flagarde
#
# SPDX-License-Identifier: MIT
#

#[=======================================================================[.rst:
Colors
======

This module allows to detect if the terminal support colorization and to create variables with escape sequences to colore outputs.

Functions
^^^^^^^^^

.. command:: check_color_support

.. code-block:: cmake

  check_color_support(URL <url>)

Detect color support of the terminal. This function respect the ``NO_COLOR`` env variable (https://no-color.org/).

``VARIABLE <variable>``
  The variable is set to ``TRUE`` if the terminal support color, else return ``FALSE``
#]=======================================================================]
function(check_color_support)
  # cmake-lint: disable=C0103
  include(CMakeParseArguments)
  cmake_parse_arguments(ARG "" "VARIABLE" "" ${ARGN})
  if(CMAKE_VERSION VERSION_GREATER 3.23.9)
    cmake_host_system_information(RESULT ARG_DEFAULT_VALUE QUERY WINDOWS_REGISTRY "HKCU/Console" VALUE "VirtualTerminalLevel")
  endif()
  if(WIN32 AND NOT ARG_DEFAULT_VALUE)
    set(ARG_VALUE FALSE)
  else()
    set(ARG_VALUE TRUE)
  endif()
  # Check CMakeMM variables
  get_property(ARG_DEFAULT GLOBAL PROPERTY CMMM_NO_COLOR)
  if(DEFINED ENV{CLICOLOR_FORCE} AND NOT "$ENV{CLICOLOR_FORCE}" STREQUAL "0")
    set(ARG_VALUE TRUE)
  elseif(DEFINED ENV{CLICOLOR} AND "$ENV{CLICOLOR}" STREQUAL "0")
    set(ARG_VALUE FALSE)
  elseif(DEFINED ENV{CI} AND NOT CMMM_NO_COLOR)
    set(ARG_VALUE TRUE)
  elseif(DEFINED ENV{DevEnvDir} OR DEFINED ENV{workspaceRoot})
    set(ARG_VALUE FALSE)
  endif()
  set("${ARG_VARIABLE}" "${ARG_VALUE}" PARENT_SCOPE)
  # pass
endfunction()

#[=======================================================================[.rst:
.. command:: colorize

.. code-block:: cmake
  
  colorize()

Create cached color and style variables. If colors are supported in terminal, create CMake cached variables containing style and colors escape sequences.

Some colors can be defined using the environment variable ``CMMM_COLORS`` , the default is (default=0;35:fatal_error=1;31:error=0;31:warn=0;33:info=0;32).

This function respect the ``NO_COLOR`` env variable (https://no-color.org/).

The cached variables are :

``CMCM_DEFAULT_COLOR``
 Color for default emphase.

``CMCM_FATAL_ERROR_COLOR``
  Color for fatal_error.

``CMCM_ERROR_COLOR``
  Color for error.

``CMCM_WARN_COLOR``
  Color for warning.

``CMCM_INFO_COLOR``
  Color for info.

``CMCM_FG_BLACK``
  Foreground black color.

``CMCM_FG_RED``
  Foreground red color.

``CMCM_FG_GREEN``
  Foreground green color.

``CMCM_FG_YELLOW``
  Foreground yellow color.

``CMCM_FG_BLUE``
  Foreground blue color.

``CMCM_FG_MAGENTA``
  Foreground magenta color.

``CMCM_FG_CYAN``
  Foreground cyan color.

``CMCM_FG_WHITE``
  Foreground white color.

``CMCM_FG_BRIGHT_BLACK``
  Foreground bright black color.

``CMCM_FG_BRIGHT_RED``
  Foreground bright red color.

``CMCM_FG_BRIGTH_GREEN``
  Foreground bright green color.

``CMCM_FG_BRIGHT_YELLOW``
  Foreground bright yellow color.

``CMCM_FG_BRIGHT_BLUE``
  Foreground bright blue color.

``CMCM_FG_BRIGHT_MAGENTA``
  Foreground bright magenta color.

``CMCM_FG_BRIGHT_CYAN``
  Foreground bright cyan color.

``CMCM_FG_BRIGHT_WHITE``
  Foreground bright white color.

``CMCM_BG_BLACK``
  Background black color.

``CMCM_BG_RED``
  Background red color.

``CMCM_BG_GREEN``
  Background green color.

``CMCM_BG_YELLOW``
  Background yellow color.

``CMCM_BG_BLUE``
  Background blue color.

``CMCM_BG_MAGENTA``
  Background magenta color.

``CMCM_BG_CYAN``
  Background cyan color.

``CMCM_BG_WHITE``
  Background white color.

``CMCM_BG_BRIGHT_BLACK``
  Background bright black color.

``CMCM_BG_BRIGHT_RED``
  Background bright red color.

``CMCM_BG_BRIGTH_GREEN``
  Background bright green color.

``CMCM_BG_BRIGHT_YELLOW``
  Background bright yellow color.

``CMCM_BG_BRIGHT_BLUE``
  Background bright blue color.

``CMCM_BG_BRIGHT_MAGENTA``
  Background bright magenta color.

``CMCM_BG_BRIGHT_CYAN``
  Background bright cyan color.

``CMCM_BG_BRIGHT_WHITE``
  Background bright white color.

``CMCM_BOLD``
  Bold style.

``CMCM_FAINT``
  Faint style.

``CMCM_ITALIC``
  Italic style.

``CMCM_UNDERLINE``
  Underline style.

``CMCM_BLINK``
  Blink style.

``CMCM_RAPID_BLINK``
  Rapid blink style.

``CMCM_INVERT``
  Invert style.

``CMCM_CONCEAL``
  Conceal style.

``CMCM_CROSSOUT``
  Crossout style.

``CMCM_UNBOLD``
  Disable bold style.

``CMCM_UNFAINT``
  Disable faint style.

``CMCM_UNITALIC``
  Disable italic style.

``CMCM_UNUNDERLINE``
  Disable underline style.

``CMCM_UNBLINK``
  Disable blink style.

``CMCM_UNRAPID_BLINK``
  Disable rapid blink style.

``CMCM_UNINVERT``
  Disable invert style.

``CMCM_UNCONCEAL``
  Disable conceal style.

``CMCM_UNCROSSOUT``
  Disable crossout style.
#]=======================================================================]
function(colorize)
  check_color_support(VARIABLE COLOR_SUPPORT)
  if(COLOR_SUPPORT)
    set(CMCM_DEFAULT_COLORS "default=0;35:fatal_error=1;31:error=0;31:warn=0;33:info=0;32")
    if(DEFINED ENV{CMMM_COLORS})
      string(REPLACE ";" "." CMMM_COLORS "$ENV{CMMM_COLORS}")
      string(REPLACE ":" ";" CMMM_COLORS "${CMMM_COLORS}")
      string(REPLACE "=" ";" CMMM_COLORS "${CMMM_COLORS}")
    elseif(DEFINED CMMM_COLORS)
      string(REPLACE ";" "." CMMM_COLORS "${CMMM_COLORS}")
      string(REPLACE ":" ";" CMMM_COLORS "${CMMM_COLORS}")
      string(REPLACE "=" ";" CMMM_COLORS "${CMMM_COLORS}")
    endif()
    string(REPLACE ";" "." CMCM_DEFAULT_COLORS "${CMCM_DEFAULT_COLORS}")
    string(REPLACE ":" ";" CMCM_DEFAULT_COLORS "${CMCM_DEFAULT_COLORS}")
    string(REPLACE "=" ";" CMCM_DEFAULT_COLORS "${CMCM_DEFAULT_COLORS}")

    string(ASCII 27 CMCM_ESC)
    set(COLOR_TYPES "default;fatal_error;error;warn;info")
    cmake_parse_arguments(GIVEN "" "${COLOR_TYPES}" "" "${CMMM_COLORS}")
    cmake_parse_arguments(DEFAULT "" "${COLOR_TYPES}" "" "${CMCM_DEFAULT_COLORS}")
    foreach(COLOR_TYPE IN LISTS COLOR_TYPES)
      string(TOUPPER "CMCM_${COLOR_TYPE}_COLOR" CMCM_TYPE_COLOR)
      if(DEFINED GIVEN_${COLOR_TYPE})
        string(REPLACE "." ";" GIVEN_${COLOR_TYPE} "${GIVEN_${COLOR_TYPE}}")
        set(${CMCM_TYPE_COLOR} "${CMCM_ESC}[${GIVEN_${COLOR_TYPE}}m" CACHE INTERNAL "Escape sequence for ${COLOR_TYPE}")
      else()
        string(REPLACE "." ";" DEFAULT_${COLOR_TYPE} "${DEFAULT_${COLOR_TYPE}}")
        set(${CMCM_TYPE_COLOR} "${CMCM_ESC}[${DEFAULT_${COLOR_TYPE}}m" CACHE INTERNAL "Escape sequence for ${COLOR_TYPE}")
      endif()
    endforeach()
    set(CMCM_RESET_COLOR "${CMCM_ESC}[0m" CACHE INTERNAL "Escape sequence to reset color")

    # Now define 4-bits foreground and background colors
    # Foreground :
    set(CMCM_FG_BLACK "${CMCM_ESC}[30m" CACHE INTERNAL "Foreground black color")
    set(CMCM_FG_RED "${CMCM_ESC}[31m" CACHE INTERNAL "Foreground red color")
    set(CMCM_FG_GREEN "${CMCM_ESC}[32m" CACHE INTERNAL "Foreground green color")
    set(CMCM_FG_YELLOW "${CMCM_ESC}[33m" CACHE INTERNAL "Foreground yellow color")
    set(CMCM_FG_BLUE "${CMCM_ESC}[34m" CACHE INTERNAL "Foreground blue color")
    set(CMCM_FG_MAGENTA "${CMCM_ESC}[35m" CACHE INTERNAL "Foreground magenta color")
    set(CMCM_FG_CYAN "${CMCM_ESC}[36m" CACHE INTERNAL "Foreground cyan color")
    set(CMCM_FG_WHITE "${CMCM_ESC}[37m" CACHE INTERNAL "Foreground white color")
    set(CMCM_FG_BRIGHT_BLACK "${CMCM_ESC}[90m" CACHE INTERNAL "Foreground bright black color")
    set(CMCM_FG_BRIGHT_RED "${CMCM_ESC}[91m" CACHE INTERNAL "Foreground bright red color")
    set(CMCM_FG_BRIGTH_GREEN "${CMCM_ESC}[92m" CACHE INTERNAL "Foreground bright green color")
    set(CMCM_FG_BRIGHT_YELLOW "${CMCM_ESC}[93m" CACHE INTERNAL "Foreground bright yellow color")
    set(CMCM_FG_BRIGHT_BLUE "${CMCM_ESC}[94m" CACHE INTERNAL "Foreground bright blue color")
    set(CMCM_FG_BRIGHT_MAGENTA "${CMCM_ESC}[95m" CACHE INTERNAL "Foreground bright magenta color")
    set(CMCM_FG_BRIGHT_CYAN "${CMCM_ESC}[96m" CACHE INTERNAL "Foreground bright cyan color")
    set(CMCM_FG_BRIGHT_WHITE "${CMCM_ESC}[97m" CACHE INTERNAL "Foreground bright white color")
    # Background :
    set(CMCM_BG_BLACK "${CMCM_ESC}[40m" CACHE INTERNAL "Background black color")
    set(CMCM_BG_RED "${CMCM_ESC}[41m" CACHE INTERNAL "Background red color")
    set(CMCM_BG_GREEN "${CMCM_ESC}[42m" CACHE INTERNAL "Background green color")
    set(CMCM_BG_YELLOW "${CMCM_ESC}[43m" CACHE INTERNAL "Background yellow color")
    set(CMCM_BG_BLUE "${CMCM_ESC}[44m" CACHE INTERNAL "Background blue color")
    set(CMCM_BG_MAGENTA "${CMCM_ESC}[45m" CACHE INTERNAL "Background magenta color")
    set(CMCM_BG_CYAN "${CMCM_ESC}[46m" CACHE INTERNAL "Background cyan color")
    set(CMCM_BG_WHITE "${CMCM_ESC}[47m" CACHE INTERNAL "Background white color")
    set(CMCM_BG_BRIGHT_BLACK "${CMCM_ESC}[100m" CACHE INTERNAL "Background bright black color")
    set(CMCM_BG_BRIGHT_RED "${CMCM_ESC}[101m" CACHE INTERNAL "Background bright red color")
    set(CMCM_BG_BRIGTH_GREEN "${CMCM_ESC}[102m" CACHE INTERNAL "Background bright green color")
    set(CMCM_BG_BRIGHT_YELLOW "${CMCM_ESC}[103m" CACHE INTERNAL "Background bright yellow color")
    set(CMCM_BG_BRIGHT_BLUE "${CMCM_ESC}[104m" CACHE INTERNAL "Background bright blue color")
    set(CMCM_BG_BRIGHT_MAGENTA "${CMCM_ESC}[105m" CACHE INTERNAL "Background bright magenta color")
    set(CMCM_BG_BRIGHT_CYAN "${CMCM_ESC}[106m" CACHE INTERNAL "Background bright cyan color")
    set(CMCM_BG_BRIGHT_WHITE "${CMCM_ESC}[107m" CACHE INTERNAL "Background bright white color")

    # Styles :
    set(CMCM_BOLD "${CMCM_ESC}[1m" CACHE INTERNAL "Bold style")
    set(CMCM_FAINT "${CMCM_ESC}[2m" CACHE INTERNAL "Faint style")
    set(CMCM_ITALIC "${CMCM_ESC}[3m" CACHE INTERNAL "Italic style")
    set(CMCM_UNDERLINE "${CMCM_ESC}[4m" CACHE INTERNAL "Underline style")
    set(CMCM_BLINK "${CMCM_ESC}[5m" CACHE INTERNAL "Blink style")
    set(CMCM_RAPID_BLINK "${CMCM_ESC}[6m" CACHE INTERNAL "Rapid blink style")
    set(CMCM_INVERT "${CMCM_ESC}[7m" CACHE INTERNAL "Invert style")
    set(CMCM_CONCEAL "${CMCM_ESC}[8m" CACHE INTERNAL "Conceal style")
    set(CMCM_CROSSOUT "${CMCM_ESC}[9m" CACHE INTERNAL "Crossout style")
    # Complementary styles :
    set(CMCM_UNBOLD "${CMCM_ESC}[22m" CACHE INTERNAL "Disable bold style")
    set(CMCM_UNFAINT "${CMCM_ESC}[22m" CACHE INTERNAL "Disable faint style")
    set(CMCM_UNITALIC "${CMCM_ESC}[23m" CACHE INTERNAL "Disable italic style")
    set(CMCM_UNUNDERLINE "${CMCM_ESC}[24m" CACHE INTERNAL "Disable underline style")
    set(CMCM_UNBLINK "${CMCM_ESC}[25m" CACHE INTERNAL "Disable blink style")
    set(CMCM_UNRAPID_BLINK "${CMCM_ESC}[25m" CACHE INTERNAL "Disable rapid blink style")
    set(CMCM_UNINVERT "${CMCM_ESC}[27m" CACHE INTERNAL "Disable invert style")
    set(CMCM_UNCONCEAL "${CMCM_ESC}[28m" CACHE INTERNAL "Disable conceal style")
    set(CMCM_UNCROSSOUT "${CMCM_ESC}[29m" CACHE INTERNAL "Disable crossout style")
  endif()
endfunction()
