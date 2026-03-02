#
# CMakeCM
# CMake Common Modules.
#
# SPDX-FileCopyrightText: 2024-2026 flagarde
#
# SPDX-License-Identifier: MIT
#

#[=======================================================================[.rst:
CPM
---

Download and incudle CPM.cmake

Functions
^^^^^^^^^

.. command:: cpm

Download and include CPM.cmake

.. code-block:: cmake

  cpm([SHALLOW] [PROGRESS] [EXCLUDE_FROM_ALL] [SYSTEM] [TAG <tag>] [REPOSITORY <url>])

Options
^^^^^^^

.. cmake:variable:: SHALLOW

  When this option is enabled, the git clone operation will be given the --depth 1 option.
  This performs a shallow clone, which avoids downloading the whole history and instead retrieves just the commit denoted by the GIT_TAG option.

.. cmake:variable:: PROGRESS

  When enabled, this option instructs the git clone operation to report its progress by passing it the --progress option.
  Without this option, the clone step for large projects may appear to make the build stall, since nothing will be logged until the clone operation finishes.
  While this option can be used to provide progress to prevent the appearance of the build having stalled, it may also make the build overly noisy if lots of external projects are used.

.. cmake:variable:: EXCLUDE_FROM_ALL
.. versionadded:: 3.28


  If the EXCLUDE_FROM_ALL argument is provided, then targets in the subdirectory added by FetchContent_MakeAvailable() will not be included in the ALL target by default, and may be excluded from IDE project files.
  See the documentation for the directory property EXCLUDE_FROM_ALL for a detailed discussion of the effects.

.. cmake:variable:: SYSTEM
.. versionadded:: 3.25


  If the SYSTEM argument is provided, the SYSTEM directory property of a subdirectory added by FetchContent_MakeAvailable() will be set to true.
  This will affect non-imported targets created as part of that command. See the SYSTEM target property documentation for a more detailed discussion of the effects.

.. cmake:variable:: TAG <tag>

  The git tag to download :variable:`CPM_TAG` takes precedence if defined. (v0.42.1 by default).

.. cmake:variable:: REPOSITORY <url>

  The repository to from where to download CPM.cmake :variable:`CPM_REPOSITORY` takes precedence if defined. (https://github.com/cpm-cmake/CPM.cmake.git by default).

Variables
^^^^^^^^^

:variable:`CPM_REPOSITORY`

  URL of the CPM repository to download. Takes precedence over the REPOSITORY argument.

:variable:`CPM_TAG`

  TAG of the CPM repository to download. Takes precedence over the TAG argument.

#]=======================================================================]
function(cpm)
  include(Missives)
  if("${CMAKE_VERSION}" VERSION_LESS 3.14)
    missive(FATAL_ERROR "CPM.cmake requires FetchContent only available from CMake 3.14.")
  endif()
  include(FetchContent)
  include(CMakeParseArguments)
  cmake_parse_arguments(ARG "SHALLOW;PROGRESS;EXCLUDE_FROM_ALL;SYSTEM" "TAG;REPOSITORY" "" ${ARGN})
  if(NOT DEFINED CPM_TAG)
    if(NOT DEFINED ARG_TAG)
      missive(FATAL_ERROR "Either the TAG argument or the CPM_TAG variable is mandatory.")
    endif()
  else()
    if(DEFINED ARG_TAG AND NOT CPM_TAG STREQUAL ARG_TAG)
      missive(STATUS "${CMCM_INFO_COLOR}[cmcm:cpm] TAG argument has been set to ${ARG_TAG}, but CPM_TAG will take precedence: ${CPM_TAG}")
    endif()
    set(ARG_TAG "${CPM_TAG}")
  endif()
  if(NOT DEFINED CPM_REPOSITORY)
    if(NOT DEFINED ARG_REPOSITORY)
      set(ARG_REPOSITORY "https://github.com/cpm-cmake/CPM.cmake.git")
    endif()
  else()
    if(DEFINED ARG_REPOSITORY AND NOT CPM_REPOSITORY STREQUAL ARG_REPOSITORY)
      missive(STATUS "${CMCM_INFO_COLOR}[cmcm:cpm] REPOSITORY argument has been set to ${ARG_REPOSITORY}, but CPM_REPOSITORY will take precedence: ${CPM_REPOSITORY}")
    endif()
    set(ARG_REPOSITORY "${CPM_REPOSITORY}")
  endif()
  colorize()
  set(CPM_INDENT "${CMCM_FG_CYAN}[cpm]" PARENT_SCOPE)
  ## Change default message
  function(cpm_message)
    colorize()
    message(${ARGV}${CMCM_RESET_STYLE})
  endfunction()
  if(CMAKE_VERSION VERSION_GREATER_EQUAL 3.25)
    set(SYSTEM_ARGS "SYSTEM ${ARG_SYSTEM}")
  endif()
  if(CMAKE_VERSION VERSION_GREATER_EQUAL 3.25)
    set(EXCLUDE_FROM_ALL_ARGS "EXCLUDE_FROM_ALL ${ARG_EXCLUDE_FROM_ALL}")
  endif()
  FetchContent_Declare(CPM GIT_REPOSITORY "${ARG_REPOSITORY}" GIT_TAG "${ARG_TAG}" GIT_SHALLOW "${ARG_SHALLOW}" GIT_PROGRESS "${ARG_PROGRESS}" "${SYSTEM_ARGS}" "${EXCLUDE_FROM_ALL_ARGS}")
  if(NOT COMMAND CPMAddPackage)
    missive(STATUS "${CMCM_INFO_COLOR}[cmcm:cpm] Adding cpm@${ARG_TAG} (${ARG_TAG})")
  endif()
  FetchContent_MakeAvailable(CPM)
  if(NOT COMMAND CPMAddPackage)
    missive(FATAL_ERROR "CPM.cmake not correctly included !")
  endif()
endfunction()
