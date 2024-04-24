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
------

This module allows to detect color support on terminal and create cached variables to colorize outputs.

Functions
^^^^^^^^^

.. command:: check_color_support

Detect color support of the terminal. This function respect the NO_COLOR env variable (https://no-color.org/).

.. code-block:: cmake

  check_color_support(URL <url>)

.. cmake:variable:: VARIABLE <variable>

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

Create cached color and style variables.

.. code-block:: cmake

  colorize()

If colors are supported in terminal, create CMake cached variables containing style and colors escape sequences.

Some colors can be defined using the ``cmake:envvar::CMMM_COLORS`` (default=0;35:fatal_error=1;31:error=0;31:warn=0;33:info=0;32).

This function respect the NO_COLOR env variable (https://no-color.org/).

.. cmake:variable:: CMCM_DEFAULT_COLOR (CACHE)

  Color for default emphase.

.. cmake:variable:: CMCM_FATAL_ERROR_COLOR (CACHE)

  Color for fatal_error.

.. cmake:variable:: CMCM_ERROR_COLOR (CACHE)

  Color for error.

.. cmake:variable:: CMCM_WARN_COLOR (CACHE)

  Color for warning.

.. cmake:variable:: CMCM_INFO_COLOR (CACHE)

  Color for info.

.. cmake:variable:: CMCM_FG_BLACK (CACHE)

  Foreground black color.

.. cmake:variable:: CMCM_FG_RED (CACHE)

  Foreground red color.

.. cmake:variable:: CMCM_FG_GREEN (CACHE)

  Foreground green color.

.. cmake:variable:: CMCM_FG_YELLOW (CACHE)

  Foreground yellow color.

.. cmake:variable:: CMCM_FG_BLUE (CACHE)

  Foreground blue color.

.. cmake:variable:: CMCM_FG_MAGENTA (CACHE)

  Foreground magenta color.

.. cmake:variable:: CMCM_FG_CYAN (CACHE)

  Foreground cyan color.

.. cmake:variable:: CMCM_FG_WHITE (CACHE)

  Foreground white color.

.. cmake:variable:: CMCM_FG_BRIGHT_BLACK (CACHE)

  Foreground bright black color.

.. cmake:variable:: CMCM_FG_BRIGHT_RED (CACHE)

  Foreground bright red color.

.. cmake:variable:: CMCM_FG_BRIGTH_GREEN (CACHE)

  Foreground bright green color.

.. cmake:variable:: CMCM_FG_BRIGHT_YELLOW (CACHE)

  Foreground bright yellow color.

.. cmake:variable:: CMCM_FG_BRIGHT_BLUE (CACHE)

  Foreground bright blue color.

.. cmake:variable:: CMCM_FG_BRIGHT_MAGENTA (CACHE)

  Foreground bright magenta color.

.. cmake:variable:: CMCM_FG_BRIGHT_CYAN (CACHE)

  Foreground bright cyan color.

.. cmake:variable:: CMCM_FG_BRIGHT_WHITE (CACHE)

  Foreground bright white color.

.. cmake:variable:: CMCM_BG_BLACK (CACHE)

  Background black color.

.. cmake:variable:: CMCM_BG_RED (CACHE)

  Background red color.

.. cmake:variable:: CMCM_BG_GREEN (CACHE)

  Background green color.

.. cmake:variable:: CMCM_BG_YELLOW (CACHE)

  Background yellow color.

.. cmake:variable:: CMCM_BG_BLUE (CACHE)

  Background blue color.

.. cmake:variable:: CMCM_BG_MAGENTA (CACHE)

  Background magenta color.

.. cmake:variable:: CMCM_BG_CYAN (CACHE)

  Background cyan color.

.. cmake:variable:: CMCM_BG_WHITE (CACHE)

  Background white color.

.. cmake:variable:: CMCM_BG_BRIGHT_BLACK (CACHE)

  Background bright black color.

.. cmake:variable:: CMCM_BG_BRIGHT_RED (CACHE)

  Background bright red color.

.. cmake:variable:: CMCM_BG_BRIGTH_GREEN (CACHE)

  Background bright green color.

.. cmake:variable:: CMCM_BG_BRIGHT_YELLOW (CACHE)

  Background bright yellow color.

.. cmake:variable:: CMCM_BG_BRIGHT_BLUE (CACHE)

  Background bright blue color.

.. cmake:variable:: CMCM_BG_BRIGHT_MAGENTA (CACHE)

  Background bright magenta color.

.. cmake:variable:: CMCM_BG_BRIGHT_CYAN (CACHE)

  Background bright cyan color.

.. cmake:variable:: CMCM_BG_BRIGHT_WHITE (CACHE)

  Background bright white color.

.. cmake:variable:: CMCM_BOLD (CACHE)

  Bold style.

.. cmake:variable:: CMCM_FAINT (CACHE)

  Faint style.

.. cmake:variable:: CMCM_ITALIC (CACHE)

  Italic style.

.. cmake:variable:: CMCM_UNDERLINE (CACHE)

  Underline style.

.. cmake:variable:: CMCM_BLINK (CACHE)

  Blink style.

.. cmake:variable:: CMCM_RAPID_BLINK (CACHE)

  Rapid blink style.

.. cmake:variable:: CMCM_INVERT (CACHE)

  Invert style.

.. cmake:variable:: CMCM_CONCEAL (CACHE)

  Conceal style.

.. cmake:variable:: CMCM_CROSSOUT (CACHE)

  Crossout style.

.. cmake:variable:: CMCM_DOUBLY_UNDERLINE (CACHE)

  Doubly underline style.

.. cmake:variable:: CMCM_UNBOLD (CACHE)

  Disable bold style.

.. cmake:variable:: CMCM_UNFAINT (CACHE)

  Disable faint style.

.. cmake:variable:: CMCM_UNITALIC (CACHE)

  Disable italic style.

.. cmake:variable:: CMCM_UNUNDERLINE (CACHE)

  Disable underline style.

.. cmake:variable:: CMCM_UNDOUBLY_UNDERLINE (CACHE)

  Disable doubly underline style.

.. cmake:variable:: CMCM_UNBLINK (CACHE)

  Disable blink style.

.. cmake:variable:: CMCM_UNRAPID_BLINK (CACHE)

  Disable rapid blink style.

.. cmake:variable:: CMCM_UNINVERT (CACHE)

  Disable invert style.

.. cmake:variable:: CMCM_UNCONCEAL (CACHE)

  Disable conceal style.

.. cmake:variable:: CMCM_UNCROSSOUT (CACHE)

  Disable crossout style.

.. cmake:variable:: CMCM_RESET_STYLE (CACHE)

  Reset style and color.

.. cmake:variable:: CMCM_DEFAULT_FONT (CACHE)

  Reset to default font.

.. cmake:variable:: CMCM_FONT1 (CACHE)

  Font 1.

.. cmake:variable:: CMCM_FONT2 (CACHE)

  Font 2.

.. cmake:variable:: CMCM_FONT3 (CACHE)

  Font 3.

.. cmake:variable:: CMCM_FONT4 (CACHE)

  Font 4.

.. cmake:variable:: CMCM_FONT5 (CACHE)

  Font 5.

.. cmake:variable:: CMCM_FONT6 (CACHE)

  Font 6.

.. cmake:variable:: CMCM_FONT7 (CACHE)

  Font 7.

.. cmake:variable:: CMCM_FONT8 (CACHE)

  Font 8.

.. cmake:variable:: CMCM_FONT9 (CACHE)

  Font 9.

.. cmake:variable:: CMCM_FRAKTUR (CACHE)

  Fraktur font.

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
        set(${CMCM_TYPE_COLOR} "${CMCM_ESC}[${GIVEN_${COLOR_TYPE}}m" PARENT_SCOPE)
      else()
        string(REPLACE "." ";" DEFAULT_${COLOR_TYPE} "${DEFAULT_${COLOR_TYPE}}")
        set(${CMCM_TYPE_COLOR} "${CMCM_ESC}[${DEFAULT_${COLOR_TYPE}}m" PARENT_SCOPE)
      endif()
    endforeach()

    # ANSI escape code :
    # Styles :
    set(CMCM_RESET_STYLE "${CMCM_ESC}[0m" PARENT_SCOPE)
    set(CMCM_BOLD "${CMCM_ESC}[1m" PARENT_SCOPE)
    set(CMCM_FAINT "${CMCM_ESC}[2m" PARENT_SCOPE)
    set(CMCM_ITALIC "${CMCM_ESC}[3m" PARENT_SCOPE)
    set(CMCM_UNDERLINE "${CMCM_ESC}[4m" PARENT_SCOPE)
    set(CMCM_BLINK "${CMCM_ESC}[5m" PARENT_SCOPE)
    set(CMCM_RAPID_BLINK "${CMCM_ESC}[6m" PARENT_SCOPE)
    set(CMCM_INVERT "${CMCM_ESC}[7m" PARENT_SCOPE)
    set(CMCM_CONCEAL "${CMCM_ESC}[8m" PARENT_SCOPE)
    set(CMCM_CROSSOUT "${CMCM_ESC}[9m" PARENT_SCOPE)
    # Font :
    set(CMCM_DEFAULT_FONT "${CMCM_ESC}[10m" PARENT_SCOPE)
    set(CMCM_FONT1 "${CMCM_ESC}[11m" PARENT_SCOPE)
    set(CMCM_FONT2 "${CMCM_ESC}[12m" PARENT_SCOPE)
    set(CMCM_FONT3 "${CMCM_ESC}[13m" PARENT_SCOPE)
    set(CMCM_FONT4 "${CMCM_ESC}[14m" PARENT_SCOPE)
    set(CMCM_FONT5 "${CMCM_ESC}[15m" PARENT_SCOPE)
    set(CMCM_FONT6 "${CMCM_ESC}[16m" PARENT_SCOPE)
    set(CMCM_FONT7 "${CMCM_ESC}[17m" PARENT_SCOPE)
    set(CMCM_FONT8 "${CMCM_ESC}[18m" PARENT_SCOPE)
    set(CMCM_FONT9 "${CMCM_ESC}[19m" PARENT_SCOPE)
    set(CMCM_FRAKTUR "${CMCM_ESC}[20m" PARENT_SCOPE)
    set(CMCM_DOUBLY_UNDERLINE "${CMCM_ESC}[21m" PARENT_SCOPE)
    # Complementary styles :
    set(CMCM_UNBOLD "${CMCM_ESC}[22m" PARENT_SCOPE)
    set(CMCM_UNFAINT "${CMCM_ESC}[22m" PARENT_SCOPE)
    set(CMCM_UNITALIC "${CMCM_ESC}[23m" PARENT_SCOPE)
    set(CMCM_UNUNDERLINE "${CMCM_ESC}[24m" PARENT_SCOPE)
    set(CMCM_UNDOUBLY_UNDERLINE "${CMCM_ESC}[24m" PARENT_SCOPE)
    set(CMCM_UNBLINK "${CMCM_ESC}[25m" PARENT_SCOPE)
    set(CMCM_UNRAPID_BLINK "${CMCM_ESC}[25m" PARENT_SCOPE)
    set(CMCM_UNINVERT "${CMCM_ESC}[27m" PARENT_SCOPE)
    set(CMCM_UNCONCEAL "${CMCM_ESC}[28m" PARENT_SCOPE)
    set(CMCM_UNCROSSOUT "${CMCM_ESC}[29m" PARENT_SCOPE)
    # Foreground :
    set(CMCM_FG_BLACK "${CMCM_ESC}[30m" PARENT_SCOPE)
    set(CMCM_FG_RED "${CMCM_ESC}[31m" PARENT_SCOPE)
    set(CMCM_FG_GREEN "${CMCM_ESC}[32m" PARENT_SCOPE)
    set(CMCM_FG_YELLOW "${CMCM_ESC}[33m" PARENT_SCOPE)
    set(CMCM_FG_BLUE "${CMCM_ESC}[34m" PARENT_SCOPE)
    set(CMCM_FG_MAGENTA "${CMCM_ESC}[35m" PARENT_SCOPE)
    set(CMCM_FG_CYAN "${CMCM_ESC}[36m" PARENT_SCOPE)
    set(CMCM_FG_WHITE "${CMCM_ESC}[37m" PARENT_SCOPE)
    set(CMCM_FG_BRIGHT_BLACK "${CMCM_ESC}[90m" PARENT_SCOPE)
    set(CMCM_FG_BRIGHT_RED "${CMCM_ESC}[91m" PARENT_SCOPE)
    set(CMCM_FG_BRIGTH_GREEN "${CMCM_ESC}[92m" PARENT_SCOPE)
    set(CMCM_FG_BRIGHT_YELLOW "${CMCM_ESC}[93m" PARENT_SCOPE)
    set(CMCM_FG_BRIGHT_BLUE "${CMCM_ESC}[94m" PARENT_SCOPE)
    set(CMCM_FG_BRIGHT_MAGENTA "${CMCM_ESC}[95m" PARENT_SCOPE)
    set(CMCM_FG_BRIGHT_CYAN "${CMCM_ESC}[96m" PARENT_SCOPE)
    set(CMCM_FG_BRIGHT_WHITE "${CMCM_ESC}[97m" PARENT_SCOPE)
    # Background :
    set(CMCM_BG_BLACK "${CMCM_ESC}[40m" PARENT_SCOPE)
    set(CMCM_BG_RED "${CMCM_ESC}[41m" PARENT_SCOPE)
    set(CMCM_BG_GREEN "${CMCM_ESC}[42m" PARENT_SCOPE)
    set(CMCM_BG_YELLOW "${CMCM_ESC}[43m" PARENT_SCOPE)
    set(CMCM_BG_BLUE "${CMCM_ESC}[44m" PARENT_SCOPE)
    set(CMCM_BG_MAGENTA "${CMCM_ESC}[45m" PARENT_SCOPE)
    set(CMCM_BG_CYAN "${CMCM_ESC}[46m" PARENT_SCOPE)
    set(CMCM_BG_WHITE "${CMCM_ESC}[47m" PARENT_SCOPE)
    set(CMCM_BG_BRIGHT_BLACK "${CMCM_ESC}[100m" PARENT_SCOPE)
    set(CMCM_BG_BRIGHT_RED "${CMCM_ESC}[101m" PARENT_SCOPE)
    set(CMCM_BG_BRIGTH_GREEN "${CMCM_ESC}[102m" PARENT_SCOPE)
    set(CMCM_BG_BRIGHT_YELLOW "${CMCM_ESC}[103m" PARENT_SCOPE)
    set(CMCM_BG_BRIGHT_BLUE "${CMCM_ESC}[104m" PARENT_SCOPE)
    set(CMCM_BG_BRIGHT_MAGENTA "${CMCM_ESC}[105m" PARENT_SCOPE)
    set(CMCM_BG_BRIGHT_CYAN "${CMCM_ESC}[106m" PARENT_SCOPE)
    set(CMCM_BG_BRIGHT_WHITE "${CMCM_ESC}[107m" PARENT_SCOPE)
  endif()
endfunction()
