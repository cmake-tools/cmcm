#
# CMakeCM
# CMake Common Modules.
#
# SPDX-FileCopyrightText: 2024-2025 flagarde
#
# SPDX-License-Identifier: MIT
#

add_test(NAME SetupModulesList.cmake COMMAND "${CMAKE_COMMAND}" -L -P "${CMAKE_CURRENT_SOURCE_DIR}/SetupModulesList.cmake")

file(GLOB_RECURSE TESTS FOLLOW_SYMLINKS LIST_DIRECTORIES false RELATIVE "${CMAKE_CURRENT_SOURCE_DIR}" "*.cmake")
list(REMOVE_ITEM TESTS "SetupModulesList.cmake")
foreach(TEST IN LISTS TESTS)
  message(STATUS "Addind test : ${TEST}")
  add_test(NAME "${TEST}" COMMAND "${CMAKE_COMMAND}" --log-level TRACE -L -Werror=dev -Werror=deprecated -D "CMAKE_MODULE_PATH:PATH=${CMAKE_CURRENT_SOURCE_DIR}" -P "${CMAKE_CURRENT_SOURCE_DIR}/${TEST}")
endforeach()
