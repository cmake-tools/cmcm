#
# CMakeCM
# CMake Common Modules.
#
# SPDX-FileCopyrightText: 2024 flagarde
#
# SPDX-License-Identifier: MIT
#
cmake_policy(VERSION ${CMAKE_VERSION})

include(SetupModulesList)

include(Missives)

# message and missive give error if called without argument
# FATAL_ERROR and SEND_ERROR are not tested here

message(STATUS "======= Test WARNING =========")
message(WARNING)
missive(WARNING)
message("WARNING")
missive("WARNING")
message(WARNING "")
missive(WARNING "")
message(WARNING "Test")
missive(WARNING "Test")
message(WARNING "Test" "Test")
missive(WARNING "Test" "Test")
message(STATUS "==============================\n")

message(STATUS "==== Test AUTHOR_WARNING =====")
message(AUTHOR_WARNING)
missive(AUTHOR_WARNING)
message("AUTHOR_WARNING")
missive("AUTHOR_WARNING")
message(AUTHOR_WARNING "")
missive(AUTHOR_WARNING "")
message(AUTHOR_WARNING "Test")
missive(AUTHOR_WARNING "Test")
message(AUTHOR_WARNING "Test" "Test")
missive(AUTHOR_WARNING "Test" "Test")
message(STATUS "==============================\n")

message(STATUS "==== Test DEPRECATION =====")
message(DEPRECATION)
missive(DEPRECATION)
message("DEPRECATION")
missive("DEPRECATION")
message(DEPRECATION "")
missive(DEPRECATION "")
message(DEPRECATION "Test")
missive(DEPRECATION "Test")
message(DEPRECATION "Test" "Test")
missive(DEPRECATION "Test" "Test")
message(STATUS "==============================\n")

message(STATUS "==== Test NOTICE =====")
message(NOTICE)
missive(NOTICE)
message("NOTICE")
missive("NOTICE")
message(NOTICE "")
missive(NOTICE "")
message(NOTICE "Test")
missive(NOTICE "Test")
message(NOTICE "Test" "Test")
missive(NOTICE "Test" "Test")
message("")
missive("")
message("Test")
missive("Test")
message("Test" "Test")
missive("Test" "Test")
message(STATUS "==============================\n")

message(STATUS "==== Test STATUS =====")
message(STATUS)
missive(STATUS)
message("STATUS")
missive("STATUS")
message(STATUS "")
missive(STATUS "")
message(STATUS "Test")
missive(STATUS "Test")
message(STATUS "Test" "Test")
missive(STATUS "Test" "Test")
message(STATUS "==============================\n")

message(STATUS "==== Test VERBOSE =====")
message(VERBOSE)
missive(VERBOSE)
message("VERBOSE")
missive("VERBOSE")
message(VERBOSE "")
missive(VERBOSE "")
message(VERBOSE "Test")
missive(VERBOSE "Test")
message(VERBOSE "Test" "Test")
missive(VERBOSE "Test" "Test")
message(STATUS "==============================\n")

message(STATUS "==== Test DEBUG =====")
message(DEBUG)
missive(DEBUG)
message("DEBUG")
missive("DEBUG")
message(DEBUG "")
missive(DEBUG "")
message(DEBUG "Test")
missive(DEBUG "Test")
message(DEBUG "Test" "Test")
missive(DEBUG "Test" "Test")
message(STATUS "=====================\n")

message(STATUS "==== Test TRACE =====")
message(TRACE)
missive(TRACE)
message("TRACE")
missive("TRACE")
message(TRACE "")
missive(TRACE "")
message(TRACE "Test")
missive(TRACE "Test")
message(TRACE "Test" "Test")
missive(TRACE "Test" "Test")
message(STATUS "=====================\n")

missive(ERROR "ERROR")
missive(WARN "WARN ${CMCM_FG_BLUE}BLUE${CMCM_TO_DEFAULT} YELLOW AGAIN")
missive(INFO "INFO")
missive(NOTE "NOTE")
missive(TO_REMOVE "TO_REMOVE")
missive(TO_ADD "TO_ADD")
