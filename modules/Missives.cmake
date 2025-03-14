#
# CMakeCM
# CMake Common Modules.
#
# SPDX-FileCopyrightText: 2024-2025 flagarde
#
# SPDX-License-Identifier: MIT
#

include(Colors)
colorize()

# CMake default message groups
if("${CMAKE_VERSION}" VERSION_GREATER "3.16.9")
  list(APPEND DEFAULT_MISSIVE_TYPES "FATAL_ERROR;SEND_ERROR;WARNING;AUTHOR_WARNING;DEPRECATION;NOTICE;STATUS;VERBOSE;DEBUG;TRACE;CHECK_START;CHECK_FAIL;CHECK_PASS")
elseif("${CMAKE_VERSION}" VERSION_GREATER "3.14.7")
  list(APPEND DEFAULT_MISSIVE_TYPES "FATAL_ERROR;SEND_ERROR;WARNING;AUTHOR_WARNING;DEPRECATION;NOTICE;STATUS;VERBOSE;DEBUG;TRACE")
else()
  list(APPEND DEFAULT_MISSIVE_TYPES "FATAL_ERROR;SEND_ERROR;WARNING;AUTHOR_WARNING;DEPRECATION;STATUS")
endif()

list(APPEND MISSIVE_TYPES ${DEFAULT_MISSIVE_TYPES})

