#
# CMakeCM
# CMake Common Modules.
#
# SPDX-FileCopyrightText: 2024 flagarde
#
# SPDX-License-Identifier: MIT
#

# Detect color support of the terminal. This function respect the NO_COLOR env variable (https://no-color.org/).
function(check_color_support)
  # cmake-lint: disable=C0103
  include(CMakeParseArguments)
  cmake_parse_arguments(ARG "CACHE;ADVANCED" "VARIABLE" "" ${ARGN})
  if(CMAKE_VERSION VERSION_GREATER 3.23.9)
    cmake_host_system_information(RESULT ARG_VALUE QUERY WINDOWS_REGISTRY "HKCU/Console" VALUE "VirtualTerminalLevel")
  endif()
  # Check CMakeMM variables
  get_property(ARG_VALUE GLOBAL PROPERTY CMMM_NO_COLOR)
  if(ARG_VALUE)
    set(ARG_VALUE "FALSE")
  else()
    set(ARG_VALUE "TRUE")
  endif()
  if(DEFINED ENV{CLICOLOR_FORCE} AND NOT "$ENV{CLICOLOR_FORCE}" STREQUAL "0")
    set(ARG_VALUE "TRUE")
  elseif(DEFINED ENV{CLICOLOR} AND "$ENV{CLICOLOR}" STREQUAL "0")
    set(ARG_VALUE "FALSE")
  elseif(DEFINED ENV{CI} AND NOT CMMM_NO_COLOR)
    set(ARG_VALUE "TRUE")
  elseif(DEFINED ENV{DevEnvDir} OR DEFINED ENV{workspaceRoot} OR CMMM_NO_COLOR)
    set(ARG_VALUE "FALSE")
  endif()
  if(ARG_CACHE)
    set("${ARG_VARIABLE}" "${ARG_VALUE}" CACHE BOOL "Color support" FORCE)
    if(ARG_ADVANCED)
      mark_as_advanced("${ARG_VARIABLE}")
    endif()
  else()
    set("${ARG_VARIABLE}" "${ARG_VALUE}" PARENT_SCOPE)
  endif()
  # pass
endfunction()
