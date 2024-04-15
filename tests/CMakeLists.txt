#
# CMakeCM
# CMake Common Modules.
#
# SPDX-FileCopyrightText: 2024 flagarde
#
# SPDX-License-Identifier: MIT
#

# Install and set-up CMakeMM
file(GLOB_RECURSE TESTS FOLLOW_SYMLINKS LIST_DIRECTORIES false RELATIVE "${CMAKE_CURRENT_SOURCE_DIR}" "*.cmake")
foreach(TEST IN LISTS TESTS)
  message(STATUS "Addind test : ${TEST}")
  add_test(NAME "${TEST}" COMMAND "${CMAKE_COMMAND}" -P "${CMAKE_CURRENT_SOURCE_DIR}/${TEST}")
endforeach()
