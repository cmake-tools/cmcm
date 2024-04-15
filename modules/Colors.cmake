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
    cmake_host_system_information(RESULT RETURN QUERY WINDOWS_REGISTRY "HKCU/Console" VALUE "VirtualTerminalLevel")
    if("${RETURN}" STREQUAL "1")
      set(RESULT "TRUE")
    else()
      set(RESULT "FALSE")
    endif()
  endif()
  if(ARG_CACHE)
    set("${ARG_VARIABLE}" "${RETURN}" CACHE BOOL "Color support" FORCE)
    if(ARG_ADVANCED)
      mark_as_advanced("${ARG_VARIABLE}")
    endif()
  else()
    set("${ARG_VARIABLE}" "${RETURN}" PARENT_SCOPE)
  endif()
  # pass
endfunction()