# TODO: explain
function(missive_type)
  include(CMakeParseArguments)
  cmake_parse_arguments(ARG "" "NAME;PARENT_TYPE;STYLE;APPEND_BEGIN;APPEND_END;APPEND_STYLE;APPEND_STYLE_BEGIN;APPEND_STYLE_END" "" ${ARGN})
  if(NOT DEFINED ARG_NAME)
    message(FATAL_ERROR "${CMCM_FATAL_ERROR_COLOR}NAME is mandatory !${CMCM_RESET_STYLE}")
  endif()
  string(STRIP ${ARG_NAME} ARG_NAME)
  if(ARG_NAME STREQUAL "")
    message(FATAL_ERROR "${CMCM_FATAL_ERROR_COLOR}NAME cannot be blank !${CMCM_RESET_STYLE}")
  endif()
  string(TOUPPER ${ARG_NAME} UPPER_ARG_NAME)
  if(NOT ${ARG_NAME} STREQUAL ${UPPER_ARG_NAME})
    message(STATUS "TEST: ${ARG_NAME} ${UPPER_ARG_NAME}")
    message(FATAL_ERROR "${CMCM_FATAL_ERROR_COLOR}NAME is not an upper case word !${CMCM_RESET_STYLE}")
  endif()

  if(DEFINED ARG_STYLE)
    string(REPLACE "::" "_" ARG_STYLE "${ARG_STYLE}")
  endif()

  if(DEFINED ARG_APPEND_STYLE)
    string(REPLACE "::" "_" ARG_APPEND_STYLE "${ARG_APPEND_STYLE}")
  endif()

  if(DEFINED ARG_APPEND_STYLE_BEGIN)
    string(REPLACE "::" "_" ARG_APPEND_STYLE_BEGIN "${ARG_APPEND_STYLE_BEGIN}")
  endif()

  if(DEFINED ARG_APPEND_STYLE_END)
    string(REPLACE "::" "_" ARG_APPEND_STYLE_END "${ARG_APPEND_STYLE_END}")
  endif()

  list(APPEND MISSIVE_TYPES "${MISSIVE_TYPES}" "${UPPER_ARG_NAME}")
  list(REMOVE_DUPLICATES MISSIVE_TYPES)
  set(MISSIVE_TYPES "${MISSIVE_TYPES}" PARENT_SCOPE)

  if(NOT DEFINED ARG_PARENT_TYPE)
    # If PARENT_TYPE is not present it means :
    # -- For new Type it don't want to be the daughter or some previously defined mode.
    # -- For CMake predefined Type it's just mean it redefined it.
    list(FIND DEFAULT_MISSIVE_TYPES ${ARG_NAME} TYPE_FOUND)
    if(${TYPE_FOUND} STREQUAL "-1")
      set_property(GLOBAL PROPERTY "${ARG_NAME}_PARENT_TYPE" "")
    else()
      set_property(GLOBAL PROPERTY "${ARG_NAME}_PARENT_TYPE" "${ARG_NAME}")
    endif()
  else()
    string(STRIP ${ARG_PARENT_TYPE} ARG_PARENT_TYPE)
    list(FIND MISSIVE_TYPES ${ARG_PARENT_TYPE} TYPE_FOUND)
    if(${TYPE_FOUND} STREQUAL "-1")
      list(JOIN MISSIVE_TYPES ", " STRING_DEFAULT_MISSIVE_TYPES)
      message(FATAL_ERROR "${CMCM_FATAL_ERROR_COLOR}PARENT_TYPE must be in this list : ${STRING_DEFAULT_MISSIVE_TYPES}.${CMCM_RESET_STYLE}")
    else()
      set_property(GLOBAL PROPERTY "${ARG_NAME}_PARENT_TYPE" "${ARG_PARENT_TYPE}")
    endif()
  endif()

  if(DEFINED ARG_STYLE)
    set_property(GLOBAL PROPERTY "${ARG_NAME}_STYLE" "${ARG_STYLE}")
  else()
    get_property(STYLE GLOBAL PROPERTY "${ARG_PARENT_TYPE}_STYLE")
    set_property(GLOBAL PROPERTY "${ARG_NAME}_STYLE" "${STYLE}")
  endif()

  if(DEFINED ARG_APPEND_BEGIN)
    set_property(GLOBAL PROPERTY "${ARG_NAME}_APPEND_BEGIN" "${ARG_APPEND_BEGIN}")
  else()
    get_property(APPEND_BEGIN GLOBAL PROPERTY "${ARG_PARENT_TYPE}_APPEND_BEGIN")
    set_property(GLOBAL PROPERTY "${ARG_NAME}_APPEND_BEGIN" "${APPEND_BEGIN}")
  endif()

  if(DEFINED ARG_APPEND_END)
    set_property(GLOBAL PROPERTY "${ARG_NAME}_APPEND_END" "${ARG_APPEND_END}")
  else()
    get_property(APPEND_END GLOBAL PROPERTY "${ARG_PARENT_TYPE}_APPEND_END")
    set_property(GLOBAL PROPERTY "${ARG_NAME}_APPEND_END" "${APPEND_END}")
  endif()

  if(DEFINED ARG_APPEND_STYLE)
    set_property(GLOBAL PROPERTY "${ARG_NAME}_APPEND_STYLE_BEGIN" "${ARG_APPEND_STYLE}")
    set_property(GLOBAL PROPERTY "${ARG_NAME}_APPEND_STYLE_END" "${ARG_APPEND_STYLE}")
  else()
    if(DEFINED ARG_APPEND_STYLE_BEGIN)
      set_property(GLOBAL PROPERTY "${ARG_NAME}_APPEND_STYLE_BEGIN" "${ARG_APPEND_STYLE_BEGIN}")
    else()
      get_property(APPEND_STYLE_BEGIN GLOBAL PROPERTY "${ARG_PARENT_TYPE}_APPEND_STYLE_BEGIN")
      set_property(GLOBAL PROPERTY "${ARG_NAME}_APPEND_STYLE_BEGIN" "${APPEND_STYLE_BEGIN}")
    endif()
    if(DEFINED ARG_APPEND_STYLE_END)
      set_property(GLOBAL PROPERTY "${ARG_NAME}_APPEND_STYLE_END" "${ARG_APPEND_STYLE_END}")
    else()
      get_property(APPEND_STYLE_END GLOBAL PROPERTY "${ARG_PARENT_TYPE}_APPEND_STYLE_END")
      set_property(GLOBAL PROPERTY "${ARG_NAME}_APPEND_STYLE_END" "${APPEND_STYLE_END}")
    endif()
  endif()
endfunction()

# Restore the default TYPES
function(restore_type_to_default TYPE)
  list(FIND DEFAULT_MISSIVE_TYPES ${TYPE} TYPE_FOUND)
  if(${TYPE_FOUND} STREQUAL "-1")
    list(JOIN MISSIVE_TYPES ", " STRING_DEFAULT_MISSIVE_TYPES)
    message(WARNING "${CMCM_WARN_COLOR}Type ${TYPE} is not a CMake Type : ${STRING_DEFAULT_MISSIVE_TYPES}${CMCM_RESET_STYLE}")
  else()
    missive_type(NAME ${TYPE})
  endif()
endfunction()

# TODO: explain
function(restore_all_types_to_default)
  foreach(TYPE IN LISTS DEFAULT_MISSIVE_TYPES)
    restore_type_to_default(${TYPE})
  endforeach()
endfunction()

# This call is to register the default CMake modes
restore_all_types_to_default()

set(CMCM_TO_DEFAULT "[===CMCM::RESET::DEFAULT===]")

# TODO: explain
function(missive)
  include(CMakeParseArguments)
  if("${ARGC}" STREQUAL "0")
    message(FATAL_ERROR "${CMCM_FATAL_ERROR_COLOR}missive called with incorrect number of arguments${CMCM_RESET_STYLE}")
  endif()

  cmake_parse_arguments(ARG "" "" "" "${ARGN}")
  list(LENGTH ARG_UNPARSED_ARGUMENTS SIZE)
  if(NOT "${SIZE}" STREQUAL "0")
    list(GET ARG_UNPARSED_ARGUMENTS 0 MISSIVE_TYPE)
  endif()
  list(FIND MISSIVE_TYPES "${MISSIVE_TYPE}" MISSIVE_TYPE_FOUND)
  if(NOT "${MISSIVE_TYPE_FOUND}" STREQUAL "-1")
    list(REMOVE_AT ARG_UNPARSED_ARGUMENTS 0)
    set(START "1")
  else()
    set(START "0")
  endif()
  if("${ARGC}" GREATER "1")
    math(EXPR STOP "${ARGC}-1")
  else()
    set(STOP "${ARGC}")
  endif()

  if(NOT "${MISSIVE_TYPE_FOUND}" STREQUAL "-1")
    get_property(PARENT_TYPE GLOBAL PROPERTY "${MISSIVE_TYPE}_PARENT_TYPE")
    get_property(APPEND_BEGIN GLOBAL PROPERTY "${MISSIVE_TYPE}_APPEND_BEGIN")
    get_property(APPEND_END GLOBAL PROPERTY "${MISSIVE_TYPE}_APPEND_END")
    get_property(APPEND_STYLE_BEGIN GLOBAL PROPERTY "${MISSIVE_TYPE}_APPEND_STYLE_BEGIN")
    get_property(APPEND_STYLE_END GLOBAL PROPERTY "${MISSIVE_TYPE}_APPEND_STYLE_END")
    get_property(STYLE GLOBAL PROPERTY "${MISSIVE_TYPE}_STYLE")
    if("${STYLE}" STREQUAL "")
      set(STYLE "CMCM_RESET_STYLE")
    endif()
    foreach(VAR RANGE "${START}" "${STOP}" 1)
      string(REPLACE ";" "[==[point.virgule]==]" "VAR${VAR}" "${ARGV${VAR}}")
      set(MESSAGE ${MESSAGE} ${VAR${VAR}})
    endforeach()
    string(REPLACE ";" "" MESSAGE "${MESSAGE}")
    string(REPLACE "[==[point.virgule]==]" ";" MESSAGE "${MESSAGE}")
    string(REPLACE "${CMCM_TO_DEFAULT}" "${${STYLE}}" "MESSAGE" "${MESSAGE}")
    message(${PARENT_TYPE} ${${APPEND_STYLE_BEGIN}} ${APPEND_BEGIN}${CMCM_RESET_STYLE} ${${STYLE}} "${MESSAGE}" ${CMCM_RESET_STYLE} ${${APPEND_STYLE_END}} ${APPEND_END}${CMCM_RESET_STYLE})
  else()
    get_property(STYLE GLOBAL PROPERTY "NOTICE_STYLE")
    if("${STYLE}" STREQUAL "")
      set(STYLE "CMCM_RESET_STYLE")
    endif()
    foreach(VAR RANGE "${START}" "${STOP}" 1)
      string(REPLACE ";" "[==[point.virgule]==]" "VAR${VAR}" "${ARGV${VAR}}")
      string(REPLACE "${CMCM_TO_DEFAULT}" "${${STYLE}}" "VAR${VAR}" "${VAR${VAR}}")
      set(MESSAGE ${MESSAGE} ${VAR${VAR}})
    endforeach()
    string(REPLACE ";" "" MESSAGE "${MESSAGE}")
    string(REPLACE "[==[point.virgule]==]" ";" MESSAGE "${MESSAGE}")
    message("" "${MESSAGE}")
  endif()
endfunction()

if(NOT NOT_REDEFINE_DEFAULT_TYPES)
  missive_type(NAME "FATAL_ERROR" STYLE "CMCM::FG::BOLD::RED")
  missive_type(NAME "SEND_ERROR" STYLE "CMCM::FG::BOLD::RED")
  missive_type(NAME "WARNING" STYLE  "CMCM::FG::BOLD::YELLOW")
  missive_type(NAME "AUTHOR_WARNING" STYLE "CMCM::FG::BOLD::YELLOW")
  missive_type(NAME "DEPRECATION" STYLE "CMCM::FG::BOLD::WHITE")
endif()
